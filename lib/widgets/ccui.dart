import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CCUI extends StatefulWidget {
  const CCUI({
    super.key,
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.cvvCode,
  });

  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;

  @override
  State<CCUI> createState() => _CCUIState();
}

class _CCUIState extends State<CCUI> {
  bool isCvvFocused = false;

  @override
  Widget build(BuildContext context) {
    return CreditCardWidget(
      cardNumber: widget.cardNumber,
      expiryDate: widget.expiryDate,
      cardHolderName: widget.cardHolderName,
      cvvCode: widget.cvvCode,
      enableFloatingCard: true,
      glassmorphismConfig: Glassmorphism.defaultConfig(),
      isHolderNameVisible: true,
      obscureInitialCardNumber: true,
      showBackView: isCvvFocused,
      onCreditCardWidgetChange: (CreditCardBrand brand) {},
      isSwipeGestureEnabled: true,
    );
  }
}
