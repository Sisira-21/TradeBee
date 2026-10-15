// import 'package:flutter/material.dart';
// import 'package:tradebee1/sendcomplaint.dart';
// import 'package:tradebee1/sendreview.dart';
// import 'package:tradebee1/view%20content.dart';
// import 'package:tradebee1/view%20news.dart';
// import 'package:tradebee1/view%20reply.dart';
// import 'package:tradebee1/view%20video.dart';
// import 'package:tradebee1/viewnoti.dart';
// import 'package:tradebee1/viewprofile.dart';
// import 'package:tradebee1/viewstock.dart';
//
// import 'changepassword.dart';
//
//
//
//
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: BankingDashboard(),
//   ));
// }
//
// class BankingDashboard extends StatefulWidget {
//   const BankingDashboard({super.key});
//
//   @override
//   State<BankingDashboard> createState() => _BankingDashboardState();
// }
//
// class _BankingDashboardState extends State<BankingDashboard> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // drawer: const Drawer(
//       //   child: DrawerContent(),
//       // ),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.black87),
//         // actions: const [
//         //   Icon(Icons.notifications_none),
//         //   SizedBox(width: 16),
//         // ],
//       ),
//       backgroundColor: const Color(0xFFF5F6FA),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Row(
//               children: [
//                 CircleAvatar(
//                   backgroundImage: AssetImage('assets/user.jpg'),
//                   radius: 25,
//                 ),
//                 SizedBox(width: 12),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Hi User,',
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       'What do you want to do today?',
//                       style: TextStyle(color: Colors.black54),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const SizedBox(height: 30),
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: const [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(''),
//                       SizedBox(height: 6),
//                       Text(
//                         '',
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(''),
//                       SizedBox(height: 6),
//                       Text(
//                         '',
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 25),
//             const Text(
//               'Quick Actions',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 15),
//             Expanded(
//               child: GridView.count(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 15,
//                 mainAxisSpacing: 15,
//                 children: [
//                   ActionCard(
//                     title: 'View Profile',
//                     color: Colors.pinkAccent,
//                     icon: Icons.verified_user,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => UserViewprofile(title: '')),
//                       );
//                     },
//                   ),
//                   ActionCard(
//                     title: 'View stock',
//                     color: Colors.deepPurple,
//                     icon: Icons.table_view_outlined,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => StockListPage(title: '')),
//                       );
//                     },
//                   ),
//                   ActionCard(
//                     title: 'Change Password',
//                     color: Colors.deepPurple,
//                     icon: Icons.table_view_outlined,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => Mychangepassword(title: '')),
//                       );
//                     },
//                   ),
//                   ActionCard(
//                     title: 'Send Complaint',
//                     color: Colors.deepPurple,
//                     icon: Icons.table_view_outlined,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => MySendComplaint(title: '')),
//                       );
//                     },
//                   ),
//                   ActionCard(
//                     title: 'View Reply',
//                     color: Colors.deepPurple,
//                     icon: Icons.table_view_outlined,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => UserViewreply(title: '')),
//                       );
//                     },
//                   ),
//                   ActionCard(
//                     title: 'View Notification',
//                     color: Colors.deepPurple,
//                     icon: Icons.table_view_outlined,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => UserViewnotification(title: '')),
//                       );
//                     },
//                   ),
//                   ActionCard(
//                     title: 'View Content',
//                     color: Colors.deepPurple,
//                     icon: Icons.table_view_outlined,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => UserViewcontent(title: '')),
//                       );
//                     },
//                   ),
//                   ActionCard(
//                     title: 'View News',
//                     color: Colors.deepPurple,
//                     icon: Icons.table_view_outlined,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => UserViewnews(title: '')),
//                       );
//                     },
//                   ),
//                   ActionCard(
//                     title: 'View Video',
//                     color: Colors.deepPurple,
//                     icon: Icons.table_view_outlined,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => UserViewvideo(title: '')),
//                       );
//                     },
//                   ),
//                   ActionCard(
//                     title: 'Send Review',
//                     color: Colors.deepPurple,
//                     icon: Icons.table_view_outlined,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => MysendReview()),
//                       );
//                     },
//                   ),
//                 ],
//
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ActionCard extends StatelessWidget {
//   final String title;
//   final Color color;
//   final IconData icon;
//   final VoidCallback? onTap; // ADD this
//
//   const ActionCard({
//     super.key,
//     required this.title,
//     required this.color,
//     required this.icon,
//     this.onTap, // ADD this
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap, // USE this
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CircleAvatar(
//               backgroundColor: color,
//               child: Icon(icon, color: Colors.white),
//             ),
//             const SizedBox(height: 10),
//             Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//           ],
//         ),
//       ),
//     );
//   }
// }


// class DrawerContent extends StatefulWidget {
//   const DrawerContent({super.key});
//
//   @override
//   State<DrawerContent> createState() => _DrawerContentState();
// }

// class _DrawerContentState extends State<DrawerContent> {
//   void showDrawerMessage(String message) {
//     Navigator.pop(context); // Close drawer
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }
//
//   // @override
//   // Widget build(BuildContext context) {
//   //   return ListView(
//   //     padding: EdgeInsets.zero,
//   //     children: [
//   //       const DrawerHeader(
//   //         decoration: BoxDecoration(color: Colors.blue),
//   //         child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
//   //       ),
//   //       ListTile(
//   //         leading: const Icon(Icons.dashboard),
//   //         title: const Text('Dashboard'),
//   //         onTap: () => showDrawerMessage('Dashboard selected'),
//   //       ),
//   //       ListTile(
//   //         leading: const Icon(Icons.receipt),
//   //         title: const Text('Add User'),
//   //         onTap: () => showDrawerMessage('Bills selected'),
//   //       ),
//   //       ListTile(
//   //         leading: const Icon(Icons.send),
//   //         title: const Text('Transfers'),
//   //         onTap: () => showDrawerMessage('Transfers selected'),
//   //       ),
//   //       ListTile(
//   //         leading: const Icon(Icons.settings),
//   //         title: const Text('Settings'),
//   //         onTap: () => showDrawerMessage('Settings selected'),
//   //       ),
//   //     ],
//   //   );
//   // }
// }

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradebee1/fav.dart';
import 'package:tradebee1/sendcomplaint.dart';
import 'package:tradebee1/sendreview.dart';
import 'package:tradebee1/view%20content.dart';
import 'package:tradebee1/view%20news.dart';
import 'package:tradebee1/view%20reply.dart';
import 'package:tradebee1/view%20video.dart';
import 'package:tradebee1/viewnoti.dart';
import 'package:tradebee1/viewprofile.dart';
import 'package:tradebee1/viewselledstock.dart';
import 'package:tradebee1/viewstock.dart';
import 'changepassword.dart';
import 'package:http/http.dart' as http;
import 'chatbot.dart';
import 'login.dart';
import 'view buy.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BankingDashboard(),
  ));
}

