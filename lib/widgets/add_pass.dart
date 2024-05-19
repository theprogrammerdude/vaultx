import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:vaultx/injector.dart';
import 'package:vaultx/repos/db_repo.dart';
import 'package:velocity_x/velocity_x.dart';

class AddPass extends StatefulWidget {
  const AddPass({super.key});

  @override
  State<AddPass> createState() => _AddPassState();
}

class _AddPassState extends State<AddPass> {
  final TextEditingController _url = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool isVisible = false;

  savePass() {
    var id = const Uuid().v4();

    if (_key.currentState!.validate()) {
      Map<String, dynamic> data = {
        'id': id,
        'username': _username.text.trim(),
        'url': _url.text.trim(),
        'password': _password.text.trim(),
        'createdAt': DateTime.now().millisecondsSinceEpoch,
      };

      getIt<DbRepo>().addPasswordsToInstance(data: data);
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: 'Add new Password'.text.make()),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: savePass,
        label: 'SAVE PASSWORD'.text.make(),
      ),
      body: Form(
        key: _key,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                prefixIcon: const Icon(Icons.public),
                label: 'URL'.text.make(),
              ),
              controller: _url,
              validator: (value) {
                if (value == null) {
                  return null;
                }

                if (!value.startsWith("https://")) {
                  value = "https://$value";
                }

                if (!value.startsWith("https://www.") &&
                    !value.startsWith("https://")) {
                  value = "https://www.${value.substring(8)}";
                }

                if (Uri.parse(value).host.isEmpty) {
                  return "Please type a valid url";
                }

                return null;
              },
            ).cornerRadius(10).pOnly(bottom: 10),
            TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                prefixIcon: const Icon(Icons.mail),
                label: 'Username / Email Address'.text.make(),
              ),
              controller: _username,
              validator: (value) => value!.isEmpty
                  ? 'Please enter a valid email or username'
                  : null,
            ).cornerRadius(10).pOnly(bottom: 10),
            TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                prefixIcon: const Icon(Icons.lock),
                label: 'Password'.text.make(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  icon: !isVisible
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                ),
              ),
              obscureText: !isVisible,
              controller: _password,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a valid password' : null,
            ).cornerRadius(10).pOnly(bottom: 10),
          ],
        ).wPCT(context: context, widthPCT: 100).p12(),
      ),
    );
  }
}
