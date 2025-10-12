import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparring/features/sport_category/presentation/blocs/sport_category_cubit.dart';
import 'package:flutter_sparring/shared/widgets/app_loader.dart';

/// A horizontal list of sport categories represented as chips.
///
/// Automatically handles selection state through [SportCategoryCubit].
/// Example usage:
///
/// ```dart
/// BlocProvider(
///   create: (context) => getIt<SportCategoryCubit>()..loadCategories(),
///   child: SportCategorySelector(
///     onSelected: (id) {},
///   ),
/// )
/// ```
class SportCategorySelector extends StatelessWidget {
  final Function(int categoryId)? onSelected;

  const SportCategorySelector({super.key, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SportCategoryCubit, SportCategoryState>(
      builder: (context, state) {
        if (state is SportCategoryLoading) {
          return const Center(child: AppLoader(size: 80));
        }

        if (state is SportCategoryError) {
          return Center(
            child: Text(
              state.message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
          );
        }

        if (state is SportCategoryLoaded) {
          final categories = state.categories;
          final selected = state.selected;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: List.generate(categories.length, (index) {
                final category = categories[index];
                final isSelected = category == selected;

                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(
                      category.name,
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
                    selected: isSelected,
                    selectedColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    backgroundColor:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    onSelected: (_) {
                      context.read<SportCategoryCubit>().selectCategory(category);
                      onSelected?.call(category.id);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: BorderSide(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Colors.transparent,
                      ),
                    ),
                    pressElevation: 0,
                    visualDensity: VisualDensity.compact,
                  ),
                );
              }),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
