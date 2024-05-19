import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:vaultx/injector.dart';
import 'package:vaultx/pages/pin.dart';
import 'package:vaultx/repos/store_repo.dart';
import 'package:velocity_x/velocity_x.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  showPinOption() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Use Secure Pin'),
          content:
              const Text('Do you want to use secure pin while logging in?'),
          actions: [
            TextButton(
              onPressed: () {
                !getIt<StoreRepo>().usePin
                    ? Get.back()
                    : getIt<StoreRepo>()
                        .setUsePin(usePin: false)
                        .then((value) => Get.back());
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                getIt<StoreRepo>().usePin
                    ? Get.back()
                    : getIt<StoreRepo>()
                        .setUsePin(usePin: true)
                        .then((value) => Get.back());
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Column(
                children: [
                  ListTile(
                    onTap: () => Get.to(() => const Pin(isUpdate: true)),
                    leading: const Icon(Icons.lock),
                    title: 'Update Security Pin'.text.make(),
                  ),
                  const Divider()
                      .pSymmetric(v: 5)
                      .wPCT(context: context, widthPCT: 75),
                  ListTile(
                    onTap: showPinOption,
                    leading: const Icon(Icons.password),
                    title: 'Use Pin'.text.make(),
                  ),
                ],
              ).p4(),
            ),
          ],
        ).p12(),
      ),
    );
  }
}
