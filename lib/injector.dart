import 'package:flutter_mimir/flutter_mimir.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gpassword/gpassword.dart';
import 'package:vaultx/methods/db.dart';
import 'package:vaultx/methods/pass_methods.dart';
import 'package:vaultx/methods/secure_store.dart';
import 'package:vaultx/methods/store.dart';
import 'package:vaultx/repos/db_repo.dart';
import 'package:vaultx/repos/pass_repo.dart';
import 'package:vaultx/repos/secure_storage_repo.dart';
import 'package:vaultx/repos/store_repo.dart';

var getIt = GetIt.instance;
final GPassword gPassword = GPassword();

const secureStorage = FlutterSecureStorage(
  aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ),
);

final box = GetStorage();

init() {
  getIt.registerSingleton<DbRepo>(Db(Mimir.defaultInstance));
  getIt.registerSingleton<PassRepo>(PassMethods(gPassword));
  getIt.registerSingleton<SecureStorageRepo>(
      SecureStore(secureStorage: secureStorage));
  getIt.registerSingleton<StoreRepo>(Store(box: box));
}
