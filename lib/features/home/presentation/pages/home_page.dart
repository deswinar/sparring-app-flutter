import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sparring/features/home/presentation/widgets/home_activity_list.dart';
import 'package:flutter_sparring/features/home/presentation/widgets/home_filter_section.dart';
import 'package:flutter_sparring/features/sport_activity/domain/usecases/get_sport_activities_usecase.dart';
import 'package:flutter_sparring/features/sport_activity/presentation/blocs/sport_activity_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? _selectedCityId;
  int? _selectedCategoryId;
  int _currentPage = 1;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  String? _searchQuery;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    // Cancel previous timer
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() => _searchQuery = query.isEmpty ? null : query);
      _reloadActivities();
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      _loadMoreActivities();
    }
  }

  void _reloadActivities() {
    _currentPage = 1;
    final params = GetSportActivitiesParams(
      page: _currentPage,
      perPage: 10,
      cityId: _selectedCityId,
      sportCategoryId: _selectedCategoryId,
      search: _searchQuery,
    );

    context.read<SportActivityCubit>().loadActivities(
          params: params,
          refresh: true,
        );
  }

  void _loadMoreActivities() {
    final cubit = context.read<SportActivityCubit>();
    final state = cubit.state;

    if (state is SportActivityLoaded && state.hasMore && !state.isLoadingMore) {
      final params = GetSportActivitiesParams(
        page: state.currentPage,
        perPage: 10,
        cityId: _selectedCityId,
        sportCategoryId: _selectedCategoryId,
        search: _searchQuery,
      );
      cubit.loadMore(params);
    }
  }

  @override
  Widget build(BuildContext context) {
    const double filtersHeight = 480; // increased to fit filters + search

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => _reloadActivities(),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              pinned: true,
              elevation: 2,
              expandedHeight: filtersHeight,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: const Text('🏠 Home'),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.none, // prevents weird collapsing
                background: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeFilterSection(
                          onCitySelected: (cityId) {
                            setState(() => _selectedCityId = cityId);
                            _reloadActivities();
                          },
                          onCategorySelected: (categoryId) {
                            setState(() => _selectedCategoryId = categoryId);
                            _reloadActivities();
                          },
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      _searchController.clear();
                                      setState(() => _searchQuery = null);
                                      _reloadActivities();
                                    },
                                  )
                                : null,
                            hintText: 'Search activities...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            isDense: true,
                          ),
                          onChanged: _onSearchChanged,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Container(
                  height: 1,
                  color: Colors.grey.withValues(alpha: 0.25),
                ),
              ),
            ),
            HomeActivityList(),
          ],
        ),
      ),
    );
  }
}
