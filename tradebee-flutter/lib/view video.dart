// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';
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
//       home: UserViewvideo(title: 'View Users'),
//     );
//   }
// }
//
// class UserViewvideo extends StatefulWidget {
//   const UserViewvideo({super.key, required this.title});
//   final String title;
//
//   @override
//   State<UserViewvideo> createState() => _UserViewvideoState();
// }
//
// class _UserViewvideoState extends State<UserViewvideo> {
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
//       String apiUrl = '$urls/user_viewvideo/';
//       String img_url = sh.getString('img_url') ?? '';
//
//
//       var response = await http.post(Uri.parse(apiUrl), body: {});
//       var jsonData = json.decode(response.body);
//
//       if (jsonData['status'] == 'ok') {
//         List<Map<String, dynamic>> tempList = [];
//         for (var item in jsonData['data']) {
//           tempList.add({
//             'id': item['id'].toString(),
//             'title': item['title'].toString(),
//             'video': img_url+item['video'].toString(),
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
//       onWillPop: () async {
//         return true; // Allow back button
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Color.fromARGB(255, 232, 177, 61),
//           title: Text('View Video'),
//         ),
//         body: ListView.builder(
//           shrinkWrap: true,
//           physics: BouncingScrollPhysics(),
//           itemCount: users.length,
//           itemBuilder: (context, index) {
//             final user = users[index];
//             return Card(
//               margin: const EdgeInsets.all(10),
//               elevation: 5,
//               child: ListTile(
//                 title: Text(
//                   user['title'],
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: () async {
//                         if (!await launchUrl(Uri.parse(user['video']))) {
//                         throw Exception('Could not launch');
//                         }
//                       },
//                       child: Text('Play Video'),
//                     ),
//                     SizedBox(height: 10),
//                     Text("Date: ${user['date']}"),
//                     SizedBox(height: 10),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const ViewHouseApp());
}

class ViewHouseApp extends StatelessWidget {
  const ViewHouseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: UserViewvideo(title: 'View Users'),
    );
  }
}

class UserViewvideo extends StatefulWidget {
  const UserViewvideo({super.key, required this.title});
  final String title;

  @override
  State<UserViewvideo> createState() => _UserViewvideoState();
}

