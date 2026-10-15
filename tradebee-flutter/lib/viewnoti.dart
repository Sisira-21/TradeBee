// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
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
//       home: UserViewnotification(title: 'View Users'),
//     );
//   }
// }
//
// class UserViewnotification extends StatefulWidget {
//   const UserViewnotification({super.key, required this.title});
//   final String title;
//
//   @override
//   State<UserViewnotification> createState() => _UserViewnotificationState();
// }
//
// class _UserViewnotificationState extends State<UserViewnotification> {
//   List<Map<String, dynamic>> users = [];
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
//       String img = sh.getString('img_url') ?? '';
//       String apiUrl = '$urls/user_viewnoti/';
//
//       var response = await http.post(Uri.parse(apiUrl), body: {});
//       var jsonData = json.decode(response.body);
//
//       if (jsonData['status'] == 'ok') {
//         List<Map<String, dynamic>> tempList = [];
//         for (var item in jsonData['data']) {
//           tempList.add({
//             'id': item['id'].toString(),
//             'notification': item['notification'].toString(),
//             'date': item['date'].toString(),
//           });
//         }
//         setState(() {
//           users = tempList;
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
//             title: Text('View Notification'),
//
//           ),
//           body: ListView.builder(
//             shrinkWrap: true,
//             physics: BouncingScrollPhysics(),
//             itemCount: users.length,
//             itemBuilder: (context, index) {
//               final user = users[index];
//               return Card(
//                 margin: const EdgeInsets.all(10),
//                 elevation: 5,
//                 child: ListTile(
//
//                   title: Text(user['notification'], style: TextStyle(fontWeight: FontWeight.bold)),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//
//                       Text("Date: ${user['date']}"),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ));
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const ViewHouseApp());
}

class ViewHouseApp extends StatelessWidget {
  const ViewHouseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserViewnotification(title: 'View Notifications'),
    );
  }
}

class UserViewnotification extends StatefulWidget {
  const UserViewnotification({super.key, required this.title});
  final String title;

  @override
  State<UserViewnotification> createState() => _UserViewnotificationState();
}

class _UserViewnotificationState extends State<UserViewnotification> with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> users = [];
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool isLoading = true;

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
    setState(() {
      isLoading = true;
    });

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url') ?? '';
      String img = sh.getString('img_url') ?? '';
      String apiUrl = '$urls/user_viewnoti/';

      var response = await http.post(Uri.parse(apiUrl), body: {});
      var jsonData = json.decode(response.body);

      if (jsonData['status'] == 'ok') {
        List<Map<String, dynamic>> tempList = [];
        for (var item in jsonData['data']) {
          tempList.add({
            'id': item['id'].toString(),
            'notification': item['notification'].toString(),
            'date': item['date'].toString(),
          });
        }
        setState(() {
          users = tempList;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching notifications: $e");
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
                                    Color(0xFFFFCA28),
                                    Color(0xFFFF8F00),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFFFCA28).withOpacity(0.4),
                                    blurRadius: 15,
                                    spreadRadius: 3,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.notifications_active,
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
                                    'NOTIFICATIONS',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    '${users.length} new updates',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF64B5F6),
                                    ),
                                  ),
                                ],
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

                  SizedBox(height: 10),

                  // Notifications List
                  Expanded(
                    child: isLoading
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFF1E88E5),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Loading notifications...',
                            style: TextStyle(
                              color: Color(0xFF64B5F6),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                        : users.isEmpty
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications_off_outlined,
                            size: 80,
                            color: Color(0xFF1E88E5).withOpacity(0.3),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No Notifications',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'You\'re all caught up!',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF64B5F6),
                            ),
                          ),
                        ],
                      ),
                    )
                        : RefreshIndicator(
                      color: Color(0xFF1E88E5),
                      backgroundColor: Color(0xFF0D1117),
                      onRefresh: () => viewUsers(""),
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        physics: BouncingScrollPhysics(),
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];
                          return _buildNotificationCard(user, index);
                        },
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

  Widget _buildNotificationCard(Map<String, dynamic> notification, int index) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 300 + (index * 100)),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Color(0xFF0D1117),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Color(0xFFFFCA28).withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFFFCA28).withOpacity(0.1),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon Container
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFFCA28),
                      Color(0xFFFF8F00),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFFFCA28).withOpacity(0.4),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.notifications_active,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              SizedBox(width: 14),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification['notification'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: Color(0xFF64B5F6),
                        ),
                        SizedBox(width: 6),
                        Text(
                          notification['date'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64B5F6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}