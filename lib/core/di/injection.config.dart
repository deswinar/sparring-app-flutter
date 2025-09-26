// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:flutter_sparring/core/di/register_module.dart' as _i769;
import 'package:flutter_sparring/core/network/dio_client.dart' as _i599;
import 'package:flutter_sparring/core/storage/secure_storage_service.dart'
    as _i630;
import 'package:flutter_sparring/features/auth/data/datasources/auth_local_datasource.dart'
    as _i711;
import 'package:flutter_sparring/features/auth/data/datasources/auth_remote_datasource.dart'
    as _i860;
import 'package:flutter_sparring/features/auth/data/repositories/auth_repository_impl.dart'
    as _i223;
import 'package:flutter_sparring/features/auth/domain/repositories/auth_repository.dart'
    as _i155;
import 'package:flutter_sparring/features/auth/domain/usecases/get_current_user_usecase.dart'
    as _i1063;
import 'package:flutter_sparring/features/auth/domain/usecases/login_usecase.dart'
    as _i455;
import 'package:flutter_sparring/features/auth/domain/usecases/logout_usecase.dart'
    as _i60;
import 'package:flutter_sparring/features/auth/domain/usecases/register_usecase.dart'
    as _i492;
import 'package:flutter_sparring/features/auth/presentation/blocs/auth_cubit.dart'
    as _i889;
import 'package:flutter_sparring/features/location/data/datasources/location_remote_datasource.dart'
    as _i819;
import 'package:flutter_sparring/features/location/data/repositories/location_repository_impl.dart'
    as _i540;
import 'package:flutter_sparring/features/location/domain/repositories/location_repository.dart'
    as _i583;
import 'package:flutter_sparring/features/location/domain/usecases/get_cities_by_province_usecase.dart'
    as _i62;
import 'package:flutter_sparring/features/location/domain/usecases/get_cities_usecase.dart'
    as _i497;
import 'package:flutter_sparring/features/location/domain/usecases/get_provinces_usecase.dart'
    as _i585;
import 'package:flutter_sparring/features/location/presentation/blocs/location_cubit.dart'
    as _i1007;
import 'package:flutter_sparring/features/sport_activity/data/datasources/sport_activity_remote_datasource.dart'
    as _i455;
import 'package:flutter_sparring/features/sport_activity/data/repositories/sport_activity_repository_impl.dart'
    as _i528;
import 'package:flutter_sparring/features/sport_activity/domain/repositories/sport_activity_repository.dart'
    as _i698;
import 'package:flutter_sparring/features/sport_activity/domain/usecases/create_sport_activity_usecase.dart'
    as _i677;
import 'package:flutter_sparring/features/sport_activity/domain/usecases/delete_sport_activity_usecase.dart'
    as _i956;
import 'package:flutter_sparring/features/sport_activity/domain/usecases/get_sport_activities_usecase.dart'
    as _i789;
import 'package:flutter_sparring/features/sport_activity/domain/usecases/get_sport_activity_by_id_usecase.dart'
    as _i310;
import 'package:flutter_sparring/features/sport_activity/domain/usecases/update_sport_activity_usecase.dart'
    as _i439;
import 'package:flutter_sparring/features/sport_category/data/datasources/sport_category_remote_datasource.dart'
    as _i498;
import 'package:flutter_sparring/features/sport_category/data/repositories/sport_category_repository_impl.dart'
    as _i251;
import 'package:flutter_sparring/features/sport_category/domain/repositories/sport_category_repository.dart'
    as _i57;
import 'package:flutter_sparring/features/sport_category/domain/usecases/create_sport_category_usecase.dart'
    as _i99;
import 'package:flutter_sparring/features/sport_category/domain/usecases/delete_sport_category_usecase.dart'
    as _i450;
import 'package:flutter_sparring/features/sport_category/domain/usecases/get_sport_categories_usecase.dart'
    as _i368;
import 'package:flutter_sparring/features/sport_category/domain/usecases/update_sport_category_usecase.dart'
    as _i4;
