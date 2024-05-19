abstract class StoreRepo {
  Future<void> setUsePin({required bool usePin});
  bool get usePin;
}
