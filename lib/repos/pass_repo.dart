abstract class PassRepo {
  bool passStatus({required String password});
  String generatePassword({int? length});
}
