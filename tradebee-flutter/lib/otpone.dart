import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:telephony/telephony.dart';

import 'otp2.dart';


class PhonePage extends StatefulWidget {
  @override
  _PhonePageState createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  final TextEditingController phoneController = TextEditingController();
  final Telephony telephony = Telephony.instance;

  String generatedOtp = "";

  void sendOTP() async {
    generatedOtp = (100000 + Random().nextInt(900000)).toString();

    await telephony.sendSms(
      to: phoneController.text,
      message: "Your OTP is $generatedOtp",
    );

    Fluttertoast.showToast(msg: "Generated otp is "+generatedOtp);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtpPage(
          otp: generatedOtp,
          phone: phoneController.text,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    telephony.requestSmsPermissions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Phone Number')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: "Phone Number"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: sendOTP,
              child: Text("Send OTP"),
            ),
          ],
        ),
      ),
    );
  }
}