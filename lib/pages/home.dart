import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:vaultx/pages/card_details.dart';
import 'package:vaultx/pages/generate_password.dart';

import 'package:vaultx/pages/setttings.dart';
import 'package:vaultx/widgets/add_pass.dart';
import 'package:vaultx/widgets/cards_list.dart';
import 'package:vaultx/widgets/pasword_list.dart';
import 'package:velocity_x/velocity_x.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  genPass() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return const GeneratePassword();
      },
    );
  }

  addPass() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: context.mediaQuery.viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () => Get.off(() => const AddPass()),
                leading: const Icon(Icons.lock),
                title: 'Add Password'.text.make(),
              ),
              const Divider().wPCT(context: context, widthPCT: 75),
              ListTile(
                onTap: () => Get.off(() => const CardInfo()),
                leading: const Icon(Icons.credit_card),
                title: 'Add Credit/Debit Card'.text.make(),
              ),
            ],
          ).p12(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: 'VaultX'.text.make(),
          actions: [
            IconButton(
              onPressed: genPass,
              icon: const Icon(Icons.key),
            ),
            // IconButton(
            //   onPressed: () {
            //     Get.to(() => const Search());
            //   },
            //   icon: const Icon(Icons.search),
            // ),
            IconButton(
              onPressed: () {
                Get.to(() => const Settings());
              },
              icon: const Icon(Icons.settings),
            ),
          ],
          bottom: TabBar(tabs: [
            Tab(child: 'Password'.text.make()),
            Tab(child: 'Cards'.text.make()),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => addPass(),
          child: const Icon(Icons.add),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            PasswordList(),
            CardsList(),
          ],
        ),
      ),
    );
  }
}
