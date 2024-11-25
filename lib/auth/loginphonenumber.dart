import 'package:firebase/auth/verifyphone.dart';
import 'package:firebase/utils/toastmessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Loginphonenumber extends StatefulWidget {
  const Loginphonenumber({super.key});

  @override
  State<Loginphonenumber> createState() => _LoginphonenumberState();
}

class _LoginphonenumberState extends State<Loginphonenumber> {
  final phoneNumbercontroller = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Center(
          child: Text(
            'Login',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: phoneNumbercontroller,
              decoration: InputDecoration(hintText: '+1 234 3456 432'),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        auth.verifyPhoneNumber(
                            phoneNumber: phoneNumbercontroller.text,
                            verificationCompleted: (_) {},
                            verificationFailed: (e) {
                              Toastmessage().toastMessage(e.toString());
                            },
                            codeSent: (String verification, int? index) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Verifyphone(
                                            verificationid: '',
                                          )));
                            },
                            codeAutoRetrievalTimeout: (e) {});
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
