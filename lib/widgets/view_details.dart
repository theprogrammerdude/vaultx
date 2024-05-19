import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:vaultx/injector.dart';
import 'package:vaultx/models/pass_model.dart';
import 'package:vaultx/repos/db_repo.dart';
import 'package:vaultx/repos/pass_repo.dart';
import 'package:vaultx/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class ViewDetails extends StatefulWidget {
  const ViewDetails({super.key, required this.pass});

  final PassModel pass;

  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  final TextEditingController _url = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool isVisible = false;

  deletePass() {
    AlertDialog alert = AlertDialog(
      title: const Text('Delete Password'),
      content: const Text('Are you sure you want to delete the saved password'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            getIt<DbRepo>().deletePassword(id: widget.pass.id).then((value) {
              Get.back();
              Get.back();
            });
          },
          child: const Text('Delete'),
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (context) => alert,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool status = getIt<PassRepo>().passStatus(password: widget.pass.password);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        'Password Details'.text.xl2.bold.make().pOnly(bottom: 10),
        TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            prefixIcon: const Icon(Icons.public),
            label: 'URL'.text.make(),
          ),
          showCursor: false,
          readOnly: true,
          controller: _url..text = widget.pass.url,
        ).cornerRadius(10).pOnly(bottom: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                prefixIcon: const Icon(Icons.mail),
                label: 'Username'.text.make(),
              ),
              onTap: () {
                Utils.copyToClipboard(s: widget.pass.username).then((value) {
                  Utils.showSnackbar(msg: 'Username copied to Clipboard');
                });
              },
              showCursor: false,
              readOnly: true,
              controller: _username..text = widget.pass.username,
            ).cornerRadius(10).wPCT(context: context, widthPCT: 45),
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
              onTap: () {
                Utils.copyToClipboard(s: widget.pass.password).then((value) {
                  Utils.showSnackbar(msg: 'Password copied to Clipboard');
                });
              },
              showCursor: false,
              readOnly: true,
              obscureText: !isVisible,
              controller: _password..text = widget.pass.password,
            ).cornerRadius(10).wPCT(context: context, widthPCT: 45),
          ],
        ).pOnly(bottom: 10),
        status
            ? 'Your password is fairly secure'
                .text
                .green500
                .make()
                .pOnly(bottom: 10)
                .objectCenterRight()
            : 'Insecure password detected'
                .text
                .red500
                .make()
                .pOnly(bottom: 10)
                .objectCenterRight(),
        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Vx.red400),
          ),
          onPressed: () => deletePass(),
          icon: const Icon(
            Icons.delete_outline,
            color: Vx.red400,
          ),
          label: 'DELETE'.text.red400.make(),
        ).objectCenterRight()
      ],
    ).wPCT(context: context, widthPCT: 100).p12();
  }
}
