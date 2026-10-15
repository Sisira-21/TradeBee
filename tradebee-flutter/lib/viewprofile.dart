// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:tradebee1/editprofile.dart';
//
//
// void main() {
//   runApp(const ViewHouseApp());
// }
//
// class ViewHouseApp extends StatelessWidget {
//   const ViewHouseApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: UserViewprofile(title: 'View Users'),
//     );
//   }
// }
//
// class UserViewprofile extends StatefulWidget {
//   const UserViewprofile({super.key, required this.title});
//   final String title;
//
//   @override
//   State<UserViewprofile> createState() => _UserViewprofileState();
// }
//
// class _UserViewprofileState extends State<UserViewprofile> {
//
//
//   String photo="";
//   String name="";
//   String gender="";
//   String dob="";
//   String email="";
//   String phone="";
//   String place="";
//   String city="";
//   String state="";
//   String pincode="";
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
//           name=name_;
//           gender=gender_;
//           dob=dob_;
//           email=email_;
//           phone=phone_;
//           city=city_;
//           pincode=pincode_;
//           place=place_;
//           state=state_;
//
//         });
//       }
//     } catch (e) {
//       print("Error fetching users: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//         onWillPop: () async {
//           // Navigator.pushReplacement(
//           //   context,
//           //   MaterialPageRoute(builder: (context) => const BankingDashboard()),
//           // );
//           return true; // Prevent default pop
//         },
//         child:Scaffold(
//           appBar: AppBar(
//             backgroundColor: Color.fromARGB(255, 232, 177, 61),
//             title: Text('View Profile'),
//
//           ),
//           body: Column(
//             children: [
// CircleAvatar(
//   backgroundImage: NetworkImage(photo),
//   radius: 50,
//
// ) ,             Text(gender),
//               Text(dob),
//               Text(email),
//               Text(phone),
//               Text(place),
//               Text(city),
//               Text(state),
//               Text(pincode),
//               ElevatedButton(onPressed: (){
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) =>  Myeditprofile(title: 'Edit profile',)),
//                 );
//               }, child: Text("edit"))
//
//             ],
//           )
//         ));
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tradebee1/editprofile.dart';

void main() {
  runApp(const ViewHouseApp());
}

class ViewHouseApp extends StatelessWidget {
  const ViewHouseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: UserViewprofile(title: 'View Users'),
    );
  }
}

class UserViewprofile extends StatefulWidget {
  const UserViewprofile({super.key, required this.title});
  final String title;

  @override
  State<UserViewprofile> createState() => _UserViewprofileState();
}

class _UserViewprofileState extends State<UserViewprofile> with SingleTickerProviderStateMixin {
  String photo = "";
  String name = "";
  String gender = "";
  String dob = "";
  String email = "";
  String phone = "";
  String place = "";
  String city = "";
  String state = "";
  String pincode = "";
  bool isLoading = true;

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
    super.dispose();
  }

  Future<void> viewUsers(String searchValue) async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url') ?? '';
      String lid = sh.getString('lid') ?? '';
      String img = sh.getString('img_url') ?? '';
      String apiUrl = '$urls/user_viewprofile/';

      var response = await http.post(Uri.parse(apiUrl), body: {
        'lid': lid
      });
      var jsonData = json.decode(response.body);

      if (jsonData['status'] == 'ok') {
        String name_ = jsonData['name'].toString();
        String photo_ = img + jsonData['photo'].toString();
        String gender_ = jsonData['gender'].toString();
        String dob_ = jsonData['dateofbirth'].toString();
        String email_ = jsonData['email'].toString();
        String phone_ = jsonData['phone'].toString();
        String place_ = jsonData['place'].toString();
        String city_ = jsonData['city'].toString();
        String pincode_ = jsonData['pincode'].toString();
        String state_ = jsonData['state'].toString();

        setState(() {
          photo = photo_;
          name = name_;
          gender = gender_;
          dob = dob_;
          email = email_;
          phone = phone_;
          city = city_;
          pincode = pincode_;
          place = place_;
          state = state_;
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching users: $e");
      setState(() {
        isLoading = false;
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
            child: isLoading
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
                          child: Cont+ainer(
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
                          'MY PROFILE',
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
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF1E88E5).withOpacity(0.15),
                                  blurRadius: 25,
                                  spreadRadius: 5,
                                ),
                              ],
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
                                            color: Color(0xFF1E88E5).withOpacity(0.5),
                                            blurRadius: 30,
                                            spreadRadius: 5,
                                          ),
                                        ],
                                      ),
                                      child: ClipOval(
                                        child: photo.isNotEmpty
                                            ? Image.network(
                                          photo,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              color: Color(0xFF1E88E5).withOpacity(0.2),
                                              child: Icon(
                                                Icons.person,
                                                size: 60,
                                                color: Color(0xFF64B5F6),
                                              ),
                                            );
                                          },
                                        )
                                            : Container(
                                          color: Color(0xFF1E88E5).withOpacity(0.2),
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
                                      child: Container(
                                        padding: EdgeInsets.all(8),
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
                                            width: 2,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.verified_user,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Text(
                                  name.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 8),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF1E88E5).withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Color(0xFF1E88E5).withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    'VERIFIED TRADER',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF64B5F6),
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 24),

                          // Personal Information
                          _buildSectionHeader('PERSONAL INFORMATION'),
                          SizedBox(height: 12),

                          _buildInfoCard(Icons.wc_rounded, 'Gender', gender),
                          SizedBox(height: 12),
                          _buildInfoCard(Icons.cake_rounded, 'Date of Birth', dob),

                          SizedBox(height: 24),

                          // Contact Information
                          _buildSectionHeader('CONTACT INFORMATION'),
                          SizedBox(height: 12),

                          _buildInfoCard(Icons.email_outlined, 'Email', email),
                          SizedBox(height: 12),
                          _buildInfoCard(Icons.phone_rounded, 'Phone', phone),

                          SizedBox(height: 24),

                          // Location Information
                          _buildSectionHeader('LOCATION DETAILS'),
                          SizedBox(height: 12),

                          _buildInfoCard(Icons.home_outlined, 'Place', place),
                          SizedBox(height: 12),
                          _buildInfoCard(Icons.location_city_rounded, 'City', city),
                          SizedBox(height: 12),
                          _buildInfoCard(Icons.map_outlined, 'State', state),
                          SizedBox(height: 12),
                          _buildInfoCard(Icons.pin_drop_outlined, 'Pincode', pincode),

                          SizedBox(height: 32),

                          // Edit Profile Button
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
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Myeditprofile(title: 'Edit profile'),
                                  ),
                                );
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
                                  Icon(
                                    Icons.edit_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    'EDIT PROFILE',
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

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Container(
      padding: EdgeInsets.all(18),
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
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFF1E88E5).withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: Color(0xFF64B5F6),
              size: 22,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8B9DC3),
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value.isNotEmpty ? value : 'Not provided',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}