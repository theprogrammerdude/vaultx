import 'package:get_storage/get_storage.dart';
import 'package:vaultx/repos/store_repo.dart';

class Store implements StoreRepo {
  final GetStorage box;

  Store({required this.box});

  @override
  Future<void> setUsePin({required bool usePin}) => box.write('usePin', usePin);

  @override
  bool get usePin => box.read('usePin') ?? true;
}
