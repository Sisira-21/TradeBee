// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:tradebee1/viewprofile.dart';
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
//       home: Myeditprofile(title: '',),
//     );
//   }
// }
//
//
// class Myeditprofile extends StatefulWidget {
//   const Myeditprofile({super.key, required this.title});
//
//   final String title;
//   @override
//   State<Myeditprofile> createState() => _MyeditprofileState();
//
// }
// class _MyeditprofileState extends State<Myeditprofile> {
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
//   String photo="";
//
//
//   @override
//   void initState() {
//     super.initState();
//     viewUsers("");
//   }
//
//   Future<void> viewUsers(String searchValue) async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url') ?? '';
//       String lid = sh.getString('lid') ?? '';
//       String img = sh.getString('img_url') ?? '';
//       String apiUrl = '$urls/user_viewprofile/';
//
//       var response = await http.post(Uri.parse(apiUrl), body: {
//         'lid':lid
//       });
//       var jsonData = json.decode(response.body);
//
//       if (jsonData['status'] == 'ok') {
//         String name_=jsonData['name'].toString();
//         String photo_= img+jsonData['photo'].toString();
//         String gender_=jsonData['gender'].toString();
//         String dob_=jsonData['dateofbirth'].toString();
//         String email_=jsonData['email'].toString();
//         String phone_=jsonData['phone'].toString();
//         String place_=jsonData['place'].toString();
//         String city_=jsonData['city'].toString();
//         String pincode_=jsonData['pincode'].toString();
//         String state_=jsonData['state'].toString();
//
//         setState(() {
//
//           photo=photo_;
//           _nametextController.text=name_;
//           gender=gender_;
//           _dobtextController.text=dob_;
//           _emailtextController.text=email_;
//           _phonenotextController.text=phone_;
//           _citytextController.text=city_;
//           _pincodetextController.text=pincode_;
//           _placetextController.text=place_;
//           _statetextController.text=state_;
//
//         });
//       }
//     } catch (e) {
//       print("Error fetching users: $e");
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
//     final uri = Uri.parse('$url/user_editprofile/');
//     var request = http.MultipartRequest('POST', uri);
//     request.fields['name'] = uname;
//     request.fields['email'] = uemail;
//     request.fields['phone'] = uphone;
//     request.fields['dateofbirth'] = udob;
//     request.fields['place'] = uplace;
//     request.fields['city'] = ucity;
//     request.fields['state'] = ustate;
//     request.fields['pincode'] = upincode;
//     request.fields['gender'] = gender;
//     request.fields['lid'] = lid;
//
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
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>UserViewprofile(title: '',)));
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
//                     : CircleAvatar(backgroundImage: NetworkImage(photo),radius: 60,),
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
import 'package:tradebee1/viewprofile.dart';

import 'login.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Myeditprofile(title: ''),
    );
  }
}

class Myeditprofile extends StatefulWidget {
  const Myeditprofile({super.key, required this.title});

  final String title;
  @override
  State<Myeditprofile> createState() => _MyeditprofileState();
}

