import 'objectbox.g.dart';

class ObjectBoxStore {
  late final Store store;

  ObjectBoxStore._create(this.store);

  static Future<ObjectBoxStore> create() async {
    final store = await openStore(); // automatically chooses docs dir on mobile
    return ObjectBoxStore._create(store);
  }

  Box<T> box<T>() => store.box<T>();

  void close() => store.close();
}