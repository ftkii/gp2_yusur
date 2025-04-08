import 'package:flutter/material.dart';
import 'package:quran/quran.dart' as quran;
import 'package:flutter/services.dart';

class HeaderWidget extends StatelessWidget {
  final dynamic e;
  final dynamic jsonData;

  const HeaderWidget({Key? key, required this.e, required this.jsonData})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Image.asset(
            "images/quranImages/Surah.png",
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 5,
            left: 0,
            right: 0,
            child: Text(
              "${quran.getSurahNameArabic(e["surah"])}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
