// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// import 'Userhome.dart';
// import 'signup.dart';
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
//       home: MyLogin(title: '',),
//     );
//   }
// }
//
//
// class MyLogin extends StatefulWidget {
//   const MyLogin({super.key, required this.title});
//
//   final String title;
//   @override
//   State<MyLogin> createState() => _MyLoginState();
//
// }
// class _MyLoginState extends State<MyLogin> {
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _UsernametextController = TextEditingController();
//   final TextEditingController _passwordtextController = TextEditingController();
//
//
//
//   Future<void> _sendData() async {
//     String uUsername = _UsernametextController.text;
//     String upassword= _passwordtextController.text;
//
//
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String? url = sh.getString('url');
//
//     if (url == null) {
//       Fluttertoast.showToast(msg: "Server URL not found.");
//       return;
//     }
//
//     final uri = Uri.parse('$url/user_login_post/');
//     var request = http.MultipartRequest('POST', uri);
//     request.fields['uUsername'] = uUsername;
//     request.fields['upassword'] = upassword;
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
//         String lid=data['lid'].toString();
//         sh.setString('lid', lid);
//         Fluttertoast.showToast(msg: "Submitted successfully.");
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>BankingDashboard()));
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
//           title: Text("Login"),
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
//                   controller: _UsernametextController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your Username',
//                     border: OutlineInputBorder(),
//
//                   ),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Name is required';
//                     }
//                     return null;
//                   },
//                 ),
//
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   controller: _passwordtextController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your Password',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Password is required';
//                     }
//                     return null;
//                   },
//                 ),
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
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) =>  MySignup(title: 'login')),
//                     );
//                   },
//                   child: const Text("Signup"),
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: const Size.fromHeight(50),
//                   ),
//                 ),
//
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// import 'Userhome.dart';
// import 'signup.dart';
//
// void main() {
//   runApp(Myapp());
// }
//
// class Myapp extends StatelessWidget {
//   const Myapp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: const Color(0xFF1565C0),
//           brightness: Brightness.light,
//         ),
//         useMaterial3: true,
//       ),
//       home: MyLogin(title: ''),
//     );
//   }
// }
//
// class MyLogin extends StatefulWidget {
//   const MyLogin({super.key, required this.title});
//
//   final String title;
//   @override
//   State<MyLogin> createState() => _MyLoginState();
// }
//
// class _MyLoginState extends State<MyLogin> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _UsernametextController = TextEditingController();
//   final TextEditingController _passwordtextController = TextEditingController();
//   bool _obscurePassword = true;
//   bool _isLoading = false;
//
//   Future<void> _sendData() async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     String uUsername = _UsernametextController.text;
//     String upassword = _passwordtextController.text;
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String? url = sh.getString('url');
//
//     if (url == null) {
//       setState(() {
//         _isLoading = false;
//       });
//       Fluttertoast.showToast(msg: "Server URL not found.");
//       return;
//     }
//
//     final uri = Uri.parse('$url/user_login_post/');
//     var request = http.MultipartRequest('POST', uri);
//     request.fields['uUsername'] = uUsername;
//     request.fields['upassword'] = upassword;
//
//     try {
//       var response = await request.send();
//       var respStr = await response.stream.bytesToString();
//       var data = jsonDecode(respStr);
//
//       if (response.statusCode == 200 && data['status'] == 'ok') {
//         String lid = data['lid'].toString();
//         sh.setString('lid', lid);
//         Fluttertoast.showToast(msg: "Login successful!");
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => BankingDashboard()),
//         );
//       } else {
//         Fluttertoast.showToast(msg: "Invalid credentials. Please try again.");
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Connection error. Please try again.");
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFF0D47A1),
//               Color(0xFF1565C0),
//               Color(0xFF1976D2),
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Logo and Title Section
//                   Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.1),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       Icons.trending_up,
//                       size: 80,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   Text(
//                     'TradeBee',
//                     style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       letterSpacing: 1.5,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Stock Price Prediction & Trading',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.white.withOpacity(0.9),
//                       letterSpacing: 0.5,
//                     ),
//                   ),
//                   const SizedBox(height: 48),
//
//                   // Login Card
//                   Container(
//                     padding: const EdgeInsets.all(24),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 20,
//                           offset: Offset(0, 10),
//                         ),
//                       ],
//                     ),
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           Text(
//                             'Welcome Back',
//                             style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: Color(0xFF0D47A1),
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             'Sign in to continue trading',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey[600],
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                           const SizedBox(height: 32),
//
//                           // Username Field
//                           TextFormField(
//                             controller: _UsernametextController,
//                             decoration: InputDecoration(
//                               labelText: 'Username',
//                               prefixIcon: Icon(Icons.person_outline),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: BorderSide(color: Colors.grey[300]!),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: BorderSide(
//                                   color: Color(0xFF1565C0),
//                                   width: 2,
//                                 ),
//                               ),
//                             ),
//                             validator: (value) {
//                               if (value == null || value.trim().isEmpty) {
//                                 return 'Please enter your username';
//                               }
//                               return null;
//                             },
//                           ),
//                           const SizedBox(height: 20),
//
//                           // Password Field
//                           TextFormField(
//                             controller: _passwordtextController,
//                             obscureText: _obscurePassword,
//                             decoration: InputDecoration(
//                               labelText: 'Password',
//                               prefixIcon: Icon(Icons.lock_outline),
//                               suffixIcon: IconButton(
//                                 icon: Icon(
//                                   _obscurePassword
//                                       ? Icons.visibility_off_outlined
//                                       : Icons.visibility_outlined,
//                                 ),
//                                 onPressed: () {
//                                   setState(() {
//                                     _obscurePassword = !_obscurePassword;
//                                   });
//                                 },
//                               ),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: BorderSide(color: Colors.grey[300]!),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                                 borderSide: BorderSide(
//                                   color: Color(0xFF1565C0),
//                                   width: 2,
//                                 ),
//                               ),
//                             ),
//                             validator: (value) {
//                               if (value == null || value.trim().isEmpty) {
//                                 return 'Please enter your password';
//                               }
//                               return null;
//                             },
//                           ),
//                           const SizedBox(height: 12),
//
//                           // Forgot Password
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: TextButton(
//                               onPressed: () {
//                                 // Add forgot password functionality
//                               },
//                               child: Text(
//                                 'Forgot Password?',
//                                 style: TextStyle(
//                                   color: Color(0xFF1565C0),
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 24),
//
//                           // Login Button
//                           ElevatedButton(
//                             onPressed: _isLoading
//                                 ? null
//                                 : () {
//                               if (_formKey.currentState!.validate()) {
//                                 _sendData();
//                               }
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Color(0xFF1565C0),
//                               foregroundColor: Colors.white,
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               elevation: 2,
//                             ),
//                             child: _isLoading
//                                 ? SizedBox(
//                               height: 20,
//                               width: 20,
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 2,
//                                 valueColor: AlwaysStoppedAnimation<Color>(
//                                   Colors.white,
//                                 ),
//                               ),
//                             )
//                                 : Text(
//                               'Sign In',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 24),
//
//                           // Divider
//                           Row(
//                             children: [
//                               Expanded(child: Divider(color: Colors.grey[300])),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                                 child: Text(
//                                   'OR',
//                                   style: TextStyle(
//                                     color: Colors.grey[600],
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                               Expanded(child: Divider(color: Colors.grey[300])),
//                             ],
//                           ),
//                           const SizedBox(height: 24),
//
//                           // Sign Up Button
//                           OutlinedButton(
//                             onPressed: () {
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => MySignup(title: 'login'),
//                                 ),
//                               );
//                             },
//                             style: OutlinedButton.styleFrom(
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                               side: BorderSide(
//                                 color: Color(0xFF1565C0),
//                                 width: 2,
//                               ),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                             child: Text(
//                               'Create New Account',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xFF1565C0),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//
//                   // Footer
//                   Text(
//                     '© 2025 TradeVision. All rights reserved.',
//                     style: TextStyle(
//                       color: Colors.white.withOpacity(0.8),
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _UsernametextController.dispose();
//     _passwordtextController.dispose();
//     super.dispose();
//   }
// }

//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// import 'Userhome.dart';
// import 'signup.dart';
//
// void main() {
//   runApp(Myapp());
// }
//
// class Myapp extends StatelessWidget {
//   const Myapp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         brightness: Brightness.dark,
//         primarySwatch: Colors.green,
//         scaffoldBackgroundColor: Color(0xFF0A0E27),
//         colorScheme: ColorScheme.dark(
//           primary: Color(0xFF00E676),
//           secondary: Color(0xFF00C853),
//           surface: Color(0xFF1A1F3A),
//         ),
//         useMaterial3: true,
//       ),
//       home: MyLogin(title: ''),
//     );
//   }
// }
//
// class MyLogin extends StatefulWidget {
//   const MyLogin({super.key, required this.title});
//
//   final String title;
//   @override
//   State<MyLogin> createState() => _MyLoginState();
// }
//
// class _MyLoginState extends State<MyLogin> with SingleTickerProviderStateMixin {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _UsernametextController = TextEditingController();
//   final TextEditingController _passwordtextController = TextEditingController();
//   bool _obscurePassword = true;
//   bool _isLoading = false;
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: Duration(milliseconds: 1500),
//       vsync: this,
//     );
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
//     );
//     _animationController.forward();
//   }
//
//   Future<void> _sendData() async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     String uUsername = _UsernametextController.text;
//     String upassword = _passwordtextController.text;
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String? url = sh.getString('url');
//
//     if (url == null) {
//       setState(() {
//         _isLoading = false;
//       });
//       Fluttertoast.showToast(msg: "Server URL not found.");
//       return;
//     }
//
//     final uri = Uri.parse('$url/user_login_post/');
//     var request = http.MultipartRequest('POST', uri);
//     request.fields['uUsername'] = uUsername;
//     request.fields['upassword'] = upassword;
//
//     try {
//       var response = await request.send();
//       var respStr = await response.stream.bytesToString();
//       var data = jsonDecode(respStr);
//
//       if (response.statusCode == 200 && data['status'] == 'ok') {
//         String lid = data['lid'].toString();
//         sh.setString('lid', lid);
//         Fluttertoast.showToast(msg: "Login successful!");
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => BankingDashboard()),
//         );
//       } else {
//         Fluttertoast.showToast(msg: "Invalid credentials. Please try again.");
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Connection error. Please try again.");
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFF0A0E27),
//               Color(0xFF1A1F3A),
//               Color(0xFF0F1629),
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: FadeTransition(
//                 opacity: _fadeAnimation,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // Market Stats Cards
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         _buildMarketCard('NASDAQ', '+2.4%', true),
//                         _buildMarketCard('S&P 500', '-0.8%', false),
//                         _buildMarketCard('DOW', '+1.2%', true),
//                       ],
//                     ),
//                     const SizedBox(height: 40),
//
//                     // Logo Section
//                     Container(
//                       padding: const EdgeInsets.all(24),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         gradient: LinearGradient(
//                           colors: [
//                             Color(0xFF00E676).withOpacity(0.3),
//                             Color(0xFF00C853).withOpacity(0.1),
//                           ],
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Color(0xFF00E676).withOpacity(0.3),
//                             blurRadius: 30,
//                             spreadRadius: 5,
//                           ),
//                         ],
//                       ),
//                       child: Icon(
//                         Icons.show_chart,
//                         size: 70,
//                         color: Color(0xFF00E676),
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//
//                     ShaderMask(
//                       shaderCallback: (bounds) => LinearGradient(
//                         colors: [Color(0xFF00E676), Color(0xFF00C853)],
//                       ).createShader(bounds),
//                       child: Text(
//                         'STOCKPULSE',
//                         style: TextStyle(
//                           fontSize: 36,
//                           fontWeight: FontWeight.w900,
//                           color: Colors.white,
//                           letterSpacing: 2,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       'AI-Powered Stock Prediction',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey[400],
//                         letterSpacing: 1,
//                       ),
//                     ),
//                     const SizedBox(height: 48),
//
//                     // Login Card
//                     Container(
//                       padding: const EdgeInsets.all(28),
//                       decoration: BoxDecoration(
//                         color: Color(0xFF1A1F3A),
//                         borderRadius: BorderRadius.circular(24),
//                         border: Border.all(
//                           color: Color(0xFF00E676).withOpacity(0.3),
//                           width: 1,
//                         ),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Color(0xFF00E676).withOpacity(0.1),
//                             blurRadius: 30,
//                             offset: Offset(0, 10),
//                           ),
//                         ],
//                       ),
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             Text(
//                               'Welcome Trader',
//                               style: TextStyle(
//                                 fontSize: 26,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               'Access your trading dashboard',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.grey[400],
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                             const SizedBox(height: 32),
//
//                             // Username Field
//                             TextFormField(
//                               controller: _UsernametextController,
//                               style: TextStyle(color: Colors.white),
//                               decoration: InputDecoration(
//                                 labelText: 'Username',
//                                 labelStyle: TextStyle(color: Colors.grey[400]),
//                                 prefixIcon: Icon(
//                                   Icons.person_outline,
//                                   color: Color(0xFF00E676),
//                                 ),
//                                 filled: true,
//                                 fillColor: Color(0xFF0F1629),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(
//                                     color: Colors.grey[800]!,
//                                     width: 1,
//                                   ),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(
//                                     color: Color(0xFF00E676),
//                                     width: 2,
//                                   ),
//                                 ),
//                                 errorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(
//                                     color: Colors.red,
//                                     width: 1,
//                                   ),
//                                 ),
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.trim().isEmpty) {
//                                   return 'Please enter your username';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             const SizedBox(height: 20),
//
//                             // Password Field
//                             TextFormField(
//                               controller: _passwordtextController,
//                               obscureText: _obscurePassword,
//                               style: TextStyle(color: Colors.white),
//                               decoration: InputDecoration(
//                                 labelText: 'Password',
//                                 labelStyle: TextStyle(color: Colors.grey[400]),
//                                 prefixIcon: Icon(
//                                   Icons.lock_outline,
//                                   color: Color(0xFF00E676),
//                                 ),
//                                 suffixIcon: IconButton(
//                                   icon: Icon(
//                                     _obscurePassword
//                                         ? Icons.visibility_off_outlined
//                                         : Icons.visibility_outlined,
//                                     color: Colors.grey[400],
//                                   ),
//                                   onPressed: () {
//                                     setState(() {
//                                       _obscurePassword = !_obscurePassword;
//                                     });
//                                   },
//                                 ),
//                                 filled: true,
//                                 fillColor: Color(0xFF0F1629),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(
//                                     color: Colors.grey[800]!,
//                                     width: 1,
//                                   ),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(
//                                     color: Color(0xFF00E676),
//                                     width: 2,
//                                   ),
//                                 ),
//                                 errorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                   borderSide: BorderSide(
//                                     color: Colors.red,
//                                     width: 1,
//                                   ),
//                                 ),
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.trim().isEmpty) {
//                                   return 'Please enter your password';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             const SizedBox(height: 12),
//
//                             // Forgot Password
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: TextButton(
//                                 onPressed: () {
//                                   // Add forgot password functionality
//                                 },
//                                 child: Text(
//                                   'Forgot Password?',
//                                   style: TextStyle(
//                                     color: Color(0xFF00E676),
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 24),
//
//                             // Login Button
//                             Container(
//                               decoration: BoxDecoration(
//                                 gradient: LinearGradient(
//                                   colors: [
//                                     Color(0xFF00E676),
//                                     Color(0xFF00C853),
//                                   ],
//                                 ),
//                                 borderRadius: BorderRadius.circular(12),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Color(0xFF00E676).withOpacity(0.4),
//                                     blurRadius: 15,
//                                     offset: Offset(0, 5),
//                                   ),
//                                 ],
//                               ),
//                               child: ElevatedButton(
//                                 onPressed: _isLoading
//                                     ? null
//                                     : () {
//                                   if (_formKey.currentState!.validate()) {
//                                     _sendData();
//                                   }
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.transparent,
//                                   shadowColor: Colors.transparent,
//                                   padding: const EdgeInsets.symmetric(vertical: 16),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                 ),
//                                 child: _isLoading
//                                     ? SizedBox(
//                                   height: 20,
//                                   width: 20,
//                                   child: CircularProgressIndicator(
//                                     strokeWidth: 2,
//                                     valueColor: AlwaysStoppedAnimation<Color>(
//                                       Color(0xFF0A0E27),
//                                     ),
//                                   ),
//                                 )
//                                     : Text(
//                                   'LOGIN',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                     color: Color(0xFF0A0E27),
//                                     letterSpacing: 1.5,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 24),
//
//                             // Divider
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Divider(color: Colors.grey[700]),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                                   child: Text(
//                                     'OR',
//                                     style: TextStyle(
//                                       color: Colors.grey[500],
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Divider(color: Colors.grey[700]),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 24),
//
//                             // Sign Up Button
//                             OutlinedButton(
//                               onPressed: () {
//                                 Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => MySignup(title: 'login'),
//                                   ),
//                                 );
//                               },
//                               style: OutlinedButton.styleFrom(
//                                 padding: const EdgeInsets.symmetric(vertical: 16),
//                                 side: BorderSide(
//                                   color: Color(0xFF00E676),
//                                   width: 2,
//                                 ),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                               ),
//                               child: Text(
//                                 'CREATE ACCOUNT',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   color: Color(0xFF00E676),
//                                   letterSpacing: 1.5,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 32),
//
//                     // Footer
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.security, size: 16, color: Colors.grey[600]),
//                         SizedBox(width: 8),
//                         Text(
//                           'Secured & Encrypted Trading Platform',
//                           style: TextStyle(
//                             color: Colors.grey[600],
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMarketCard(String index, String change, bool isPositive) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       decoration: BoxDecoration(
//         color: Color(0xFF1A1F3A),
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(
//           color: isPositive
//               ? Color(0xFF00E676).withOpacity(0.3)
//               : Colors.red.withOpacity(0.3),
//           width: 1,
//         ),
//       ),
//       child: Column(
//         children: [
//           Text(
//             index,
//             style: TextStyle(
//               color: Colors.grey[400],
//               fontSize: 10,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           SizedBox(height: 4),
//           Row(
//             children: [
//               Icon(
//                 isPositive ? Icons.arrow_upward : Icons.arrow_downward,
//                 color: isPositive ? Color(0xFF00E676) : Colors.red,
//                 size: 12,
//               ),
//               SizedBox(width: 4),
//               Text(
//                 change,
//                 style: TextStyle(
//                   color: isPositive ? Color(0xFF00E676) : Colors.red,
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     _UsernametextController.dispose();
//     _passwordtextController.dispose();
//     super.dispose();
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'Userhome.dart';
import 'forgot_password.dart';
import 'otpone.dart';
import 'signup.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFF000000),
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF1E88E5),
          secondary: Color(0xFF42A5F5),
          surface: Color(0xFF0D1117),
        ),
        useMaterial3: true,
      ),
      home: MyLogin(title: ''),
    );
  }
}

