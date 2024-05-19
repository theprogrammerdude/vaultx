import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:vaultx/injector.dart';
import 'package:vaultx/pages/home.dart';
import 'package:vaultx/pages/setttings.dart';
import 'package:vaultx/pin_theme.dart';
import 'package:vaultx/repos/secure_storage_repo.dart';
import 'package:velocity_x/velocity_x.dart';

class Pin extends StatefulWidget {
  const Pin({super.key, this.isUpdate = false});

  final bool? isUpdate;

  @override
  State<Pin> createState() => _PinState();
}

class _PinState extends State<Pin> {
  final _pin = TextEditingController();
  bool isFirstTime = false;

  validatePin() async {
    if (_pin.text.isNotEmptyAndNotNull) {
      if (isFirstTime) {
        getIt<SecureStorageRepo>().setSecurePin(pin: _pin.text);

        VxToast.show(
          context,
          msg: 'New pin set successfully',
          bgColor: Colors.white,
          textColor: Colors.black,
        );

        Get.offAll(() => const Home());
      } else {
        bool isPinCorrect =
            await getIt<SecureStorageRepo>().checkPin(_pin.text);

        if (isPinCorrect) {
          Get.offAll(() => const Home());
        } else {
          if (mounted) {
            VxToast.show(
              context,
              msg: 'Security pin doesn\'t match',
              bgColor: Colors.red,
              textColor: Colors.white,
            );
          }
        }
      }
    } else {
      VxToast.show(
        context,
        position: VxToastPosition.top,
        msg: 'Please enter security pin',
        bgColor: Colors.white,
        textColor: Colors.black,
      );
    }
  }

  updatePin() {
    if (_pin.text.isNotEmptyAndNotNull) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update Pin'),
            content:
                const Text('Are you sure you want to update the security pin?'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  getIt<SecureStorageRepo>().updatePin(pin: _pin.text);
                  Get.off(() => const Settings());
                },
                child: const Text('Yes'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    getIt<SecureStorageRepo>().openedFirstTime().then((value) {
      isFirstTime = value;
      setState(() {});
    });

    super.initState();
  }

  forgotPin() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: context.mediaQuery.viewInsets,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                'Forgot Pin'.text.xl2.make(),
                'Enter new pin to update'.text.gray400.make(),
                Pinput(
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  controller: _pin,
                  obscureText: true,
                ).pOnly(bottom: 20, top: 15),
                ElevatedButton(
                  onPressed: updatePin,
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          context.primaryColor.darken())),
                  child: 'Update Pin'.text.white.make(),
                ).wPCT(context: context, widthPCT: 100),
              ],
            ).wPCT(context: context, widthPCT: 100).p12(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isUpdate! ? AppBar() : null,
      floatingActionButton: !widget.isUpdate!
          ? FloatingActionButton.extended(
              onPressed: validatePin,
              label: const Icon(Icons.arrow_forward),
            )
          : FloatingActionButton.extended(
              onPressed: updatePin,
              label: 'Update'.text.make(),
            ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/vault.png', height: 250),
                'VaultX'.text.xl3.bold.make(),
                isFirstTime
                    ? 'Set a Secure Pin'.text.xl.bold.make()
                    : !widget.isUpdate!
                        ? 'Enter Secure Pin'.text.xl.bold.make()
                        : 'Update Secure Pin'.text.xl.bold.make(),
                const SizedBox(height: 25),
                Pinput(
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  controller: _pin,
                  obscureText: true,
                ),
                const SizedBox(height: 25),
                !widget.isUpdate!
                    ? OutlinedButton(
                        onPressed: forgotPin,
                        child: 'Forgot Pin'.text.make(),
                      )
                    : const SizedBox(height: 0)
              ],
            ).p12(),
          ),
        ),
      ),
    );
  }
}
