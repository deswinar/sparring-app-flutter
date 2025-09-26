import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparring/features/sport_category/presentation/blocs/sport_category_cubit.dart';
import 'package:flutter_sparring/shared/widgets/app_loader.dart';

// Usage
// BlocProvider(
//   create: (context) => getIt<SportCategoryCubit>()..loadCategories(),
//   child: SportCategorySelector(
//     onSelected: (id) {},
//   ),
// ),

class SportCategorySelector extends StatelessWidget {
  final Function(int categoryId)? onSelected;

  const SportCategorySelector({super.key, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SportCategoryCubit, SportCategoryState>(
      builder: (context, state) {
        if (state is SportCategoryLoading) {
          return const Center(child: AppLoader(size: 100));
        } else if (state is SportCategoryError) {
          return Center(
            child: Text(
              state.message,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        } else if (state is SportCategoryLoaded) {
          final categories = state.categories;
          final selected = state.selected;

          return SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category == selected;

                return GestureDetector(
                  onTap: () {
                    context.read<SportCategoryCubit>().selectCategory(category);
                    onSelected?.call(category.id);
                  },
                  child: Card(
                    elevation: isSelected ? 6 : 2,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).dividerColor,
                        width: 1.5,
                      ),
                    ),
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.center,
                      child: Text(
                        category.name,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                              fontWeight:
                                  isSelected ? FontWeight.bold : FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
