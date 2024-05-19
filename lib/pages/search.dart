import 'package:flutter/material.dart';
import 'package:vaultx/injector.dart';
import 'package:vaultx/models/pass_model.dart';
import 'package:vaultx/repos/db_repo.dart';
import 'package:vaultx/widgets/view_tile.dart';
import 'package:velocity_x/velocity_x.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => SearchState();
}

class SearchState extends State<Search> {
  final TextEditingController _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                filled: true,
                prefixIcon: Icon(Icons.search_rounded),
                hintText: 'Search for Passwords',
              ),
              controller: _search,
            ).cornerRadius(10).pOnly(bottom: 10),
            StreamBuilder(
              stream: Stream.periodic(
                const Duration(milliseconds: 500),
              ).asyncMap(
                (event) => getIt<DbRepo>().search(search: _search.text),
              ),
              builder: (context, snapshot) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    PassModel pass = PassModel.fromMap(snapshot.data![index]);

                    return ViewTile(pass: pass);
                  },
                );
              },
            ).hPCT(context: context, heightPCT: 90),
          ],
        ).p12(),
      ),
    );
  }
}
