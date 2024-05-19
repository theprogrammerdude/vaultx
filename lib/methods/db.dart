import 'package:flutter_mimir/flutter_mimir.dart';
import 'package:vaultx/repos/db_repo.dart';

class Db implements DbRepo {
  final Future<MimirInstance> instance;

  String passwordIdx = 'passwords';
  String cardIdx = 'cards';

  Db(this.instance);

  @override
  addPasswordsToInstance({required Map<String, dynamic> data}) async {
    var inst = await instance;
    final index = inst.getIndex(passwordIdx);
    await index.addDocument(data);
  }

  @override
  getAllPasswords() async {
    var inst = await instance;
    final index = inst.getIndex(passwordIdx);
    return await index.getAllDocuments();
  }

  @override
  Future<void> deletePassword({required String id}) async {
    var inst = await instance;
    final index = inst.getIndex(passwordIdx);
    await index.deleteDocument(id);
  }

  @override
  search({required String search}) async {
    var inst = await instance;
    final index = inst.getIndex(passwordIdx);
    return await index.search(query: search);
  }

  @override
  Future<void> addCardToInstance({required Map<String, dynamic> data}) async {
    var inst = await instance;
    final index = inst.getIndex(cardIdx);
    await index.addDocument(data);
  }

  @override
  Future<List<Map<String, dynamic>>> getAllCards() async {
    var inst = await instance;
    final index = inst.getIndex(cardIdx);
    return await index.getAllDocuments();
  }

  @override
  Future<void> deleteCard({required String id}) async {
    var inst = await instance;
    final index = inst.getIndex(cardIdx);
    await index.deleteDocument(id);
  }
}
