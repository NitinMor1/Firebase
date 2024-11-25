import 'package:firebase/auth/loginScreen.dart';
import 'package:firebase/utils/toastmessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                  Toastmessage().toastMessage("Log out Successfully");
                }).onError(
                  (error, stackTrace) {
                    Toastmessage().toastMessage(error.toString());
                  },
                );
              },
              icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: Text('Home Screen'),
    );
  }
}
