import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparring/core/routing/app_router.dart';
import 'package:flutter_sparring/features/sport_activity/presentation/blocs/sport_activity_cubit.dart';
import 'package:flutter_sparring/features/sport_activity/presentation/widgets/sport_activity_card.dart';
import 'package:flutter_sparring/shared/widgets/app_loader.dart';

class HomeActivityList extends StatelessWidget {
  const HomeActivityList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SportActivityCubit, SportActivityState>(
      builder: (context, state) {
        if (state is SportActivityLoading || state is SportActivityRefreshing) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: AppLoader()),
          );
        }

        if (state is SportActivityError) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: Text("Error: ${state.failure.message}")),
          );
        }

        if (state is SportActivityLoaded) {
          if (state.activities.isEmpty) {
            return const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(child: Text("No activities found")),
            );
          }

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == state.activities.length) {
                  return Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(child: AppLoader()),
                  );
                }

                final activity = state.activities[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: SportActivityCard(
                    activity: activity,
                    onTap: () {
                      SportActivityDetailRoute(id: activity.id).push(context);
                    },
                  ),
                );
              },
              childCount: state.hasMore
                  ? state.activities.length + 1
                  : state.activities.length,
            ),
          );
        }

        return const SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: Text("Select filters to see activities")),
        );
      },
    );
  }
}
