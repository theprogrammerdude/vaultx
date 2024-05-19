import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:velocity_x/velocity_x.dart';

class CCForm extends StatefulWidget {
  const CCForm(
      {super.key,
      required this.formKey,
      required this.cardNumber,
      required this.expiryDate,
      required this.cardHolderName,
      required this.cvvCode,
      required this.onCreditCardModelChange});

  final GlobalKey<FormState> formKey;
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final Function(CreditCardModel) onCreditCardModelChange;

  @override
  State<CCForm> createState() => _CCFormState();
}

var inputConfig = const InputConfiguration(
  cardNumberDecoration: InputDecoration(
    border: OutlineInputBorder(),
    labelText: 'Number',
    hintText: 'XXXX XXXX XXXX XXXX',
  ),
  expiryDateDecoration: InputDecoration(
    border: OutlineInputBorder(),
    labelText: 'Expired Date',
    hintText: 'XX/XX',
  ),
  cvvCodeDecoration: InputDecoration(
    border: OutlineInputBorder(),
    labelText: 'CVV',
    hintText: 'XXX',
  ),
  cardHolderDecoration: InputDecoration(
    border: OutlineInputBorder(),
    labelText: 'Card Holder',
  ),
  cardNumberTextStyle: TextStyle(color: Colors.white),
  cardHolderTextStyle: TextStyle(color: Colors.white),
  expiryDateTextStyle: TextStyle(color: Colors.white),
  cvvCodeTextStyle: TextStyle(color: Colors.white),
);

class _CCFormState extends State<CCForm> {
  @override
  Widget build(BuildContext context) {
    return CreditCardForm(
      formKey: widget.formKey,
      cardNumber: widget.cardNumber,
      expiryDate: widget.expiryDate,
      cardHolderName: widget.cardHolderName,
      cvvCode: widget.cvvCode,
      expiryDateValidator: (String? expiryDate) {
        if (expiryDate.isEmptyOrNull) {
          return 'Please enter valid date';
        }

        return null;
      },
      cvvValidator: (String? cvv) {
        if (cvv.isEmptyOrNull) {
          return 'Please enter valid CVV';
        }

        return null;
      },
      cardNumberValidator: (String? cardNumber) {
        if (cardNumber.isEmptyOrNull) {
          return 'Please enter valid number';
        }

        return null;
      },
      onCreditCardModelChange: widget.onCreditCardModelChange,
      obscureCvv: true,
      inputConfiguration: inputConfig,
    );
  }
}
