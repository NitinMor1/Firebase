import 'package:firebase/utils/toastmessage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Postscreen extends StatefulWidget {
  const Postscreen({super.key});

  @override
  State<Postscreen> createState() => _PostscreenState();
}

class _PostscreenState extends State<Postscreen> {
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  final postcontroller = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Post Screen',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextFormField(
              maxLines: 4,
              controller: postcontroller,
              decoration: InputDecoration(
                  hintText: 'What is in your mind ?',
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          loading = true;
                        });
                        String id =
                            DateTime.now().microsecondsSinceEpoch.toString();
                        databaseRef.child(id).set({
                          'id': id,
                          'title': postcontroller.text.toString(),
                        }).then((_) {
                          setState(() {
                            loading = false;
                          });
                          Navigator.pop(context);
                          Toastmessage()
                              .toastMessage('Data Added Successffully');
                          print('Data added successfully');
                        }).catchError((error) {
                          setState(() {
                            loading = false;
                          });
                          print('Failed to add data: $error');
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: loading
                          ? CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Colors.white,
                            )
                          : Text(
                              'Add',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
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
