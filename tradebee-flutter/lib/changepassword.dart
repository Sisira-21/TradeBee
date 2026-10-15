// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// import 'login.dart';
//
//
// void main() {
//   runApp( Myapp());
// }
// class Myapp extends StatelessWidget {
//   const Myapp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Mychangepassword(title: '',),
//     );
//   }
// }
//
//
// class Mychangepassword extends StatefulWidget {
//   const Mychangepassword({super.key, required this.title});
//
//   final String title;
//   @override
//   State<Mychangepassword> createState() => _MychangepasswordState();
//
// }
// class _MychangepasswordState extends State<Mychangepassword> {
//   bool obs=true;
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _currentpasswordtextController = TextEditingController();
//   final TextEditingController _newpasswordtextController = TextEditingController();
//   final TextEditingController _confirmpasswordtextController = TextEditingController();
//
//
//
//   Future<void> _sendData() async {
//     String ucurrentpassword = _currentpasswordtextController.text;
//     String unewpassword= _newpasswordtextController.text;
//     String uconfirmpassword= _confirmpasswordtextController.text;
//
//
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String? url = sh.getString('url');
//     String lid = sh.getString('lid').toString();
//
//     if (url == null) {
//       Fluttertoast.showToast(msg: "Server URL not found.");
//       return;
//     }
//
//     final uri = Uri.parse('$url/user_changep_post/');
//     var request = http.MultipartRequest('POST', uri);
//     request.fields['currentp'] = ucurrentpassword;
//     request.fields['newp'] = unewpassword;
//     request.fields['conp'] = uconfirmpassword;
//     request.fields['lid'] = lid;
//
//
//
//
//     try {
//       var response = await request.send();
//       var respStr = await response.stream.bytesToString();
//       var data = jsonDecode(respStr);
//
//       if (response.statusCode == 200 && data['status'] == 'ok') {
//         Fluttertoast.showToast(msg: "Submitted successfully.");
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>MyLogin(title: '',)));
//
//       } else {
//         Fluttertoast.showToast(msg: "Submission failed.");
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error: $e");
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         // Navigator.pushReplacement(
//         //   context,
//         //   MaterialPageRoute(builder: (context) => const BankingDashboard()),
//         // );
//         return true;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Changepassword"),
//           centerTitle: true,
//           backgroundColor: Theme.of(context).colorScheme.primary,
//           foregroundColor: Colors.white,
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//
//                 TextFormField(
//                   controller: _currentpasswordtextController,
//                   obscureText: obs,
//                   decoration: InputDecoration(
//                     labelText: 'Enter Your Currentpassword',
//                     border: OutlineInputBorder(),
//                     suffixIcon:  IconButton(onPressed: (){
//                       setState(() {
//                         obs=!obs;
//                       });
//                     }, icon: Icon(
//                         obs ? Icons.visibility_off : Icons.visibility))
//                   ),
//
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Cureentpassword is required';
//                     }
//                     return null;
//                   },
//                 ),
//
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   controller: _newpasswordtextController,
//                   obscureText: obs,
//                   decoration: InputDecoration(
//                     labelText: 'Enter Your NewPassword',
//                     border: OutlineInputBorder(),
//                       suffixIcon:  IconButton(onPressed: (){
//                         setState(() {
//                           obs=!obs;
//                         });
//                       }, icon: Icon(
//                           obs ? Icons.visibility_off : Icons.visibility))
//                   ),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'NewPassword is required';
//                     }
//                     return null;
//                   },
//                 ),const SizedBox(height: 20),
//                 TextFormField(
//                   controller: _confirmpasswordtextController,
//                   obscureText: obs,
//                   decoration:  InputDecoration(
//                     labelText: 'Enter Your ConfirmPassword',
//                     border: OutlineInputBorder(),
//                       suffixIcon:  IconButton(onPressed: (){
//                         setState(() {
//                           obs=!obs;
//                         });
//                       }, icon: Icon(
//                           obs ? Icons.visibility_off : Icons.visibility))
//                   ),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'ConfirmPassword is required';
//                     }
//                     return null;
//                   },
//                 ),
//
//
//
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _sendData();
//                     } else {
//                       Fluttertoast.showToast(msg: "Please fix errors in the form");
//                     }
//                   },
//                   child: const Text("Submit"),
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: const Size.fromHeight(50),
//                   ),
//                 ),
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'login.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Mychangepassword(
        title: '',
      ),
    );
  }
}

class Mychangepassword extends StatefulWidget {
  const Mychangepassword({super.key, required this.title});

  final String title;
  @override
  State<Mychangepassword> createState() => _MychangepasswordState();
}

