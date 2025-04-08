import 'package:flutter/material.dart';
import 'campaign.dart';

class SignInVerify extends StatelessWidget {
  const SignInVerify({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(51, 154, 145, 133),
          title: Center(
            child: Text(
              "Sign in",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Verify OTP",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Please enter the code we send you to email"),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Color.fromARGB(138, 154, 145, 133), width: 1)),
                  padding: EdgeInsets.all(10),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Color.fromARGB(138, 154, 145, 133), width: 1)),
                  padding: EdgeInsets.all(10),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Color.fromARGB(138, 154, 145, 133), width: 1)),
                  padding: EdgeInsets.all(10),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Color.fromARGB(138, 154, 145, 133), width: 1)),
                  padding: EdgeInsets.all(10),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text("Didn't Receive OTP ?"),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 175, 165, 152),
                  fixedSize: Size(150, 30)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInVerify()));
              },
              child: Text(
                "Resent Code ",
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 175, 165, 152),
                  fixedSize: Size(357, 60)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Campaign()));
              },
              child: Text(
                "Verify",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            )
          ]),
        ));
  }
}