class _MyeditprofileState extends State<Myeditprofile> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nametextController = TextEditingController();
  final TextEditingController _emailtextController = TextEditingController();
  final TextEditingController _phonenotextController = TextEditingController();
  final TextEditingController _dobtextController = TextEditingController();
  final TextEditingController _placetextController = TextEditingController();
  final TextEditingController _citytextController = TextEditingController();
  final TextEditingController _statetextController = TextEditingController();
  final TextEditingController _pincodetextController = TextEditingController();

  File? _selectedImage;
  String photo = "";
  String gender = "male";
  bool _isLoading = false;
  bool _isDataLoading = true;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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
    viewUsers("");
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nametextController.dispose();
    _emailtextController.dispose();
    _phonenotextController.dispose();
    _dobtextController.dispose();
    _placetextController.dispose();
    _citytextController.dispose();
    _statetextController.dispose();
    _pincodetextController.dispose();
    super.dispose();
  }

  Future<void> _chooseImage() async {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    } else {
      Fluttertoast.showToast(msg: "No image selected");
    }
  }

  Future<void> viewUsers(String searchValue) async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url') ?? '';
      String lid = sh.getString('lid') ?? '';
      String img = sh.getString('img_url') ?? '';
      String apiUrl = '$urls/user_viewprofile/';

      var response = await http.post(Uri.parse(apiUrl), body: {'lid': lid});
      var jsonData = json.decode(response.body);

      if (jsonData['status'] == 'ok') {
        setState(() {
          photo = img + jsonData['photo'].toString();
          _nametextController.text = jsonData['name'].toString();
          gender = jsonData['gender'].toString();
          _dobtextController.text = jsonData['dateofbirth'].toString();
          _emailtextController.text = jsonData['email'].toString();
          _phonenotextController.text = jsonData['phone'].toString();
          _citytextController.text = jsonData['city'].toString();
          _pincodetextController.text = jsonData['pincode'].toString();
          _placetextController.text = jsonData['place'].toString();
          _statetextController.text = jsonData['state'].toString();
          _isDataLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching users: $e");
      setState(() {
        _isDataLoading = false;
      });
    }
  }

  Future<void> _sendData() async {
    setState(() {
      _isLoading = true;
    });

    String uname = _nametextController.text;
    String uemail = _emailtextController.text;
    String uphone = _phonenotextController.text;
    String udob = _dobtextController.text;
    String uplace = _placetextController.text;
    String ucity = _citytextController.text;
    String ustate = _statetextController.text;
    String upincode = _pincodetextController.text;

    SharedPreferences sh = await SharedPreferences.getInstance();
    String? url = sh.getString('url');
    String lid = sh.getString('lid').toString();

    if (url == null) {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(msg: "Server URL not found.");
      return;
    }

    final uri = Uri.parse('$url/user_editprofile/');
    var request = http.MultipartRequest('POST', uri);
    request.fields['name'] = uname;
    request.fields['email'] = uemail;
    request.fields['phone'] = uphone;
    request.fields['dateofbirth'] = udob;
    request.fields['place'] = uplace;
    request.fields['city'] = ucity;
    request.fields['state'] = ustate;
    request.fields['pincode'] = upincode;
    request.fields['gender'] = gender;
    request.fields['lid'] = lid;

    if (_selectedImage != null) {
      request.files.add(
          await http.MultipartFile.fromPath('photo', _selectedImage!.path));
    }

    try {
      var response = await request.send();
      var respStr = await response.stream.bytesToString();
      var data = jsonDecode(respStr);

      if (response.statusCode == 200 && data['status'] == 'ok') {
        Fluttertoast.showToast(msg: "Profile updated successfully!");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserViewprofile(title: '')),
        );
      } else {
        Fluttertoast.showToast(msg: "Update failed. Please try again.");
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
            child: _isDataLoading
                ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1E88E5)),
              ),
            )
                : FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color(0xFF0D1117),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Color(0xFF1E88E5).withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Color(0xFF64B5F6),
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Text(
                          'EDIT PROFILE',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 10),

                            // Profile Picture Section
                            Container(
                              padding: EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Color(0xFF0D1117),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Color(0xFF1E88E5).withOpacity(0.3),
                                  width: 1.5,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
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
                                              color: Color(0xFF1E88E5)
                                                  .withOpacity(0.5),
                                              blurRadius: 30,
                                              spreadRadius: 5,
                                            ),
                                          ],
                                        ),
                                        child: ClipOval(
                                          child: _selectedImage != null
                                              ? Image.file(
                                            _selectedImage!,
                                            fit: BoxFit.cover,
                                          )
                                              : photo.isNotEmpty
                                              ? Image.network(
                                            photo,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error,
                                                stackTrace) {
                                              return Container(
                                                color: Color(0xFF1E88E5)
                                                    .withOpacity(0.2),
                                                child: Icon(
                                                  Icons.person,
                                                  size: 60,
                                                  color: Color(0xFF64B5F6),
                                                ),
                                              );
                                            },
                                          )
                                              : Container(
                                            color: Color(0xFF1E88E5)
                                                .withOpacity(0.2),
                                            child: Icon(
                                              Icons.person,
                                              size: 60,
                                              color: Color(0xFF64B5F6),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: _chooseImage,
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xFF1E88E5),
                                                  Color(0xFF1565C0),
                                                ],
                                              ),
                                              border: Border.all(
                                                color: Color(0xFF0D1117),
                                                width: 3,
                                              ),
                                            ),
                                            child: Icon(
                                              Icons.camera_alt_rounded,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Tap camera icon to change photo',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF8B9DC3),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 24),

                            // Personal Information
                            _buildSectionHeader('PERSONAL INFORMATION'),
                            SizedBox(height: 16),

                            _buildTextField(
                              controller: _nametextController,
                              label: 'FULL NAME',
                              hint: 'Enter your full name',
                              icon: Icons.person_outline_rounded,
                              validator: (value) {
                                if (value == null || value
                                    .trim()
                                    .isEmpty) {
                                  return 'Name is required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),

                            _buildTextField(
                              controller: _dobtextController,
                              label: 'DATE OF BIRTH',
                              hint: 'Select your date of birth',
                              icon: Icons.cake_rounded,
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
                                  String fd = '${dt.year}-${dt.month.toString()
                                      .padLeft(2, '0')}-${dt.day.toString()
                                      .padLeft(2, '0')}';
                                  setState(() {
                                    _dobtextController.text = fd;
                                  });
                                }
                              },
                              validator: (value) {
                                if (value == null || value
                                    .trim()
                                    .isEmpty) {
                                  return 'Date of birth is required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),

                            // Gender Selection
                            Container(
                              padding: EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: Color(0xFF0D1117),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Color(0xFF1E88E5).withOpacity(0.3),
                                  width: 1.5,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.wc_rounded,
                                        color: Color(0xFF64B5F6),
                                        size: 20,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'GENDER',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF64B5F6),
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildGenderOption(
                                            'Male', 'male'),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: _buildGenderOption(
                                            'Female', 'female'),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: _buildGenderOption(
                                            'Other', 'Other'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 24),

                            // Contact Information
                            _buildSectionHeader('CONTACT INFORMATION'),
                            SizedBox(height: 16),

                            _buildTextField(
                              controller: _emailtextController,
                              label: 'EMAIL ADDRESS',
                              hint: 'Enter your email',
                              icon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value
                                    .trim()
                                    .isEmpty) {
                                  return 'Email is required';
                                }
                                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                  return 'Enter a valid email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),

                            _buildTextField(
                              controller: _phonenotextController,
                              label: 'PHONE NUMBER',
                              hint: 'Enter your phone number',
                              icon: Icons.phone_rounded,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value
                                    .trim()
                                    .isEmpty) {
                                  return 'Phone number is required';
                                }
                                if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                                  return 'Enter a valid 10-digit phone number';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 24),

                            // Location Information
                            _buildSectionHeader('LOCATION DETAILS'),
                            SizedBox(height: 16),

                            _buildTextField(
                              controller: _placetextController,
                              label: 'PLACE',
                              hint: 'Enter your place',
                              icon: Icons.home_outlined,
                              validator: (value) {
                                if (value == null || value
                                    .trim()
                                    .isEmpty) {
                                  return 'Place is required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),

                            _buildTextField(
                              controller: _citytextController,
                              label: 'CITY',
                              hint: 'Enter your city',
                              icon: Icons.location_city_rounded,
                              validator: (value) {
                                if (value == null || value
                                    .trim()
                                    .isEmpty) {
                                  return 'City is required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),

                            _buildTextField(
                              controller: _statetextController,
                              label: 'STATE',
                              hint: 'Enter your state',
                              icon: Icons.map_outlined,
                              validator: (value) {
                                if (value == null || value
                                    .trim()
                                    .isEmpty) {
                                  return 'State is required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),

                            _buildTextField(
                              controller: _pincodetextController,
                              label: 'PINCODE',
                              hint: 'Enter your pincode',
                              icon: Icons.pin_drop_outlined,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value
                                    .trim()
                                    .isEmpty) {
                                  return 'Pincode is required';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 32),

                            // Update Profile Button
                            Container(
                              height: 56,
                              width: double.infinity,
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
                                child: _isLoading
                                    ? SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    valueColor:
                                    AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                                    : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.save_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      'UPDATE PROFILE',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 32),
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
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: Color(0xFF1E88E5),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF64B5F6),
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    bool readOnly = false,
    VoidCallback? onTap,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF64B5F6),
            letterSpacing: 1,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          onTap: onTap,
          keyboardType: keyboardType,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Color(0xFF4A5568),
            ),
            prefixIcon: Icon(
              icon,
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
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildGenderOption(String label, String value) {
    bool isSelected = gender == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          gender = value;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Color(0xFF1E88E5).withOpacity(0.2)
              : Color(0xFF000000),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? Color(0xFF1E88E5)
                : Color(0xFF1E3A52),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isSelected ? Color(0xFF64B5F6) : Color(0xFF8B9DC3),
            ),
          ),
        ),
      ),
    );
  }
}