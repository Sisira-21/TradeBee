// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
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
//       home: MySignup(title: '',),
//     );
//   }
// }
//
//
// class MySignup extends StatefulWidget {
//   const MySignup({super.key, required this.title});
//
//   final String title;
//   @override
//   State<MySignup> createState() => _MySignupState();
//
// }
// class _MySignupState extends State<MySignup> {
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _nametextController = TextEditingController();
//   final TextEditingController _emailtextController = TextEditingController();
//   final TextEditingController _phonenotextController = TextEditingController();
//   final TextEditingController _dobtextController = TextEditingController();
//   final TextEditingController _placetextController = TextEditingController();
//   final TextEditingController _citytextController = TextEditingController();
//   final TextEditingController _statetextController = TextEditingController();
//   final TextEditingController _pincodetextController = TextEditingController();
//   final TextEditingController _passwordtextController = TextEditingController();
//   final TextEditingController _confirmpasswordtextController = TextEditingController();
//
//   File? _selectedImage;
//   Future<void> _chooseImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = File(pickedFile.path);
//       });
//     }
//     else {
//       Fluttertoast.showToast(msg: "No image selected");
//     }
//   }
//
//   Future<void> _sendData() async {
//     String uname = _nametextController.text;
//     String uemail = _emailtextController.text;
//     String uphone = _phonenotextController.text;
//     String udob = _dobtextController.text;
//     String uplace = _placetextController.text;
//     String ucity = _citytextController.text;
//     String ustate= _statetextController.text;
//     String upincode= _pincodetextController.text;
//     String upassword= _passwordtextController.text;
//     String uconfirmpassword= _confirmpasswordtextController.text;
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
//     final uri = Uri.parse('$url/user_viewsignup/');
//     var request = http.MultipartRequest('POST', uri);
//     request.fields['uname'] = uname;
//     request.fields['email'] = uemail;
//     request.fields['phone'] = uphone;
//     request.fields['udateofbirth'] = udob;
//     request.fields['place'] = uplace;
//     request.fields['city'] = ucity;
//     request.fields['state'] = ustate;
//     request.fields['pincode'] = upincode;
//     request.fields['password'] = upassword;
//     request.fields['gender'] = gender;
//     request.fields['confirmpassword'] = uconfirmpassword;
//
//     if (_selectedImage != null) {
//       request.files.add(await http.MultipartFile.fromPath('photo', _selectedImage!.path));
//     }
//
//     try {
//       var response = await request.send();
//       var respStr = await response.stream.bytesToString();
//       var data = jsonDecode(respStr);
//
//       if (response.statusCode == 200 && data['status'] == 'ok') {
//         Fluttertoast.showToast(msg: "Submitted successfully.");
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>MyLogin(title: '',)));
//       } else {
//         Fluttertoast.showToast(msg: "Submission failed.");
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error: $e");
//     }
//   }
//   String gender="male";
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
//           title: Text('Signup'),
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
//                 _selectedImage != null
//                     ? Image.file(_selectedImage!, height: 150)
//                     : const Text("No Image Selected"),
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: _chooseImage,
//                   child: const Text("Choose Image"),
//                 ),
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   controller: _nametextController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your Name',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Name is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: _emailtextController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your Email',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Email is required';
//                     }
//                     if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
//                       return 'Enter a valid email';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: _phonenotextController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your Phone Number',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.phone,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Phone number is required';
//                     }
//                     if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
//                       return 'Enter a valid 10-digit phone number';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//
//                 RadioListTile(value: "male", groupValue: gender, onChanged: (value) {
//                   setState(() {
//                     gender="male";
//                   });
//                 },title: Text("Male"),),
//                 const SizedBox(height: 20),
//
//                 RadioListTile(value: "female", groupValue: gender, onChanged: (value) {
//                   setState(() {
//                     gender="female";
//                   });
//                 },title: Text("Female"),),
//                 const SizedBox(height: 20),
//
//                 RadioListTile(value: "Other", groupValue: gender, onChanged: (value) {
//                   setState(() {
//                     gender="Other";
//                   });
//                 },title: Text("Other"),),
//
//
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   onTap: ()async{
//                     DateTime? dt=await showDatePicker(context: context, firstDate: DateTime(1990), lastDate: DateTime.now());
//                     String fd='${dt!.year}-${dt.month}-${dt.day}';
//                     setState(() {
//                       _dobtextController.text=fd;
//                     });
//                   },
//                   controller: _dobtextController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your Dob',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Dob is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: _placetextController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your Place',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.text,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Place is required';
//                     }
//
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: _citytextController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your City',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.text,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'City is required';
//                     }
//
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   controller: _statetextController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your State',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'State is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   controller: _pincodetextController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your Pincode',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Pincode is required';
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
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   controller: _confirmpasswordtextController,
//                   decoration: const InputDecoration(
//                     labelText: 'Enter Your Confirm password',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Confirmpassword is required';
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
import 'package:image_picker/image_picker.dart';
import 'login.dart';

void main() {
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MySignup(title: ''),
    );
  }
}

