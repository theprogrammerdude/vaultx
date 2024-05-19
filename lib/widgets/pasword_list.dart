import 'package:flutter/material.dart';
import 'package:vaultx/injector.dart';
import 'package:vaultx/models/pass_model.dart';
import 'package:vaultx/repos/db_repo.dart';
import 'package:vaultx/widgets/view_tile.dart';
import 'package:velocity_x/velocity_x.dart';

class PasswordList extends StatelessWidget {
  const PasswordList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(milliseconds: 500))
          .asyncMap((event) => getIt<DbRepo>().getAllPasswords()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data![index];
                    PassModel pass = PassModel.fromMap(data);

                    return ViewTile(pass: pass);
                  },
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/empty.png'),
                      'No Cards saved yet'.text.xl.bold.make(),
                    ],
                  ),
                );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
