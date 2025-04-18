import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yusur_app/Screens/Home_page.dart';
import 'package:yusur_app/Screens/Login_page.dart';
import 'package:yusur_app/widget/PilgrimProvider.dart';
import 'dart:io';

import 'Screens/campaign.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //يتأكد انه تمت عمليه الانشلايز قبل مايسوي رن
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: Campaign(),
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