import 'package:flutter_sparring/features/sport_category/presentation/blocs/sport_category_cubit.dart'
    as _i693;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => registerModule.secureStorage,
    );
    gh.singleton<_i630.SecureStorageService>(
      () => _i630.SecureStorageServiceImpl(gh<_i558.FlutterSecureStorage>()),
    );
    gh.singleton<_i711.AuthLocalDataSource>(
      () => _i711.AuthLocalDataSourceImpl(gh<_i630.SecureStorageService>()),
    );
    gh.singleton<_i599.DioClient>(
      () => _i599.DioClient(gh<_i630.SecureStorageService>()),
    );
    gh.lazySingleton<_i361.Dio>(
      () => registerModule.dio(gh<_i599.DioClient>()),
    );
    gh.lazySingleton<_i860.AuthRemoteDataSource>(
      () => _i860.AuthRemoteDataSource.new(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i819.LocationRemoteDataSource>(
      () => _i819.LocationRemoteDataSource.new(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i498.SportCategoryRemoteDataSource>(
      () => _i498.SportCategoryRemoteDataSource.new(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i455.SportActivityRemoteDataSource>(
      () => _i455.SportActivityRemoteDataSource.new(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i57.SportCategoryRepository>(
      () => _i251.SportCategoryRepositoryImpl(
        gh<_i498.SportCategoryRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i698.SportActivityRepository>(
      () => _i528.SportActivityRepositoryImpl(
        gh<_i455.SportActivityRemoteDataSource>(),
      ),
    );
    gh.singleton<_i155.AuthRepository>(
      () => _i223.AuthRepositoryImpl(
        gh<_i860.AuthRemoteDataSource>(),
        gh<_i711.AuthLocalDataSource>(),
      ),
    );
    gh.factory<_i1063.GetCurrentUserUseCase>(
      () => _i1063.GetCurrentUserUseCase(gh<_i155.AuthRepository>()),
    );
    gh.factory<_i455.LoginUseCase>(
      () => _i455.LoginUseCase(gh<_i155.AuthRepository>()),
    );
    gh.factory<_i60.LogoutUseCase>(
      () => _i60.LogoutUseCase(gh<_i155.AuthRepository>()),
    );
    gh.factory<_i492.RegisterUseCase>(
      () => _i492.RegisterUseCase(gh<_i155.AuthRepository>()),
    );
    gh.lazySingleton<_i583.LocationRepository>(
      () => _i540.LocationRepositoryImpl(gh<_i819.LocationRemoteDataSource>()),
    );
    gh.factory<_i889.AuthCubit>(
      () => _i889.AuthCubit(
        gh<_i455.LoginUseCase>(),
        gh<_i492.RegisterUseCase>(),
        gh<_i60.LogoutUseCase>(),
        gh<_i1063.GetCurrentUserUseCase>(),
      ),
    );
    gh.factory<_i368.GetSportCategoriesUseCase>(
      () => _i368.GetSportCategoriesUseCase(gh<_i57.SportCategoryRepository>()),
    );
    gh.factory<_i99.CreateSportCategoryUsecase>(
      () => _i99.CreateSportCategoryUsecase(gh<_i57.SportCategoryRepository>()),
    );
    gh.factory<_i450.DeleteSportCategoryUsecase>(
      () =>
          _i450.DeleteSportCategoryUsecase(gh<_i57.SportCategoryRepository>()),
    );
    gh.factory<_i4.UpdateSportCategoryUsecase>(
      () => _i4.UpdateSportCategoryUsecase(gh<_i57.SportCategoryRepository>()),
    );
    gh.factory<_i677.CreateSportActivityUsecase>(
      () =>
          _i677.CreateSportActivityUsecase(gh<_i698.SportActivityRepository>()),
    );
    gh.factory<_i956.DeleteSportActivityUsecase>(
      () =>
          _i956.DeleteSportActivityUsecase(gh<_i698.SportActivityRepository>()),
    );
    gh.factory<_i789.GetSportActivitiesUseCase>(
      () =>
          _i789.GetSportActivitiesUseCase(gh<_i698.SportActivityRepository>()),
    );
    gh.factory<_i310.GetSportActivityByIdUseCase>(
      () => _i310.GetSportActivityByIdUseCase(
        gh<_i698.SportActivityRepository>(),
      ),
    );
    gh.factory<_i439.UpdateSportActivityUsecase>(
      () =>
          _i439.UpdateSportActivityUsecase(gh<_i698.SportActivityRepository>()),
    );
    gh.factory<_i62.GetCitiesByProvinceUseCase>(
      () => _i62.GetCitiesByProvinceUseCase(gh<_i583.LocationRepository>()),
    );
    gh.factory<_i497.GetCitiesUseCase>(
      () => _i497.GetCitiesUseCase(gh<_i583.LocationRepository>()),
    );
    gh.factory<_i585.GetProvincesUseCase>(
      () => _i585.GetProvincesUseCase(gh<_i583.LocationRepository>()),
    );
    gh.factory<_i693.SportCategoryCubit>(
      () => _i693.SportCategoryCubit(gh<_i368.GetSportCategoriesUseCase>()),
    );
    gh.factory<_i1007.LocationCubit>(
      () => _i1007.LocationCubit(
        gh<_i585.GetProvincesUseCase>(),
        gh<_i497.GetCitiesUseCase>(),
        gh<_i62.GetCitiesByProvinceUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i769.RegisterModule {}
