import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:vaultx/injector.dart';
import 'package:vaultx/models/card_model.dart';
import 'package:vaultx/repos/db_repo.dart';
import 'package:vaultx/widgets/ccui.dart';
import 'package:velocity_x/velocity_x.dart';

class CardsList extends StatefulWidget {
  const CardsList({
    super.key,
  });

  @override
  State<CardsList> createState() => _CardsListState();
}

class _CardsListState extends State<CardsList> {
  deleteCard(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete saved card?'),
          content: const Text('Are you sure you want to delete saved card?'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                getIt<DbRepo>().deleteCard(id: id).then((value) {
                  Get.back();
                  Get.back();
                });
              },
              child: const Text('Yes'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(milliseconds: 500))
          .asyncMap((event) => getIt<DbRepo>().getAllCards()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data!.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data![index];
                    CardModel card = CardModel.fromMap(data);

                    return GestureDetector(
                      onLongPress: () {
                        showModalBottomSheet(
                          context: context,
                          showDragHandle: true,
                          builder: (context) {
                            return ListTile(
                              onTap: () => deleteCard(card.id),
                              leading: const Icon(Icons.delete),
                              title: 'Delete Card'.text.make(),
                            ).p12();
                          },
                        );
                      },
                      child: CCUI(
                        cardNumber: card.cardNumber,
                        expiryDate: card.expiryDate,
                        cardHolderName: card.cardHolderName,
                        cvvCode: card.cvvCode,
                      ),
                    );
                  },
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/empty.png'),
                      'No Passwords saved yet'.text.xl.bold.make(),
                    ],
                  ),
                );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
