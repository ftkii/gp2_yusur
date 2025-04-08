import 'package:flutter/material.dart';
import 'package:yusur_app/widget/arrow.dart';

class support extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Support",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16, top: 16),
            child: ArrowIcon(),
          ),
        ],
      ),
      body: Container(
        //  الخلفية هنا
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/wallepaper.png'),
            fit: BoxFit.cover,
          ),
        ),

        ////
        child: SingleChildScrollView(
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              const SizedBox(height: 60),
              Container(
                width: 299,
                height: 168,
                decoration: BoxDecoration(
                  color: const Color(0xFFB7AD9F),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Image.asset(
                          'images/Vector1.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 70.0, left: 10.0),
                      child: Text(
                        " We are delighted to hear from you. Feel free to\n reach out to us for any details or support. \n\n Please leave your comments, and we will get\n back to you as soon as possible.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text("\t You email address"),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 220, 213, 202)),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text("\t The subject"),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0x9A918566)),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      maxLines: 3,
                      decoration: const InputDecoration(
                        label: Text("Problem Description"),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0x9A918566)),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFB7AD9F),
                        padding:
                            EdgeInsets.symmetric(horizontal: 110, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: const Text(
                        "Send",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
