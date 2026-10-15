// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:url_launcher/url_launcher.dart';
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
//       home: UserViewcontent(title: 'View Users'),
//     );
//   }
// }
//
// class UserViewcontent extends StatefulWidget {
//   const UserViewcontent({super.key, required this.title});
//   final String title;
//
//   @override
//   State<UserViewcontent> createState() => _UserViewcontentState();
// }
//
// class _UserViewcontentState extends State<UserViewcontent> {
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
//       String img_url = sh.getString('img_url') ?? '';
//       String apiUrl = '$urls/user_viewcontent/';
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
//             'type': item['type'].toString(),
//
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
//             title: Text('View Content'),
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
//                   title: Text(user['title'], style: TextStyle(fontWeight: FontWeight.bold)),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: 10),
//                       ElevatedButton(
//                         onPressed: () async {
//                           if (!await launchUrl(Uri.parse(user['video']))) {
//                             throw Exception('Could not launch');
//                           }
//                         },
//                         child: Text('Play Video'),
//                       ),
//                       SizedBox(height: 10),
//                       Text("Date: ${user['date']}"),
//                       Text("type: ${user['type']}"),
//                       SizedBox(height: 10),
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
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const ViewHouseApp());
}

class ViewHouseApp extends StatelessWidget {
  const ViewHouseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: UserViewcontent(title: 'View Users'),
    );
  }
}

class UserViewcontent extends StatefulWidget {
  const UserViewcontent({super.key, required this.title});
  final String title;

  @override
  State<UserViewcontent> createState() => _UserViewcontentState();
}

class _UserViewcontentState extends State<UserViewcontent>
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
      String img_url = sh.getString('img_url') ?? '';
      String apiUrl = '$urls/user_viewcontent/';

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
            'type': item['type'].toString(),
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

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'tutorial':
        return Color(0xFF66BB6A);
      case 'analysis':
        return Color(0xFF42A5F5);
      case 'news':
        return Color(0xFFFFCA28);
      case 'strategy':
        return Color(0xFFAB47BC);
      default:
        return Color(0xFF64B5F6);
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'tutorial':
        return Icons.school_outlined;
      case 'analysis':
        return Icons.analytics_outlined;
      case 'news':
        return Icons.newspaper_outlined;
      case 'strategy':
        return Icons.psychology_outlined;
      default:
        return Icons.article_outlined;
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
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Color(0xFF0D1117),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Color(0xFF66BB6A).withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.arrow_back,
                                color: Color(0xFF66BB6A),
                                size: 22,
                              ),
                            ).onTap(() => Navigator.pop(context)),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'LEARNING CONTENT',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '${users.length} videos available',
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
                                  color: Color(0xFF66BB6A).withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.refresh,
                                color: Color(0xFF66BB6A),
                                size: 22,
                              ),
                            ).onTap(() => viewUsers("")),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Content List
                  Expanded(
                    child: isLoading
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF66BB6A)),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Loading content...',
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
                            'No content available',
                            style: TextStyle(
                              color: Color(0xFF8B9DC3),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                        : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      physics: BouncingScrollPhysics(),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        final typeColor = _getTypeColor(user['type']);
                        final typeIcon = _getTypeIcon(user['type']);

                        return Container(
                          margin: EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Color(0xFF0D1117),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: typeColor.withOpacity(0.3),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: typeColor.withOpacity(0.1),
                                blurRadius: 15,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              // Video Preview Section
                              Container(
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      typeColor.withOpacity(0.3),
                                      typeColor.withOpacity(0.1),
                                    ],
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Icon(
                                        Icons.play_circle_outline,
                                        size: 70,
                                        color: Colors.white
                                            .withOpacity(0.9),
                                      ),
                                    ),
                                    Positioned(
                                      top: 12,
                                      right: 12,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: typeColor,
                                          borderRadius:
                                          BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: typeColor
                                                  .withOpacity(0.4),
                                              blurRadius: 8,
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisSize:
                                          MainAxisSize.min,
                                          children: [
                                            Icon(
                                              typeIcon,
                                              size: 14,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 6),
                                            Text(
                                              user['type']
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 11,
                                                fontWeight:
                                                FontWeight.bold,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Content Details
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user['title'],
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        height: 1.3,
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          size: 14,
                                          color: Color(0xFF8B9DC3),
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          user['date'],
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFF8B9DC3),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),

                                    // Play Button
                                    Container(
                                      width: double.infinity,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            typeColor,
                                            typeColor
                                                .withOpacity(0.8),
                                          ],
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: typeColor
                                                .withOpacity(0.3),
                                            blurRadius: 12,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          if (!await launchUrl(
                                              Uri.parse(
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
                                                12),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons
                                                  .play_circle_filled,
                                              color: Colors.white,
                                              size: 22,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              'WATCH NOW',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight:
                                                FontWeight.bold,
                                                color: Colors.white,
                                                letterSpacing: 1.2,
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
}

extension WidgetExtension on Widget {
  Widget onTap(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: this,
    );
  }
}