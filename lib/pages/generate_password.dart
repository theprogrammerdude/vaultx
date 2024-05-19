import 'package:auto_size_text/auto_size_text.dart';
import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vaultx/injector.dart';
import 'package:vaultx/repos/pass_repo.dart';
import 'package:vaultx/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class GeneratePassword extends StatefulWidget {
  const GeneratePassword({super.key});

  @override
  State<GeneratePassword> createState() => _GeneratePasswordState();
}

class _GeneratePasswordState extends State<GeneratePassword> {
  int len = 8;

  @override
  Widget build(BuildContext context) {
    String genPass = getIt<PassRepo>().generatePassword(length: len);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        'GENERATED PASSWORD'.text.bold.xl2.make(),
        GestureDetector(
          onTap: () {
            Utils.copyToClipboard(s: 'Password copied to Clipboard');
          },
          child: AutoSizeText(
            genPass,
            maxLines: 2,
            minFontSize: 18,
            style: const TextStyle(fontSize: 24),
          ),
        ),
        'Tap on the password to copy'.text.gray400.make().pOnly(bottom: 20),
        CartStepperInt(
          size: 50,
          value: len,
          didChangeCount: (int value) {
            if (value > 0) {
              setState(() {
                len = value;
              });
            } else {
              Utils.showSnackbar(msg: 'Password length can\'t be less than 0');
            }
          },
        )
      ],
    ).wPCT(context: context, widthPCT: 100).p12();
  }
}
