// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tradebee1/Userhome.dart';
//
// void main() => runApp(MysendReview());
//
// class MysendReview extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ReviewPage(),
//     );
//   }
// }
//
// class ReviewPage extends StatefulWidget {
//   @override
//   _ReviewPageState createState() => _ReviewPageState();
// }
//
// class _ReviewPageState extends State<ReviewPage> {
//   final TextEditingController _reviewController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   double _rating = 3.0;
//   IconData? _selectedIcon;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Submit Review'),
//         backgroundColor: Colors.amber,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.settings),
//             onPressed: () async {
//               _selectedIcon = await showDialog<IconData>(
//                 context: context,
//                 builder: (context) => IconAlert(),
//               );
//               setState(() {});
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               _buildHeading("Rate Your Experience"),
//               RatingBar.builder(
//                 initialRating: _rating,
//                 minRating: 1,
//                 direction: Axis.horizontal,
//                 allowHalfRating: true,
//                 itemCount: 5,
//                 unratedColor: Colors.amber.withAlpha(50),
//                 itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                 itemBuilder: (context, _) => Icon(
//                   _selectedIcon ?? Icons.star,
//                   color: Colors.amber,
//                 ),
//                 onRatingUpdate: (rating) {
//                   setState(() {
//                     _rating = rating;
//                   });
//                 },
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Rating: $_rating',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 30),
//               TextFormField(
//                 controller: _reviewController,
//                 decoration: InputDecoration(
//                   labelText: "Enter Review",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.trim().isEmpty) {
//                     return 'Please enter your review';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: _submitReview,
//                 child: Text("Send"),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.amber,
//                   minimumSize: Size.fromHeight(50),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeading(String text) {
//     return Column(
//       children: [
//         Text(
//           text,
//           style: TextStyle(
//             fontWeight: FontWeight.w300,
//             fontSize: 24.0,
//           ),
//         ),
//         SizedBox(height: 20),
//       ],
//     );
//   }
//
//   Future<void> _submitReview() async {
//     if (!_formKey.currentState!.validate()) {
//       Fluttertoast.showToast(msg: "Please fix errors in the form");
//       return;
//     }
//
//     final reviewText = _reviewController.text.trim();
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String? url = sh.getString('url');
//     String lid = sh.getString('lid') ?? '';
//
//     if (url == null || url.isEmpty) {
//       Fluttertoast.showToast(msg: "Server URL not found.");
//       return;
//     }
//
//     final uri = Uri.parse('$url/user_sendreview/');
//     var request = http.MultipartRequest('POST', uri);
//     request.fields['review'] = reviewText;
//     request.fields['lid'] = lid;
//     request.fields['rating'] = _rating.toString();
//
//     try {
//       var response = await request.send();
//       var respStr = await response.stream.bytesToString();
//       var data = jsonDecode(respStr);
//
//       if (response.statusCode == 200 && data['status'] == 'ok') {
//         Fluttertoast.showToast(msg: "Review submitted successfully.");
//         _reviewController.clear();
//         setState(() {
//           _rating = 3.0;
//         });
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>BankingDashboard()));
//       } else {
//         Fluttertoast.showToast(msg: "Submission failed.");
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error: $e");
//     }
//   }
// }
//
// class IconAlert extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Select Icon'),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       content: Wrap(
//         children: [
//           _iconButton(context, Icons.home),
//           _iconButton(context, Icons.airplanemode_active),
//           _iconButton(context, Icons.euro_symbol),
//           _iconButton(context, Icons.beach_access),
//           _iconButton(context, Icons.attach_money),
//           _iconButton(context, Icons.music_note),
//           _iconButton(context, Icons.android),
//           _iconButton(context, Icons.toys),
//           _iconButton(context, Icons.language),
//           _iconButton(context, Icons.landscape),
//           _iconButton(context, Icons.ac_unit),
//           _iconButton(context, Icons.star),
//         ],
//       ),
//     );
//   }
//
//   Widget _iconButton(BuildContext context, IconData icon) {
//     return IconButton(
//       icon: Icon(icon),
//       onPressed: () => Navigator.pop(context, icon),
//       splashColor: Colors.amberAccent,
//       color: Colors.amber,
//     );
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradebee1/Userhome.dart';

void main() => runApp(MysendReview());