class _UserViewvideoState extends State<UserViewvideo>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> users = [];
  bool isLoading = true;
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
      String apiUrl = '$urls/user_viewvideo/';
      String img_url = sh.getString('img_url') ?? '';

      var response = await http.post(Uri.parse(apiUrl), body: {});
      var jsonData = json.decode(response.body);

      if (jsonData['status'] == 'ok') {
        List<Map<String, dynamic>> tempList = [];
        for (var item in jsonData['data']) {
          tempList.add({
            'id': item['id'].toString(),
            'title': item['title'].toString(),
            'video': img_url + item['video'].toString(),
            'date': item['date'].toString(),
          });
        }
        setState(() {
          users = tempList;
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

  String _formatDuration(int index) {
    // Simulated durations for demo purposes
    final durations = ['12:45', '8:30', '15:20', '6:15', '10:00', '18:45'];
    return durations[index % durations.length];
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
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color(0xFF0D1117),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Color(0xFFAB47BC).withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.arrow_back,
                                color: Color(0xFFAB47BC),
                                size: 22,
                              ),
                            ).onTap(() => Navigator.pop(context)),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.play_circle_filled,
                                        color: Color(0xFFAB47BC),
                                        size: 20,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'VIDEO LIBRARY',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '${users.length} tutorials available',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF64B5F6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color(0xFF0D1117),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Color(0xFFAB47BC).withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.refresh,
                                color: Color(0xFFAB47BC),
                                size: 22,
                              ),
                            ).onTap(() => viewUsers("")),
                          ],
                        ),
                        SizedBox(height: 16),

                        // Stats Bar
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(0xFF0D1117),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Color(0xFFAB47BC).withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatItem(
                                  Icons.video_library, '${users.length}', 'Videos'),
                              Container(
                                height: 30,
                                width: 1,
                                color: Color(0xFF8B9DC3).withOpacity(0.3),
                              ),
                              _buildStatItem(
                                  Icons.access_time, '2.5h', 'Total'),
                              Container(
                                height: 30,
                                width: 1,
                                color: Color(0xFF8B9DC3).withOpacity(0.3),
                              ),
                              _buildStatItem(
                                  Icons.trending_up, 'Expert', 'Level'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Videos Grid
                  Expanded(
                    child: isLoading
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFFAB47BC)),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Loading videos...',
                            style: TextStyle(
                              color: Color(0xFF8B9DC3),
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
                            Icons.video_library_outlined,
                            size: 80,
                            color: Color(0xFF8B9DC3).withOpacity(0.3),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No videos available',
                            style: TextStyle(
                              color: Color(0xFF8B9DC3),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                        : GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      physics: BouncingScrollPhysics(),
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        final isNew = index < 2;

                        return Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF0D1117),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color:
                              Color(0xFFAB47BC).withOpacity(0.3),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFAB47BC)
                                    .withOpacity(0.1),
                                blurRadius: 15,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              // Video Thumbnail
                              Expanded(
                                child: Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.only(
                                          topLeft:
                                          Radius.circular(16),
                                          topRight:
                                          Radius.circular(16),
                                        ),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xFFAB47BC)
                                                .withOpacity(0.3),
                                            Color(0xFF7B1FA2)
                                                .withOpacity(0.2),
                                          ],
                                        ),
                                      ),
                                      child: Center(
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                            color: Colors.black
                                                .withOpacity(0.6),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white
                                                  .withOpacity(0.8),
                                              width: 3,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.play_arrow_rounded,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Duration Badge
                                    Positioned(
                                      bottom: 10,
                                      right: 10,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black
                                              .withOpacity(0.8),
                                          borderRadius:
                                          BorderRadius.circular(6),
                                        ),
                                        child: Row(
                                          mainAxisSize:
                                          MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              size: 12,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              _formatDuration(index),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // New Badge
                                    if (isNew)
                                      Positioned(
                                        top: 10,
                                        left: 10,
                                        child: Container(
                                          padding:
                                          EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xFF66BB6A),
                                                Color(0xFF43A047),
                                              ],
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(
                                                6),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(
                                                    0xFF66BB6A)
                                                    .withOpacity(0.4),
                                                blurRadius: 8,
                                                spreadRadius: 1,
                                              ),
                                            ],
                                          ),
                                          child: Text(
                                            'NEW',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight:
                                              FontWeight.bold,
                                              letterSpacing: 0.8,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),

                              // Video Info
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user['title'],
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        height: 1.3,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          size: 12,
                                          color: Color(0xFF8B9DC3),
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          user['date'],
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF8B9DC3),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12),

                                    // Watch Button
                                    Container(
                                      width: double.infinity,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            Color(0xFFAB47BC),
                                            Color(0xFF8E24AA),
                                          ],
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xFFAB47BC)
                                                .withOpacity(0.3),
                                            blurRadius: 10,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          if (!await launchUrl(Uri.parse(
                                              user['video']))) {
                                            ScaffoldMessenger.of(
                                                context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Could not launch video'),
                                                backgroundColor:
                                                Color(0xFFEF5350),
                                              ),
                                            );
                                          }
                                        },
                                        style:
                                        ElevatedButton.styleFrom(
                                          backgroundColor:
                                          Colors.transparent,
                                          shadowColor:
                                          Colors.transparent,
                                          shape:
                                          RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                10),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.play_arrow_rounded,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            SizedBox(width: 6),
                                            Text(
                                              'WATCH NOW',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight:
                                                FontWeight.bold,
                                                color: Colors.white,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
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

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(
          icon,
          color: Color(0xFFAB47BC),
          size: 20,
        ),
        SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Color(0xFF8B9DC3),
            fontSize: 11,
          ),
        ),
      ],
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