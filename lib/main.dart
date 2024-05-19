import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaultx/injector.dart';
import 'package:vaultx/pages/home.dart';
import 'package:vaultx/pages/pin.dart';
import 'package:vaultx/repos/store_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Vault X',
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.dark(
        scheme: FlexScheme.green,
        useMaterial3: true,
        fontFamily: GoogleFonts.ubuntuMono().fontFamily,
      ),
      home: getIt<StoreRepo>().usePin ? const Pin() : const Home(),
    );
  }
}
