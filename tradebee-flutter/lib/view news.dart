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
//       home: UserViewnews(title: 'View News'),
//     );
//   }
// }
//
// class UserViewnews extends StatefulWidget {
//   const UserViewnews({super.key, required this.title});
//   final String title;
//
//   @override
//   State<UserViewnews> createState() => _UserViewnewsState();
// }
//
// class _UserViewnewsState extends State<UserViewnews> {
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
//       String apiUrl = '$urls/user_viewnews/';
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
//             'description': item['description'].toString(),
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
//             title: Text('View News'),
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
//                       Text("description: ${user['description']}"),
//                       Text("date: ${user['date']}"),
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
      home: UserViewnews(title: 'View News'),
    );
  }
}

class UserViewnews extends StatefulWidget {
  const UserViewnews({super.key, required this.title});
  final String title;

  @override
  State<UserViewnews> createState() => _UserViewnewsState();
}

class _UserViewnewsState extends State<UserViewnews>
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
      String img = sh.getString('img_url') ?? '';
      String apiUrl = '$urls/user_viewnews/';

      var response = await http.post(Uri.parse(apiUrl), body: {});
      var jsonData = json.decode(response.body);

      if (jsonData['status'] == 'ok') {
        List<Map<String, dynamic>> tempList = [];
        for (var item in jsonData['data']) {
          tempList.add({
            'id': item['id'].toString(),
            'title': item['title'].toString(),
            'description': item['description'].toString(),
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

  String _getTimeAgo(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      Duration difference = DateTime.now().difference(date);

      if (difference.inDays > 365) {
        return '${(difference.inDays / 365).floor()} year${(difference.inDays / 365).floor() > 1 ? 's' : ''} ago';
      } else if (difference.inDays > 30) {
        return '${(difference.inDays / 30).floor()} month${(difference.inDays / 30).floor() > 1 ? 's' : ''} ago';
      } else if (difference.inDays > 0) {
        return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return dateString;
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
                                  color: Color(0xFF42A5F5).withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.arrow_back,
                                color: Color(0xFF42A5F5),
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
                                      Container(
                                        padding: EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEF5350),
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xFFEF5350)
                                                  .withOpacity(0.4),
                                              blurRadius: 8,
                                              spreadRadius: 2,
                                            ),
                                          ],
                                        ),
                                        child: Container(
                                          width: 6,
                                          height: 6,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'LIVE',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFEF5350),
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    'MARKET NEWS',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '${users.length} breaking stories',
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
                                  color: Color(0xFF42A5F5).withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.refresh,
                                color: Color(0xFF42A5F5),
                                size: 22,
                              ),
                            ).onTap(() => viewUsers("")),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // News List
                  Expanded(
                    child: isLoading
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF42A5F5)),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Loading latest news...',
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
                            Icons.newspaper_outlined,
                            size: 80,
                            color: Color(0xFF8B9DC3).withOpacity(0.3),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No news available',
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
                        final isBreaking = index < 2;

                        return Container(
                          margin: EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Color(0xFF0D1117),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isBreaking
                                  ? Color(0xFFEF5350)
                                  .withOpacity(0.4)
                                  : Color(0xFF42A5F5)
                                  .withOpacity(0.3),
                              width: isBreaking ? 2 : 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isBreaking
                                    ? Color(0xFFEF5350)
                                    .withOpacity(0.15)
                                    : Color(0xFF42A5F5)
                                    .withOpacity(0.1),
                                blurRadius: 15,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                // Header with Breaking badge
                                Row(
                                  children: [
                                    if (isBreaking)
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFFEF5350),
                                              Color(0xFFE53935),
                                            ],
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(6),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xFFEF5350)
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
                                              Icons.whatshot,
                                              size: 12,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              'BREAKING',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight:
                                                FontWeight.bold,
                                                letterSpacing: 0.8,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    Spacer(),
                                    Icon(
                                      Icons.access_time,
                                      size: 14,
                                      color: Color(0xFF8B9DC3),
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      _getTimeAgo(user['date']),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF8B9DC3),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),

                                // Title
                                Text(
                                  user['title'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    height: 1.4,
                                  ),
                                ),
                                SizedBox(height: 12),

                                // Description
                                Text(
                                  user['description'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF8B9DC3),
                                    height: 1.5,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 16),

                                // Bottom Actions
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF42A5F5)
                                            .withOpacity(0.1),
                                        borderRadius:
                                        BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Color(0xFF42A5F5)
                                              .withOpacity(0.3),
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize:
                                        MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.trending_up,
                                            size: 14,
                                            color: Color(0xFF42A5F5),
                                          ),
                                          SizedBox(width: 6),
                                          Text(
                                            'Market Impact',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color:
                                              Color(0xFF42A5F5),
                                              fontWeight:
                                              FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF0D1117),
                                        borderRadius:
                                        BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Color(0xFF42A5F5)
                                              .withOpacity(0.3),
                                          width: 1,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.share_outlined,
                                        size: 16,
                                        color: Color(0xFF64B5F6),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Container(
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF0D1117),
                                        borderRadius:
                                        BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Color(0xFF42A5F5)
                                              .withOpacity(0.3),
                                          width: 1,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.bookmark_outline,
                                        size: 16,
                                        color: Color(0xFF64B5F6),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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