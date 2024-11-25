import 'package:flutter/material.dart';

class Verifyphone extends StatefulWidget {
  final String verificationid;
  Verifyphone({super.key, required this.verificationid});

  @override
  State<Verifyphone> createState() => _VerifyphoneState();
}

class _VerifyphoneState extends State<Verifyphone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify'),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
