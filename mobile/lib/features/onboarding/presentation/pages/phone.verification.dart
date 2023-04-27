import 'package:flutter/material.dart';

class PhoneNumberVerificationPage extends StatefulWidget {
  final String phoneNumber;
  const PhoneNumberVerificationPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<PhoneNumberVerificationPage> createState() => _PhoneNumberVerificationPageState();
}

class _PhoneNumberVerificationPageState extends State<PhoneNumberVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
