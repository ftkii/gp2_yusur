import 'package:flutter/material.dart';

class contain extends StatelessWidget {
  const contain({
    super.key,
    required this.imagePath,
    required this.imageName,
  });

  final String imagePath;
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 131,
        width: 156,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 229, 226, 222),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: Color.fromARGB(138, 154, 145, 133), width: 1)),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(5)),
            Image(
              image: AssetImage(imagePath),
              height: 50,
              width: 51,
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              imageName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 78, 78, 78),
                  fontWeight: FontWeight.w700),
            ),
          ],
        ));
  }
}
