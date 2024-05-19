import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:steel_crypt/steel_crypt.dart';
import 'package:vaultx/repos/secure_storage_repo.dart';

class SecureStore implements SecureStorageRepo {
  final FlutterSecureStorage secureStorage;
  final String hashedPinString = 'hashedPin';

  SecureStore({required this.secureStorage});

  @override
  Future<String?> get getSecurePin async =>
      await secureStorage.read(key: hashedPinString);

  @override
  Future<bool> openedFirstTime() async {
    bool firstRun = await IsFirstRun.isFirstRun();
    return firstRun;
  }

  @override
  setSecurePin({required String pin}) async {
    var hasher = HashCrypt(algo: HashAlgo.Sha_256);
    String hashedPin = hasher.hash(inp: pin);

    await secureStorage.write(key: hashedPinString, value: hashedPin);
    return;
  }

  @override
  Future<bool> checkPin(String pin) async {
    var hashedPin = await getSecurePin;
    var hasher = HashCrypt(algo: HashAlgo.Sha_256);

    return hasher.check(plain: pin, hashed: hashedPin!);
  }

  @override
  updatePin({required String pin}) async {
    var hasher = HashCrypt(algo: HashAlgo.Sha_256);
    String hashedPin = hasher.hash(inp: pin);

    await secureStorage.write(key: hashedPinString, value: hashedPin);
    return;
  }
}
