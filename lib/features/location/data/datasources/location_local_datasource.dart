import 'package:flutter_sparring/core/storage/objectbox/objectbox.g.dart';
import 'package:flutter_sparring/features/location/data/local_models/city_objectbox_model.dart';
import 'package:flutter_sparring/features/location/data/local_models/province_objectbox_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/storage/objectbox/objectbox_store.dart';
import '../../domain/entities/city_entity.dart';
import '../../domain/entities/province_entity.dart';

@lazySingleton
class LocationLocalDataSource {
  final ObjectBoxStore _store;

  LocationLocalDataSource(this._store);

  // ======================
  // Province operations
  // ======================

  Future<void> cacheProvinces(List<ProvinceEntity> provinces) async {
    final box = _store.box<ProvinceObjectBoxModel>();
    final models = provinces.map(ProvinceObjectBoxModel.fromEntity).toList();
    box.putMany(models, mode: PutMode.put); // insert or replace
  }

  Future<List<ProvinceEntity>> getCachedProvinces() async {
    final box = _store.box<ProvinceObjectBoxModel>();
    final models = box.getAll();
    return models.map((m) => m.toEntity()).toList();
  }

  Future<void> clearProvinces() async {
    _store.box<ProvinceObjectBoxModel>().removeAll();
  }

  // ======================
  // City operations
  // ======================

  Future<void> cacheCities(List<CityEntity> cities) async {
    final cityBox = _store.box<CityObjectBoxModel>();
    final provinceBox = _store.box<ProvinceObjectBoxModel>();

    final models = <CityObjectBoxModel>[];

    for (final entity in cities) {
      // 1. Find province model by API ID
      final province = provinceBox
          .query(ProvinceObjectBoxModel_.apiId.equals(entity.provinceId))
          .build()
          .findFirst();

      if (province != null) {
        // 2. Create city model linked to this province objectbox
        final city = CityObjectBoxModel.fromEntity(entity, province.id);
        models.add(city);
      }
    }

    if (models.isNotEmpty) {
      cityBox.putMany(models, mode: PutMode.put);
    }
  }

  Future<List<CityEntity>> getCachedCities() async {
    final box = _store.box<CityObjectBoxModel>();
    final models = box.getAll();
    return models.map((m) => m.toEntity()).toList();
  }

  Future<List<CityEntity>> getCachedCitiesByProvince(int provinceApiId) async {
    final cityBox = _store.box<CityObjectBoxModel>();
    final provinceBox = _store.box<ProvinceObjectBoxModel>();

    // 1. Find province by API ID
    final province = provinceBox
        .query(ProvinceObjectBoxModel_.apiId.equals(provinceApiId))
        .build()
        .findFirst();

    if (province == null) return [];

    // 2. Query cities linked to that province objectbox
    final query = cityBox.query(CityObjectBoxModel_.province.equals(province.id)).build();
    final models = query.find();
    query.close();

    return models.map((m) => m.toEntity()).toList();
  }

  Future<void> clearCities() async {
    _store.box<CityObjectBoxModel>().removeAll();
  }
}
