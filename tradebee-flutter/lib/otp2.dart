import 'package:flutter/material.dart';
import 'package:tradebee1/signup.dart';

class OtpPage extends StatefulWidget {
  final String otp;
  final String phone;

  OtpPage({required this.otp, required this.phone});

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController otpController = TextEditingController();

  void verifyOTP() {
    if (otpController.text == widget.otp) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP Verified")),
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => MySignup(title: 'login'),
        //   ),
        // );
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MySignup(title: 'login'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid OTP")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter OTP')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("OTP sent to ${widget.phone}"),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Enter OTP"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: verifyOTP,
              child: Text("Verify"),
            ),
          ],
        ),
      ),
    );
  }
}