class MySignup extends StatefulWidget {
  const MySignup({super.key, required this.title});

  final String title;
  @override
  State<MySignup> createState() => _MySignupState();
}

class _MySignupState extends State<MySignup> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nametextController = TextEditingController();
  final TextEditingController _emailtextController = TextEditingController();
  final TextEditingController _phonenotextController = TextEditingController();
  final TextEditingController _dobtextController = TextEditingController();
  final TextEditingController _placetextController = TextEditingController();
  final TextEditingController _citytextController = TextEditingController();
  final TextEditingController _statetextController = TextEditingController();
  final TextEditingController _pincodetextController = TextEditingController();
  final TextEditingController _passwordtextController = TextEditingController();
  final TextEditingController _confirmpasswordtextController = TextEditingController();

  File? _selectedImage;
  String gender = "male";
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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

  Future<void> _chooseImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    } else {
      Fluttertoast.showToast(msg: "No image selected");
    }
  }

  Future<void> _sendData() async {
    String uname = _nametextController.text;
    String uemail = _emailtextController.text;
    String uphone = _phonenotextController.text;
    String udob = _dobtextController.text;
    String uplace = _placetextController.text;
    String ucity = _citytextController.text;
    String ustate = _statetextController.text;
    String upincode = _pincodetextController.text;
    String upassword = _passwordtextController.text;
    String uconfirmpassword = _confirmpasswordtextController.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String? url = sh.getString('url');

    if (url == null) {
      Fluttertoast.showToast(msg: "Server URL not found.");
      return;
    }

    final uri = Uri.parse('$url/user_viewsignup/');
    var request = http.MultipartRequest('POST', uri);
    request.fields['uname'] = uname;
    request.fields['email'] = uemail;
    request.fields['phone'] = uphone;
    request.fields['udateofbirth'] = udob;
    request.fields['place'] = uplace;
    request.fields['city'] = ucity;
    request.fields['state'] = ustate;
    request.fields['pincode'] = upincode;
    request.fields['password'] = upassword;
    request.fields['gender'] = gender;
    request.fields['confirmpassword'] = uconfirmpassword;

    if (_selectedImage != null) {
      request.files.add(await http.MultipartFile.fromPath('photo', _selectedImage!.path));
    }

    try {
      var response = await request.send();
      var respStr = await response.stream.bytesToString();
      var data = jsonDecode(respStr);

      if (response.statusCode == 200 && data['status'] == 'ok') {
        Fluttertoast.showToast(msg: "Submitted successfully.");
        Navigator.push(context, MaterialPageRoute(builder: (context) => MyLogin(title: '')));
      } else {
        Fluttertoast.showToast(msg: "Submission failed.");
      }
    } catch (e) {
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
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF1E88E5),
                              Color(0xFF1565C0),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF1E88E5).withOpacity(0.4),
                              blurRadius: 15,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.candlestick_chart,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'TradeBee',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back, color: Color(0xFF64B5F6)),
                      ),
                    ],
                  ),
                ),

                // Title Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Join TradeBee and start your trading journey',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF64B5F6),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Form
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Profile Image Selection
                          GestureDetector(
                            onTap: _chooseImage,
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xFF1E88E5),
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF1E88E5).withOpacity(0.3),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: _selectedImage != null
                                  ? ClipOval(
                                child: Image.file(
                                  _selectedImage!,
                                  fit: BoxFit.cover,
                                ),
                              )
                                  : Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF0D1117),
                                ),
                                child: Icon(
                                  Icons.add_a_photo_outlined,
                                  size: 40,
                                  color: Color(0xFF64B5F6),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Tap to upload photo',
                            style: TextStyle(
                              color: Color(0xFF64B5F6),
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 30),

                          // Name Field
                          _buildTextField(
                            controller: _nametextController,
                            label: 'Full Name',
                            icon: Icons.person_outline,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Name is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),

                          // Email Field
                          _buildTextField(
                            controller: _emailtextController,
                            label: 'Email Address',
                            icon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Email is required';
                              }
                              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),

                          // Phone Field
                          _buildTextField(
                            controller: _phonenotextController,
                            label: 'Phone Number',
                            icon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Phone number is required';
                              }
                              if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                                return 'Enter a valid 10-digit phone number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),

                          // Gender Selection
                          Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Color(0xFF0D1117),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Color(0xFF1E88E5).withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Gender',
                                  style: TextStyle(
                                    color: Color(0xFF64B5F6),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildRadioOption('Male', 'male'),
                                    ),
                                    Expanded(
                                      child: _buildRadioOption('Female', 'female'),
                                    ),
                                    Expanded(
                                      child: _buildRadioOption('Other', 'Other'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),

                          // Date of Birth
                          _buildTextField(
                            controller: _dobtextController,
                            label: 'Date of Birth',
                            icon: Icons.calendar_today_outlined,
                            readOnly: true,
                            onTap: () async {
                              DateTime? dt = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1950),
                                lastDate: DateTime.now(),
                                builder: (context, child) {
                                  return Theme(
                                    data: ThemeData.dark().copyWith(
                                      colorScheme: ColorScheme.dark(
                                        primary: Color(0xFF1E88E5),
                                        surface: Color(0xFF0D1117),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (dt != null) {
                                String fd = '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
                                setState(() {
                                  _dobtextController.text = fd;
                                });
                              }
                            },
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Date of birth is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),

                          // Place Field
                          _buildTextField(
                            controller: _placetextController,
                            label: 'Place',
                            icon: Icons.location_on_outlined,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Place is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),

                          // City Field
                          _buildTextField(
                            controller: _citytextController,
                            label: 'City',
                            icon: Icons.location_city_outlined,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'City is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),

                          // State Field
                          _buildTextField(
                            controller: _statetextController,
                            label: 'State',
                            icon: Icons.map_outlined,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'State is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),

                          // Pincode Field
                          _buildTextField(
                            controller: _pincodetextController,
                            label: 'Pincode',
                            icon: Icons.pin_drop_outlined,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Pincode is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),

                          // Password Field
                          _buildTextField(
                            controller: _passwordtextController,
                            label: 'Password',
                            icon: Icons.lock_outline,
                            obscureText: _obscurePassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                color: Color(0xFF64B5F6),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Password is required';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),

                          // Confirm Password Field
                          _buildTextField(
                            controller: _confirmpasswordtextController,
                            label: 'Confirm Password',
                            icon: Icons.lock_outline,
                            obscureText: _obscureConfirmPassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                color: Color(0xFF64B5F6),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword = !_obscureConfirmPassword;
                                });
                              },
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Confirm password is required';
                              }
                              if (value != _passwordtextController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 30),

                          // Submit Button
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                _sendData();
                              } else {
                                Fluttertoast.showToast(msg: "Please fix errors in the form");
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: 55,
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
                                    color: Color(0xFF1E88E5).withOpacity(0.4),
                                    blurRadius: 20,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Create Account',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),

                          // Login Link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account? ',
                                style: TextStyle(
                                  color: Color(0xFF8B9DC3),
                                  fontSize: 14,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => MyLogin(title: '')),
                                  );
                                },
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Color(0xFF1E88E5),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    bool readOnly = false,
    Widget? suffixIcon,
    VoidCallback? onTap,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      onTap: onTap,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Color(0xFF64B5F6)),
        prefixIcon: Icon(icon, color: Color(0xFF64B5F6)),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Color(0xFF0D1117),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Color(0xFF1E88E5).withOpacity(0.3),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Color(0xFF1E88E5).withOpacity(0.3),
            width: 1,
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
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Color(0xFFEF5350),
            width: 2,
          ),
        ),
      ),
      validator: validator,
    );
  }

  Widget _buildRadioOption(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: value,
          groupValue: gender,
          onChanged: (val) {
            setState(() {
              gender = val!;
            });
          },
          activeColor: Color(0xFF1E88E5),
          fillColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return Color(0xFF1E88E5);
            }
            return Color(0xFF64B5F6);
          }),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}