class _MychangepasswordState extends State<Mychangepassword>
    with SingleTickerProviderStateMixin {
  bool obsCurrentPassword = true;
  bool obsNewPassword = true;
  bool obsConfirmPassword = true;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _currentpasswordtextController =
  TextEditingController();
  final TextEditingController _newpasswordtextController =
  TextEditingController();
  final TextEditingController _confirmpasswordtextController =
  TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _sendData() async {
    String ucurrentpassword = _currentpasswordtextController.text;
    String unewpassword = _newpasswordtextController.text;
    String uconfirmpassword = _confirmpasswordtextController.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String? url = sh.getString('url');
    String lid = sh.getString('lid').toString();

    if (url == null) {
      Fluttertoast.showToast(msg: "Server URL not found.");
      return;
    }

    final uri = Uri.parse('$url/user_changep_post/');
    var request = http.MultipartRequest('POST', uri);
    request.fields['currentp'] = ucurrentpassword;
    request.fields['newp'] = unewpassword;
    request.fields['conp'] = uconfirmpassword;
    request.fields['lid'] = lid;

    try {
      var response = await request.send();
      var respStr = await response.stream.bytesToString();
      var data = jsonDecode(respStr);

      if (response.statusCode == 200 && data['status'] == 'ok') {
        Fluttertoast.showToast(msg: "Password changed successfully.");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyLogin(
                  title: '',
                )));
      } else {
        Fluttertoast.showToast(msg: "Submission failed.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF000000),
                Color(0xFF0A1628),
                Color(0xFF000000),
              ],
            ),
          ),
          child: SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Section
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color(0xFF0D1117),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Color(0xFFFF7043).withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.arrow_back,
                                color: Color(0xFFFF7043),
                                size: 22,
                              ),
                            ).onTap(() => Navigator.pop(context)),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'CHANGE PASSWORD',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Secure your account',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF64B5F6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),

                        // Lock Icon
                        Center(
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFFF7043),
                                  Color(0xFFFF7043).withOpacity(0.7),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFFF7043).withOpacity(0.4),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.lock_reset_rounded,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        ),
                        SizedBox(height: 40),

                        // Current Password Field
                        Text(
                          'Current Password',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF8B9DC3),
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFFF7043).withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: _currentpasswordtextController,
                            obscureText: obsCurrentPassword,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Enter current password',
                              hintStyle: TextStyle(
                                color: Color(0xFF8B9DC3).withOpacity(0.5),
                              ),
                              filled: true,
                              fillColor: Color(0xFF0D1117),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xFFFF7043).withOpacity(0.3),
                                  width: 1.5,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xFFFF7043).withOpacity(0.3),
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xFFFF7043),
                                  width: 2,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xFFEF5350),
                                  width: 1.5,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Color(0xFFFF7043),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obsCurrentPassword = !obsCurrentPassword;
                                  });
                                },
                                icon: Icon(
                                  obsCurrentPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Color(0xFF8B9DC3),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Current password is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 24),

                        // New Password Field
                        Text(
                          'New Password',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF8B9DC3),
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFFF7043).withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: _newpasswordtextController,
                            obscureText: obsNewPassword,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Enter new password',
                              hintStyle: TextStyle(
                                color: Color(0xFF8B9DC3).withOpacity(0.5),
                              ),
                              filled: true,
                              fillColor: Color(0xFF0D1117),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xFFFF7043).withOpacity(0.3),
                                  width: 1.5,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xFFFF7043).withOpacity(0.3),
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xFFFF7043),
                                  width: 2,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xFFEF5350),
                                  width: 1.5,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.lock_open,
                                color: Color(0xFFFF7043),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obsNewPassword = !obsNewPassword;
                                  });
                                },
                                icon: Icon(
                                  obsNewPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Color(0xFF8B9DC3),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'New password is required';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 24),

                        // Confirm Password Field
                        Text(
                          'Confirm Password',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF8B9DC3),
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFFF7043).withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: _confirmpasswordtextController,
                            obscureText: obsConfirmPassword,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Confirm new password',
                              hintStyle: TextStyle(
                                color: Color(0xFF8B9DC3).withOpacity(0.5),
                              ),
                              filled: true,
                              fillColor: Color(0xFF0D1117),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xFFFF7043).withOpacity(0.3),
                                  width: 1.5,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xFFFF7043).withOpacity(0.3),
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xFFFF7043),
                                  width: 2,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xFFEF5350),
                                  width: 1.5,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.check_circle_outline,
                                color: Color(0xFFFF7043),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    obsConfirmPassword = !obsConfirmPassword;
                                  });
                                },
                                icon: Icon(
                                  obsConfirmPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Color(0xFF8B9DC3),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != _newpasswordtextController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 40),

                        // Submit Button
                        Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFFFF7043),
                                Color(0xFFFF7043).withOpacity(0.8),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFFF7043).withOpacity(0.4),
                                blurRadius: 15,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _sendData();
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Please fix errors in the form");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'UPDATE PASSWORD',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        // Security Info
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(0xFF0D1117),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Color(0xFF1E88E5).withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Color(0xFF64B5F6),
                                size: 20,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Use a strong password with at least 6 characters',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF8B9DC3),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension WidgetExtension on Widget {
  Widget onTap(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: this,
    );
  }
}