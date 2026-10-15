import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tradebee1/login.dart';


void main() {
  runApp( Myapp());
}
class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Myip(title: '',),
    );
  }
}


class Myip extends StatefulWidget {
  const Myip({super.key, required this.title});

  final String title;
  @override
  State<Myip> createState() => _MyipState();

}
class _MyipState extends State<Myip> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _UsernametextController = TextEditingController();





  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const BankingDashboard()),
        // );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Ip"),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [

                TextFormField(
                  controller: _UsernametextController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Your IP',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'ip is required';
                    }
                    return null;
                  },
                ),


                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      SharedPreferences sh=await SharedPreferences.getInstance();
                      sh.setString('url', "http://${_UsernametextController.text}:8000/myapp");
                      sh.setString('img_url', "http://${_UsernametextController.text}:8000");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) =>  MyLogin(title: 'login')),
                      );
                      

                    } else {
                      Fluttertoast.showToast(msg: "Please fix errors in the form");
                    }
                  },
                  child: const Text("Submit"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