class MyLogin extends StatefulWidget {
  const MyLogin({super.key, required this.title});

  final String title;
  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _UsernametextController = TextEditingController();
  final TextEditingController _passwordtextController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  Future<void> _sendData() async {
    setState(() {
      _isLoading = true;
    });

    String uUsername = _UsernametextController.text;
    String upassword = _passwordtextController.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String? url = sh.getString('url');

    if (url == null) {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(msg: "Server URL not found.");
      return;
    }

    final uri = Uri.parse('$url/user_login_post/');
    var request = http.MultipartRequest('POST', uri);
    request.fields['uUsername'] = uUsername;
    request.fields['upassword'] = upassword;

    try {
      var response = await request.send();
      var respStr = await response.stream.bytesToString();
      var data = jsonDecode(respStr);

      if (response.statusCode == 200 && data['status'] == 'ok') {
        String lid = data['lid'].toString();
        sh.setString('lid', lid);
        Fluttertoast.showToast(msg: "Login successful!");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BankingDashboard()),
        );
      }
      else if(data['status'] == 'blocked'){
        Fluttertoast.showToast(msg: "This user has been blocked!");

      }else {
        Fluttertoast.showToast(msg: "Invalid credentials. Please try again.");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Connection error. Please try again.");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated Logo Section
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF1E88E5),
                            Color(0xFF1565C0),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF1E88E5).withOpacity(0.4),
                            blurRadius: 40,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.candlestick_chart,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Brand Name
                    Text(
                      'TradeBee',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 4,
                        shadows: [
                          Shadow(
                            color: Color(0xFF1E88E5).withOpacity(0.5),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'PROFESSIONAL TRADING PLATFORM',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF64B5F6),
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Stats Bar
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFF0D1117),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color(0xFF1E88E5).withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem('24H Volume', '\$2.4B'),
                          Container(
                            height: 30,
                            width: 1,
                            color: Color(0xFF1E88E5).withOpacity(0.3),
                          ),
                          _buildStatItem('Active Traders', '45.2K'),
                          Container(
                            height: 30,
                            width: 1,
                            color: Color(0xFF1E88E5).withOpacity(0.3),
                          ),
                          _buildStatItem('Uptime', '99.9%'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Login Card
                    Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Color(0xFF0D1117),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color(0xFF1E88E5).withOpacity(0.3),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF1E88E5).withOpacity(0.15),
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
                            Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Enter your credentials to continue',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF8B9DC3),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 36),

                            // Username Field
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'USERNAME',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF64B5F6),
                                    letterSpacing: 1,
                                  ),
                                ),
                                SizedBox(height: 8),
                                TextFormField(
                                  controller: _UsernametextController,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Enter username',
                                    hintStyle: TextStyle(
                                      color: Color(0xFF4A5568),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.person_outline_rounded,
                                      color: Color(0xFF1E88E5),
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFF000000),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 18,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Color(0xFF1E3A52),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Color(0xFF1E3A52),
                                        width: 1.5,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Color(0xFF1E88E5),
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
                                    errorStyle: TextStyle(
                                      color: Color(0xFFEF5350),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Username is required';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Password Field
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'PASSWORD',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF64B5F6),
                                    letterSpacing: 1,
                                  ),
                                ),
                                SizedBox(height: 8),
                                TextFormField(
                                  controller: _passwordtextController,
                                  obscureText: _obscurePassword,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Enter password',
                                    hintStyle: TextStyle(
                                      color: Color(0xFF4A5568),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.lock_outline_rounded,
                                      color: Color(0xFF1E88E5),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscurePassword
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: Color(0xFF4A5568),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      },
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFF000000),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 18,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Color(0xFF1E3A52),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Color(0xFF1E3A52),
                                        width: 1.5,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(
                                        color: Color(0xFF1E88E5),
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
                                    errorStyle: TextStyle(
                                      color: Color(0xFFEF5350),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Password is required';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Forgot Password
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => forgot_password(title: '',)),
                                  );
                                  // Add forgot password functionality
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: Color(0xFF64B5F6),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Login Button
                            Container(
                              height: 56,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF1E88E5),
                                    Color(0xFF1565C0),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF1E88E5).withOpacity(0.5),
                                    blurRadius: 20,
                                    offset: Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: _isLoading
                                    ? null
                                    : () {
                                  if (_formKey.currentState!.validate()) {
                                    _sendData();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: _isLoading
                                    ? SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                                    : Text(
                                  'SIGN IN',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 28),

                            // Divider
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: Color(0xFF1E3A52),
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
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

                            // Sign Up Button
                            Container(
                              height: 56,
                              child: OutlinedButton(
                                onPressed: () {
                                  // Navigator.pushReplacement(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => MySignup(title: 'login'),
                                  //   ),
                                  // );




                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PhonePage(),
                                    ),
                                  );

                                },
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: Color(0xFF1E88E5),
                                    width: 2,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  'CREATE ACCOUNT',
                                  style: TextStyle(
                                    fontSize: 16,
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

                    // Footer
                    Row(
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: Color(0xFF64B5F6),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Color(0xFF4A5568),
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _UsernametextController.dispose();
    _passwordtextController.dispose();
    super.dispose();
  }
}