import 'package:gpassword/gpassword.dart';
import 'package:vaultx/repos/pass_repo.dart';

class PassMethods implements PassRepo {
  final GPassword gPass;

  PassMethods(this.gPass);

  @override
  bool passStatus({required String password}) =>
      gPass.passwordIsSecure(password: password);

  @override
  String generatePassword({int? length}) =>
      gPass.generate(passwordLength: length ?? 8);
}
