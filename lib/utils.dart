import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';

class Utils {
  Utils._();

  static copyToClipboard({required String s}) async {
    return await Clipboard.setData(ClipboardData(text: s));
  }

  static showSnackbar({required String msg}) {
    return GetSnackBar(
      message: msg,
      duration: const Duration(seconds: 2),
    ).show();
  }
}
