import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yusur_app/Screens/Home_page.dart';
import 'package:yusur_app/Screens/Login_page.dart';
import 'package:yusur_app/widget/PilgrimProvider.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //يتأكد انه تمت عمليه الانشلايز قبل مايسوي رن
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
  _loadFontsInBackground();
}

Future<void> _loadFontsInBackground() async {
  // First load essential fonts
  await _loadFont('Uthmanic', 'assets/fonts/uthmanic_shuba_v20.ttf');

  // load QCF fonts in batches
  for (int i = 1; i <= 604; i++) {
    final fontNumber = i.toString().padLeft(3, '0');
    final fontFamily = 'QCF_P$fontNumber';
    final fontPath = 'assets/fonts/QCF2BSMLfonts/QCF2$fontNumber.TTF';

    // Load in batches of 20 with small delay between
    if (i % 20 == 0) {
      await _loadFont(fontFamily, fontPath);
      await Future.delayed(const Duration(milliseconds: 30));
    } else {
      // Load without waiting
      _loadFont(fontFamily, fontPath);
    }
  }
}

Future<void> _loadFont(String fontFamily, String fontPath) async {
  try {
    final loader = FontLoader(fontFamily)..addFont(rootBundle.load(fontPath));
    await loader.load();
    debugPrint('Loaded font: $fontFamily');
  } catch (e) {
    debugPrint('Error loading $fontFamily: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
