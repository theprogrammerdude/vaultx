import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/route_manager.dart';
import 'package:uuid/uuid.dart';
import 'package:vaultx/injector.dart';
import 'package:vaultx/repos/db_repo.dart';
import 'package:vaultx/widgets/cc_form.dart';
import 'package:vaultx/widgets/ccui.dart';
import 'package:velocity_x/velocity_x.dart';

class CardInfo extends StatefulWidget {
  const CardInfo({super.key});

  @override
  State<CardInfo> createState() => _CardInfoState();
}

class _CardInfoState extends State<CardInfo> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  addCard() {
    if (formKey.currentState!.validate()) {
      var id = const Uuid().v4();

      Map<String, dynamic> data = {
        'cardNumber': cardNumber,
        'expiryDate': expiryDate,
        'cardHolderName': cardHolderName,
        'cvvCode': cvvCode,
        'id': id,
        'createdAt': DateTime.now().millisecondsSinceEpoch,
      };

      getIt<DbRepo>().addCardToInstance(data: data);
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addCard,
        label: Row(
          children: [
            const Icon(Icons.add).pOnly(right: 8),
            'ADD CARD'.text.make(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CCUI(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
            ),
            CCForm(
              formKey: formKey,
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              onCreditCardModelChange: (CreditCardModel data) {
                setState(() {
                  cardHolderName = data.cardHolderName;
                  cardNumber = data.cardNumber;
                  expiryDate = data.expiryDate;
                  cvvCode = data.cvvCode;
                });
              },
            )
          ],
        ).p12().wPCT(context: context, widthPCT: 100),
      ),
    );
  }
}
