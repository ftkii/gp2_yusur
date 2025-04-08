import 'package:flutter/material.dart';

import 'package:yusur_app/Screens/Home_page.dart';

class ArrowIcon extends StatelessWidget {
  const ArrowIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xffffD9D9D9), width: 1),
        color: Color.fromARGB(255, 241, 238, 238),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: Icon(Icons.arrow_forward, color: Colors.black),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
      ),
    );
  }
}