class MysendReview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ReviewPage(),
    );
  }
}

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> with SingleTickerProviderStateMixin {
  final TextEditingController _reviewController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double _rating = 3.0;
  IconData? _selectedIcon;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
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
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _reviewController.dispose();
    super.dispose();
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
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                // Header Section
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // Top Bar with Back Button
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color(0xFF0D1117),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Color(0xFF1E88E5).withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: Color(0xFF64B5F6),
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFEF5350),
                                  Color(0xFFE91E63),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFEF5350).withOpacity(0.4),
                                  blurRadius: 15,
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.rate_review,
                              size: 24,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'SEND REVIEW',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    letterSpacing: 2,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Share your experience',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF64B5F6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              _selectedIcon = await showDialog<IconData>(
                                context: context,
                                builder: (context) => IconAlert(),
                              );
                              setState(() {});
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color(0xFF0D1117),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Color(0xFFEF5350).withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.emoji_emotions_outlined,
                                color: Color(0xFFEF5350),
                                size: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Divider
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Color(0xFF1E88E5).withOpacity(0.3),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Form Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    physics: BouncingScrollPhysics(),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Rating Section
                          Container(
                            padding: EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Color(0xFF0D1117),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Color(0xFFEF5350).withOpacity(0.3),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFEF5350).withOpacity(0.1),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Rate Your Experience',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 20),
                                RatingBar.builder(
                                  initialRating: _rating,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  unratedColor: Color(0xFFEF5350).withOpacity(0.2),
                                  itemPadding: EdgeInsets.symmetric(horizontal: 6.0),
                                  itemSize: 40,
                                  glowColor: Color(0xFFEF5350),
                                  itemBuilder: (context, _) => Icon(
                                    _selectedIcon ?? Icons.star,
                                    color: Color(0xFFEF5350),
                                  ),
                                  onRatingUpdate: (rating) {
                                    setState(() {
                                      _rating = rating;
                                    });
                                  },
                                ),
                                SizedBox(height: 16),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEF5350).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Color(0xFFEF5350).withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    'Rating: ${_rating.toStringAsFixed(1)} ⭐',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xFFEF5350),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 24),

                          // Review Text Field
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF0D1117),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Color(0xFF1E88E5).withOpacity(0.3),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF1E88E5).withOpacity(0.1),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: _reviewController,
                              maxLines: 6,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                              decoration: InputDecoration(
                                labelText: "Write Your Review",
                                labelStyle: TextStyle(
                                  color: Color(0xFF64B5F6),
                                ),
                                hintText: "Share your thoughts and feedback...",
                                hintStyle: TextStyle(
                                  color: Color(0xFF64B5F6).withOpacity(0.5),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.all(20),
                                filled: true,
                                fillColor: Colors.transparent,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your review';
                                }
                                return null;
                              },
                            ),
                          ),

                          SizedBox(height: 30),

                          // Submit Button
                          GestureDetector(
                            onTap: _isSubmitting ? null : _submitReview,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFEF5350),
                                    Color(0xFFE91E63),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFEF5350).withOpacity(0.4),
                                    blurRadius: 15,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: _isSubmitting
                                  ? Center(
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                                  : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.send,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'SUBMIT REVIEW',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submitReview() async {
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
        msg: "Please fix errors in the form",
        backgroundColor: Color(0xFFEF5350),
        textColor: Colors.white,
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final reviewText = _reviewController.text.trim();

    SharedPreferences sh = await SharedPreferences.getInstance();
    String? url = sh.getString('url');
    String lid = sh.getString('lid') ?? '';

    if (url == null || url.isEmpty) {
      setState(() {
        _isSubmitting = false;
      });
      Fluttertoast.showToast(
        msg: "Server URL not found.",
        backgroundColor: Color(0xFFEF5350),
        textColor: Colors.white,
      );
      return;
    }

    final uri = Uri.parse('$url/user_sendreview/');
    var request = http.MultipartRequest('POST', uri);
    request.fields['review'] = reviewText;
    request.fields['lid'] = lid;
    request.fields['rating'] = _rating.toString();

    try {
      var response = await request.send();
      var respStr = await response.stream.bytesToString();
      var data = jsonDecode(respStr);

      setState(() {
        _isSubmitting = false;
      });

      if (response.statusCode == 200 && data['status'] == 'ok') {

        Fluttertoast.showToast(
          msg: "Review submitted successfully!",
          backgroundColor: Color(0xFF26A69A),
          textColor: Colors.white,
        );
        _reviewController.clear();
        setState(() {
          _rating = 3.0;
        });
        Navigator.push(context, MaterialPageRoute(builder: (context)=>BankingDashboard()));

        // Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
          msg: "Submission failed. Please try again.",
          backgroundColor: Color(0xFFEF5350),
          textColor: Colors.white,
        );
      }
    } catch (e) {
      setState(() {
        _isSubmitting = false;
      });
      Fluttertoast.showToast(
        msg: "Error: $e",
        backgroundColor: Color(0xFFEF5350),
        textColor: Colors.white,
      );
    }
  }
}

class IconAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF0D1117),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Color(0xFFEF5350).withOpacity(0.3),
            width: 1,
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFEF5350),
                        Color(0xFFE91E63),
                      ],
                    ),
                  ),
                  child: Icon(
                    Icons.emoji_emotions,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  'Select Rating Icon',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Color(0xFFEF5350).withOpacity(0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _iconButton(context, Icons.star),
                _iconButton(context, Icons.favorite),
                _iconButton(context, Icons.thumb_up),
                _iconButton(context, Icons.emoji_emotions),
                _iconButton(context, Icons.local_fire_department),
                _iconButton(context, Icons.diamond),
                _iconButton(context, Icons.rocket_launch),
                _iconButton(context, Icons.celebration),
                _iconButton(context, Icons.verified),
                _iconButton(context, Icons.grade),
                _iconButton(context, Icons.workspace_premium),
                _iconButton(context, Icons.auto_awesome),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconButton(BuildContext context, IconData icon) {
    return GestureDetector(
      onTap: () => Navigator.pop(context, icon),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xFF0D1117),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color(0xFFEF5350).withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          color: Color(0xFFEF5350),
          size: 24,
        ),
      ),
    );
  }
}
