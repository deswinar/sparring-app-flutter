import 'package:injectable/injectable.dart';
import 'objectbox_store.dart';

@module
abstract class ObjectBoxModule {
  @preResolve
  @singleton
  Future<ObjectBoxStore> provideObjectBox() async {
    return await ObjectBoxStore.create();
  }
}