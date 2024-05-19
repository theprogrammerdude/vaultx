abstract class DbRepo {
  Future<void> addPasswordsToInstance({required Map<String, dynamic> data});
  Future<List<Map<String, dynamic>>> getAllPasswords();
  Future<void> deletePassword({required String id});
  Future<List<Map<String, dynamic>>> search({required String search});

  Future<void> addCardToInstance({required Map<String, dynamic> data});
  Future<List<Map<String, dynamic>>> getAllCards();
  Future<void> deleteCard({required String id});
}
