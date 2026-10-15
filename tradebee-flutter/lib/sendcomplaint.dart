// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:tradebee1/view%20reply.dart';
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
//       home: MySendComplaint(title: '',),
//     );
//   }
// }
//
//
// class MySendComplaint extends StatefulWidget {
//   const MySendComplaint({super.key, required this.title});
//
//   final String title;
//   @override
//   State<MySendComplaint> createState() => _MySendComplaintState();
//
// }
// class _MySendComplaintState extends State<MySendComplaint> {
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _ComplainttextController = TextEditingController();
//
//
//
//   Future<void> _sendData() async {
//     String uComplaint = _ComplainttextController.text;
//     ;
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
//     final uri = Uri.parse('$url/user_sendcomplanit/');
//     var request = http.MultipartRequest('POST', uri);
//     request.fields['complaint'] = uComplaint;
//     request.fields['lid'] = lid;
//
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
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>UserViewreply(title: '',)));
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
//           title: Text("Send Complaint"),
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
//                   maxLines: 5,
//                   controller: _ComplainttextController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your Complaint',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return ' Complaint is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       _sendData();
//                     } else {
//                       Fluttertoast.showToast(msg: "Please fix errors in the form");
//                     }
//                   },
//                   child: const Text("Send"),
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
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tradebee1/view%20reply.dart';

void main() {
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MySendComplaint(title: ''),
    );
  }
}

class MySendComplaint extends StatefulWidget {
  const MySendComplaint({super.key, required this.title});

  final String title;
  @override
  State<MySendComplaint> createState() => _MySendComplaintState();
}

class _MySendComplaintState extends State<MySendComplaint> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _ComplainttextController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _ComplainttextController.dispose();
    super.dispose();
  }

  Future<void> _sendData() async {
    setState(() {
      _isSubmitting = true;
    });

    String uComplaint = _ComplainttextController.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String? url = sh.getString('url');
    String lid = sh.getString('lid').toString();

    if (url == null) {
      setState(() {
        _isSubmitting = false;
      });
      Fluttertoast.showToast(msg: "Server URL not found.");
      return;
    }

    final uri = Uri.parse('$url/user_sendcomplanit/');
    var request = http.MultipartRequest('POST', uri);
    request.fields['complaint'] = uComplaint;
    request.fields['lid'] = lid;

    try {
      var response = await request.send();
      var respStr = await response.stream.bytesToString();
      var data = jsonDecode(respStr);

      setState(() {
        _isSubmitting = false;
      });

      if (response.statusCode == 200 && data['status'] == 'ok') {
        Fluttertoast.showToast(msg: "Complaint submitted successfully.");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserViewreply(title: '')),
        );
      } else {
        Fluttertoast.showToast(msg: "Submission failed. Please try again.");
      }
    } catch (e) {
      setState(() {
        _isSubmitting = false;
      });
      Fluttertoast.showToast(msg: "Error: $e");
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
          child: Column(
            children: [
              // Header
              FadeTransition(
                opacity: _fadeAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xFF0D1117),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Color(0xFF1E88E5).withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.arrow_back,
                                color: Color(0xFF64B5F6),
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFEC407A),
                                  Color(0xFFD81B60),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFEC407A).withOpacity(0.4),
                                  blurRadius: 15,
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.report_problem_outlined,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Send Complaint',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0xFF0D1117),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Color(0xFFEC407A).withOpacity(0.3),
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
                                'We value your feedback. Please describe your concern.',
                                style: TextStyle(
                                  color: Color(0xFF8B9DC3),
                                  fontSize: 13,
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

              // Form Content
              Expanded(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Quick Issue Categories
                            Text(
                              'Common Issues',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                _buildQuickChip('Technical Issue'),
                                _buildQuickChip('Account Problem'),
                                _buildQuickChip('Transaction Error'),
                                _buildQuickChip('Feature Request'),
                                _buildQuickChip('Other'),
                              ],
                            ),
                            SizedBox(height: 30),

                            // Complaint Text Field
                            Text(
                              'Describe Your Complaint',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 12),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFEC407A).withOpacity(0.1),
                                    blurRadius: 20,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: _ComplainttextController,
                                maxLines: 8,
                                style: TextStyle(color: Colors.white, fontSize: 15),
                                decoration: InputDecoration(
                                  hintText: 'Please provide detailed information about your complaint...',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF8B9DC3).withOpacity(0.5),
                                    fontSize: 14,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFF0D1117),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      color: Color(0xFFEC407A).withOpacity(0.3),
                                      width: 1.5,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      color: Color(0xFFEC407A).withOpacity(0.3),
                                      width: 1.5,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      color: Color(0xFFEC407A),
                                      width: 2,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      color: Color(0xFFEF5350),
                                      width: 1.5,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      color: Color(0xFFEF5350),
                                      width: 2,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(16),
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please describe your complaint';
                                  }
                                  if (value.trim().length < 10) {
                                    return 'Please provide more details (at least 10 characters)';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 30),

                            // Character Counter
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${_ComplainttextController.text.length} characters',
                                style: TextStyle(
                                  color: Color(0xFF8B9DC3),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            SizedBox(height: 30),

                            // Submit Button
                            GestureDetector(
                              onTap: _isSubmitting
                                  ? null
                                  : () {
                                if (_formKey.currentState!.validate()) {
                                  _sendData();
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "Please fill in all required fields",
                                  );
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                height: 55,
                                decoration: BoxDecoration(
                                  gradient: _isSubmitting
                                      ? LinearGradient(
                                    colors: [
                                      Color(0xFF8B9DC3),
                                      Color(0xFF6B7FA3),
                                    ],
                                  )
                                      : LinearGradient(
                                    colors: [
                                      Color(0xFFEC407A),
                                      Color(0xFFD81B60),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: _isSubmitting
                                      ? []
                                      : [
                                    BoxShadow(
                                      color: Color(0xFFEC407A).withOpacity(0.4),
                                      blurRadius: 20,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: _isSubmitting
                                      ? SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                      : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.send_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Submit Complaint',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),

                            // View Replies Button
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserViewreply(title: ''),
                                  ),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xFF0D1117),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Color(0xFF1E88E5).withOpacity(0.5),
                                    width: 1.5,
                                  ),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.question_answer_outlined,
                                        color: Color(0xFF64B5F6),
                                        size: 20,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'View Previous Complaints',
                                        style: TextStyle(
                                          color: Color(0xFF64B5F6),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 30),

                            // Support Info
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.support_agent,
                                        color: Color(0xFF26A69A),
                                        size: 20,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Support Team Response',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Our support team typically responds within 24-48 hours. You will receive a notification when we reply.',
                                    style: TextStyle(
                                      color: Color(0xFF8B9DC3),
                                      fontSize: 12,
                                      height: 1.4,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickChip(String label) {
    return GestureDetector(
      onTap: () {
        if (_ComplainttextController.text.isEmpty) {
          setState(() {
            _ComplainttextController.text = 'Issue Type: $label\n\n';
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Color(0xFF0D1117),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Color(0xFF1E88E5).withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Color(0xFF64B5F6),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}