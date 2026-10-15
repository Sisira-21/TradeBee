//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
//
// import 'login.dart';
// import 'main.dart';
//
// void main() {
//   runApp(const MaterialApp(
//     home: forgot_password(title: 'Login'),
//     debugShowCheckedModeBanner: true,
//
//   ));
// }
//
// class forgot_password extends StatefulWidget {
//   const forgot_password({super.key, required this.title});
//   final String title;
//
//   @override
//   State<forgot_password> createState() => _forgot_passwordState();
// }
//
// class _forgot_passwordState extends State<forgot_password> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   bool _isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const MyLogin(title: '')),
//         );
//         return false;
//       },
//       child: Scaffold(
//         backgroundColor: const Color(0xFFEFF3FF),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Top banner
//               Stack(
//                 children: [
//                   Container(
//                     height: 180,
//                     decoration: const BoxDecoration(
//                       color: Color(0xFF45A005),
//                       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
//                     ),
//                   ),
//                   const Positioned(
//                     top: 100,
//                     left: 20,
//                     child: Text(
//                       'forgot password?',
//                       style: TextStyle(
//                         fontSize: 32,
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 40),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       // Email Field
//                       TextFormField(
//                         controller: _emailController,
//                         keyboardType: TextInputType.emailAddress,
//                         decoration: InputDecoration(
//                           labelText: "Email",
//                           hintText: "Enter your email",
//                           prefixIcon: const Icon(Icons.email),
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Email is required';
//                           }
//                           if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
//                             return 'Enter a valid email';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 20),
//
//                       // Password Field
//
//
//                       // Forgot Password
//
//                       const SizedBox(height: 20),
//
//                       // Login Button
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: _isLoading ? null : _sendData,
//                           style: ElevatedButton.styleFrom(
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                             backgroundColor: Colors.orange[300],
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           child: _isLoading
//                               ? const CircularProgressIndicator(color: Colors.white)
//                               : const Text("Submit", style: TextStyle(fontSize: 16)),
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//
//                       // Divider
//
//                       // Signup Buttons
//
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _sendData() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() => _isLoading = true);
//
//     String email = _emailController.text.trim();
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//
//     final urls = Uri.parse('$url/android_forget_password_post/');
//     try {
//       final response = await http.post(urls, body: {
//         'email': email,
//       });
//       setState(() => _isLoading = false);
//
//       if (response.statusCode == 200) {
//         var body = jsonDecode(response.body);
//         String status = body['status'];
//         if (status == 'ok') {
//
//
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => MyLogin(title: '')));
//             Fluttertoast.showToast(msg: 'Password sent to you mail');
//
//         }
//         else {
//           _showSnackBar('Invalid email or password');
//         }
//       } else {
//         _showSnackBar('Network Error');
//       }
//     } catch (e) {
//       setState(() => _isLoading = false);
//       _showSnackBar('Error: $e');
//     }
//   }
//

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message), backgroundColor: Colors.red),
//     );
//   }
// }


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'login.dart';
import 'main.dart';

void main() {
  runApp(const MaterialApp(
    home: forgot_password(title: 'Login'),
    debugShowCheckedModeBanner: false,
  ));
}

class forgot_password extends StatefulWidget {
  const forgot_password({super.key, required this.title});
  final String title;

  @override
  State<forgot_password> createState() => _forgot_passwordState();
}

class _forgot_passwordState extends State<forgot_password>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyLogin(title: '')),
        );
        return false;
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),

                    // ── Logo Section ──────────────────────────────────
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF1E88E5),
                            Color(0xFF1565C0),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1E88E5).withOpacity(0.4),
                            blurRadius: 40,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.lock_reset_rounded,
                        size: 54,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // ── Brand Name ────────────────────────────────────
                    const Text(
                      'TradeBee',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 4,
                        shadows: [
                          Shadow(
                            color: Color(0x801E88E5),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'ACCOUNT RECOVERY',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF64B5F6),
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 36),

                    // ── Info Bar (mirrors login stats bar) ────────────
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D1117),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF1E88E5).withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildInfoItem(
                              Icons.email_outlined, 'Email Reset'),
                          Container(
                            height: 28,
                            width: 1,
                            color: const Color(0xFF1E88E5).withOpacity(0.3),
                          ),
                          _buildInfoItem(
                              Icons.timer_outlined, 'Instant Send'),
                          Container(
                            height: 28,
                            width: 1,
                            color: const Color(0xFF1E88E5).withOpacity(0.3),
                          ),
                          _buildInfoItem(
                              Icons.verified_user_outlined, 'Secure'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 36),

                    // ── Main Card ─────────────────────────────────────
                    Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D1117),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF1E88E5).withOpacity(0.3),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1E88E5).withOpacity(0.15),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Card title
                            const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Enter your email to receive your password',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF8B9DC3),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 32),

                            // ── Email Field Label ─────────────────────
                            const Text(
                              'EMAIL ADDRESS',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF64B5F6),
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // ── Email Field ───────────────────────────
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Enter your email',
                                hintStyle: const TextStyle(
                                  color: Color(0xFF4A5568),
                                ),
                                prefixIcon: const Icon(
                                  Icons.email_outlined,
                                  color: Color(0xFF1E88E5),
                                ),
                                filled: true,
                                fillColor: const Color(0xFF000000),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 18,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF1E3A52)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF1E3A52),
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF1E88E5),
                                    width: 2,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFEF5350),
                                    width: 1.5,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFEF5350),
                                    width: 2,
                                  ),
                                ),
                                errorStyle: const TextStyle(
                                  color: Color(0xFFEF5350),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email is required';
                                }
                                if (!RegExp(r'\S+@\S+\.\S+')
                                    .hasMatch(value)) {
                                  return 'Enter a valid email';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 32),

                            // ── Submit Button ─────────────────────────
                            Container(
                              height: 56,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF1E88E5),
                                    Color(0xFF1565C0),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF1E88E5)
                                        .withOpacity(0.5),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed:
                                _isLoading ? null : _sendData,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: _isLoading
                                    ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    valueColor:
                                    AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )
                                    : const Text(
                                  'SEND PASSWORD',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 28),

                            // ── Divider ───────────────────────────────
                            Row(
                              children: const [
                                Expanded(
                                  child: Divider(
                                    color: Color(0xFF1E3A52),
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    'OR',
                                    style: TextStyle(
                                      color: Color(0xFF4A5568),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Color(0xFF1E3A52),
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 28),

                            // ── Back to Login ─────────────────────────
                            SizedBox(
                              height: 56,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const MyLogin(title: '')),
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: Color(0xFF1E88E5),
                                    width: 2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'BACK TO SIGN IN',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF64B5F6),
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // ── Footer ────────────────────────────────────────
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock_outline,
                          size: 14,
                          color: Color(0xFF4A5568),
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Bank-grade Security & 256-bit Encryption',
                          style: TextStyle(
                            color: Color(0xFF4A5568),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF64B5F6), size: 20),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF4A5568),
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _sendData() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    String email = _emailController.text.trim();

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();

    final urls = Uri.parse('$url/android_forget_password_post/');
    try {
      final response = await http.post(urls, body: {
        'email': email,
      });
      setState(() => _isLoading = false);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        String status = body['status'];
        if (status == 'ok') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const MyLogin(title: '')),
          );
          Fluttertoast.showToast(msg: 'Password sent to your mail');
        } else {
          _showSnackBar('Invalid email or password');
        }
      } else {
        _showSnackBar('Network Error');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showSnackBar('Error: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
