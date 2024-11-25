import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/auth/loginScreen.dart';
import 'package:firebase/utils/toastmessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Signupscreen extends StatefulWidget {
  @override
  State<Signupscreen> createState() => SignupscreenState();
}

class SignupscreenState extends State<Signupscreen> {
  bool loading = false;
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final _formfield = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              'Sign Up',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                  key: _formfield,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: emailcontroller,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.alternate_email)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: passwordcontroller,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Password', prefixIcon: Icon(Icons.lock)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter password';
                          }
                          return null;
                        },
                      ),
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formfield.currentState!.validate()) {
                            setState(() {
                              loading = true;
                            });
                            _auth
                                .createUserWithEmailAndPassword(
                                    email: emailcontroller.text.toString(),
                                    password:
                                        passwordcontroller.text.toString())
                                .then((value) {
                              emailcontroller.clear();
                              passwordcontroller.clear();

                              // Display success message
                              Toastmessage().toastMessage('Signup Successful');
                              setState(() {
                                loading = false;
                              });
                            }).onError((error, stacktrace) {
                              Toastmessage().toastMessage(error.toString());
                              setState(() {
                                loading = false;
                              });
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: Colors.purple),
                        child: loading
                            ? CircularProgressIndicator(
                                strokeWidth: 3,
                                color: Colors.white,
                              )
                            : Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account ? "),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text('Login'))
                ],
              )
            ],
          ),
        ));
  }
}
