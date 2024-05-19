import 'package:flutter/material.dart';
import 'package:vaultx/models/pass_model.dart';
import 'package:vaultx/utils.dart';
import 'package:vaultx/widgets/view_details.dart';
import 'package:velocity_x/velocity_x.dart';

class ViewTile extends StatefulWidget {
  const ViewTile({super.key, required this.pass});

  final PassModel pass;

  @override
  State<ViewTile> createState() => _ViewTileState();
}

class _ViewTileState extends State<ViewTile> {
  final String faviconBaseUrl = 'http://www.google.com/s2/favicons?domain=';

  showDetails() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return ViewDetails(pass: widget.pass);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => showDetails(),
      leading: Image.network(
        '$faviconBaseUrl${widget.pass.url}',
      ),
      title: widget.pass.url.text.make(),
      subtitle: widget.pass.username.text.gray400.make(),
      trailing: IconButton(
        onPressed: () async {
          Utils.copyToClipboard(s: widget.pass.password).then((value) {
            Utils.showSnackbar(msg: 'Password copied to Clipboard');
          });
        },
        icon: const Icon(Icons.copy),
      ),
    );
  }
}
