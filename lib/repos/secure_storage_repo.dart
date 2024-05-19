abstract class SecureStorageRepo {
  Future<bool> openedFirstTime();
  setSecurePin({required String pin});
  Future<String?> get getSecurePin;
  Future<bool> checkPin(String pin);
  updatePin({required String pin});
}