class BankingDashboard extends StatefulWidget {
  const BankingDashboard({super.key});

  @override
  State<BankingDashboard> createState() => _BankingDashboardState();
}

class _BankingDashboardState extends State<BankingDashboard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  void callbackDispatcher(String message) {
    print("hiii");

    // Workmanager().executeTask((task, inputData) {
    // initialise the plugin of flutterlocalnotifications.
    FlutterLocalNotificationsPlugin flip =
    new FlutterLocalNotificationsPlugin();

    // app_icon needs to be a added as a drawable
    // resource to the Android head project.
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    // var IOS = new IOSInitializationSettings();

    // initialise settings for both Android and iOS device.
    var settings = new InitializationSettings(android: android);
    flip.initialize(settings);
    _showNotificationWithDefaultSound(flip, message);
    // return Future.value(true);
    // });
  }

  Future _showNotificationWithDefaultSound(flip,String message) async {
// Show a notification after every 15 minute with the first
// appearance happening a minute after invoking the method
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max, priority: Priority.high);

// initialise channel platform for both Android and iOS device.
    var platformChannelSpecifics =
    new NotificationDetails(android: androidPlatformChannelSpecifics);
    await flip.show(
        0,
        'REMINDER',
        message,
        platformChannelSpecifics,
        payload: 'Default_Sound');
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 15), (timer) {
      getdata();
    });
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }


  String Reminer = "", id = "", Date = "", Time = "";

  Future<void> getdata() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    try {
      // String url = "${sh.getString("url").toString()}/viewNotification/";


      String url = sh.getString('url').toString();

      final urls = Uri.parse('$url/viewNotification/');

      String nid="0";
      if(sh.containsKey("nid")==false) {}
      else{
        nid=sh.getString('nid').toString();
      }
      // Fluttertoast.showToast(msg:nid);

      var datas = await http
          .post(urls, body: {'nid': nid });
      var jsondata = json.decode(datas.body);
      String status = jsondata['status'];
      print(status);
      if (status == "ok") {
        String nid = jsondata['nid'];
        String message = jsondata['message'];
        sh.setString('nid',nid);
        callbackDispatcher(message);
        // var data = json.decode(datas.body)['data'];
        // setState(() {
        //   for (int i = 0; i < data.length; i++) {
        //     Reminer = (data[i]['Reminder'].toString());
        //     id = (data[i]['id'].toString());
        //     Date = (data[i]['Date']);
        //     Time = (data[i]['Time']);
        //   }
        // });

      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }



  @override
  void dispose() {
    _animationController.dispose();
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
                      // Top Bar with Logo and Notifications
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
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
                            ],
                          ),
                          Row(
                            children: [
                              Container(
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
                                  Icons.notifications_outlined,
                                  color: Color(0xFF64B5F6),
                                  size: 22,
                                ),
                              ),
                              SizedBox(width: 12),
                              GestureDetector(
                                onTap: () {


                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  MyLogin(title: 'login')),
                                  );

                                },
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
                                    Icons.logout,
                                    color: Color(0xFF64B5F6),
                                    size: 22,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 24),

                      // User Greeting Section
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xFF0D1117),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Color(0xFF1E88E5).withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Color(0xFF1E88E5),
                                  width: 2,
                                ),
                                image: DecorationImage(
                                  image: AssetImage('assets/user.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome Back, Trader',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Ready to dominate the markets?',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF64B5F6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      // Market Stats
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
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
                            _buildMiniStat('BTC', '+2.4%', true),
                            Container(
                              height: 25,
                              width: 1,
                              color: Color(0xFF1E88E5).withOpacity(0.3),
                            ),
                            _buildMiniStat('ETH', '+1.8%', true),
                            Container(
                              height: 25,
                              width: 1,
                              color: Color(0xFF1E88E5).withOpacity(0.3),
                            ),
                            _buildMiniStat('NASDAQ', '-0.3%', false),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Quick Actions Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Color(0xFF1E88E5),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'QUICK ACTIONS',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                // Actions Grid
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 1.1,
                      children: [
                        _buildActionCard(
                          context,
                          'View Profile',
                          Icons.account_circle_outlined,
                          Color(0xFF1E88E5),
                              () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserViewprofile(title: ''))),
                        ),
                        _buildActionCard(
                          context,
                          'Stock Market',
                          Icons.trending_up_rounded,
                          Color(0xFF26A69A),
                              () => Navigator.push(context, MaterialPageRoute(builder: (context) => StockListPage(title: ''))),
                        ),
                        _buildActionCard(
                          context,
                          'Change Password',
                          Icons.lock_reset_rounded,
                          Color(0xFFFF7043),
                              () => Navigator.push(context, MaterialPageRoute(builder: (context) => Mychangepassword(title: ''))),
                        ),
                        _buildActionCard(
                          context,
                          'Favorie Stock',
                          Icons.favorite,
                          Color(0xFFEC407A),
                              () => Navigator.push(context, MaterialPageRoute(builder: (context) => view_fav_stock(title: ''))),
                        ),
                        _buildActionCard(
                          context,
                          'View Reply',
                          Icons.question_answer_outlined,
                          Color(0xFF5C6BC0),
                              () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserViewreply(title: ''))),
                        ),
                        _buildActionCard(
                          context,
                          'Notifications',
                          Icons.notifications_active_outlined,
                          Color(0xFFFFCA28),
                              () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserViewnotification(title: ''))),
                        ),
                        _buildActionCard(
                          context,
                          'View Content',
                          Icons.article_outlined,
                          Color(0xFF66BB6A),
                              () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserViewcontent(title: ''))),
                        ),
                        _buildActionCard(
                          context,
                          'Market News',
                          Icons.newspaper_outlined,
                          Color(0xFF42A5F5),
                              () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserViewnews(title: ''))),
                        ),
                        _buildActionCard(
                          context,
                          'Video Tutorials',
                          Icons.play_circle_outline_rounded,
                          Color(0xFFAB47BC),
                              () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserViewvideo(title: ''))),
                        ),
                        _buildActionCard(
                          context,
                          'Send Review',
                          Icons.rate_review_outlined,
                          Color(0xFFEF5350),
                              () => Navigator.push(context, MaterialPageRoute(builder: (context) => MysendReview())),
                        ),
                        _buildActionCard(
                          context,
                          'Chatbot',
                          Icons.smart_toy_outlined,
                          Color(0xFFFF7043),
                              () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChatBotPage())),
                        ),
                        _buildActionCard(
                          context,
                          'View Buy Stock',
                          Icons.shopping_bag_rounded ,
                          Color(0xFF00897B),
                              () => Navigator.push(context, MaterialPageRoute(builder: (context) => Viewbuystock(title: ''))),
                        ),
                        _buildActionCard(
                          context,
                          'View Selled Stock',
                          Icons.shopping_bag_rounded ,
                          Color(0xFF00897B),
                              () => Navigator.push(context, MaterialPageRoute(builder: (context) => ViewSelledStock(title: ''))),
                        ),
                      ],
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

  Widget _buildMiniStat(String label, String value, bool isPositive) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Color(0xFF8B9DC3),
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Icon(
              isPositive ? Icons.arrow_upward : Icons.arrow_downward,
              size: 12,
              color: isPositive ? Color(0xFF26A69A) : Color(0xFFEF5350),
            ),
            SizedBox(width: 2),
            Text(
              value,
              style: TextStyle(
                color: isPositive ? Color(0xFF26A69A) : Color(0xFFEF5350),
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
      BuildContext context,
      String title,
      IconData icon,
      Color color,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF0D1117),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.15),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color,
                      color.withOpacity(0.7),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.4),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}