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
//       home: view_price_detailes(title: 'View Users'),
//     );
//   }
// }
//
// class view_price_detailes extends StatefulWidget {
//   const view_price_detailes({super.key, required this.title});
//   final String title;
//
//   @override
//   State<view_price_detailes> createState() => _view_price_detailesState();
// }
//
// class _view_price_detailesState extends State<view_price_detailes> {
//
//
//   String date="";
//   String amount="";
//   String stock="";
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
//       String name = sh.getString('name') ?? '';
//       String img = sh.getString('img_url') ?? '';
//       String apiUrl = '$urls/view_price/';
//
//       var response = await http.post(Uri.parse(apiUrl), body: {
//         'lid':lid,
//         'name':name
//       });
//       var jsonData = json.decode(response.body);
//
//       if (jsonData['status'] == 'ok') {
//         String date_=jsonData['date'].toString();
//         String amount_=jsonData['amount'].toString();
//         String stock_=jsonData['stock'].toString();
//
//
//         setState(() {
//
//           date=date_;
//           amount=amount_;
//           stock=stock_;
//
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
//             appBar: AppBar(
//               backgroundColor: Color.fromARGB(255, 232, 177, 61),
//               title: Text('View Price'),
//
//             ),
//             body: Column(
//               children: [
//                 Text(date),
//                 Text(amount),
//                 Text(stock),
//
//               ],
//             )
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
      home: view_price_detailes(title: 'View Price'),
    );
  }
}

class view_price_detailes extends StatefulWidget {
  const view_price_detailes({super.key, required this.title});
  final String title;

  @override
  State<view_price_detailes> createState() => _view_price_detailesState();
}

class _view_price_detailesState extends State<view_price_detailes> with SingleTickerProviderStateMixin {
  String date = "";
  String amount = "";
  String stock = "";
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
    setState(() {
      isLoading = true;
    });

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url') ?? '';
      String lid = sh.getString('lid') ?? '';
      String name = sh.getString('name') ?? '';
      String img = sh.getString('img_url') ?? '';
      String apiUrl = '$urls/view_price/';

      var response = await http.post(Uri.parse(apiUrl), body: {
        'lid': lid,
        'name': name
      });
      var jsonData = json.decode(response.body);

      if (jsonData['status'] == 'ok') {
        String date_ = jsonData['date'].toString();
        String amount_ = jsonData['amount'].toString();
        String stock_ = jsonData['stock'].toString();

        setState(() {
          date = date_;
          amount = amount_;
          stock = stock_;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching price: $e");
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
                                    Color(0xFF26A69A),
                                    Color(0xFF00897B),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF26A69A).withOpacity(0.4),
                                    blurRadius: 15,
                                    spreadRadius: 3,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.show_chart,
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
                                    'STOCK PRICE',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Current market details',
                                    style: TextStyle(
                                      fontSize: 12,
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
                                  color: Color(0xFF26A69A).withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.refresh,
                                color: Color(0xFF26A69A),
                                size: 22,
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

                  SizedBox(height: 30),

                  // Content
                  Expanded(
                    child: isLoading
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFF26A69A),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Loading price details...',
                            style: TextStyle(
                              color: Color(0xFF64B5F6),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                        : SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          // Stock Name Card
                          TweenAnimationBuilder(
                            duration: Duration(milliseconds: 500),
                            tween: Tween<double>(begin: 0, end: 1),
                            builder: (context, double value, child) {
                              return Transform.scale(
                                scale: value,
                                child: child,
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF26A69A),
                                    Color(0xFF00897B),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF26A69A).withOpacity(0.3),
                                    blurRadius: 20,
                                    spreadRadius: 3,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.trending_up_rounded,
                                    size: 48,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    stock.isEmpty ? 'N/A' : stock,
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      letterSpacing: 1,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'STOCK SYMBOL',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white.withOpacity(0.8),
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 24),

                          // Price Card
                          TweenAnimationBuilder(
                            duration: Duration(milliseconds: 600),
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
                              padding: EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Color(0xFF0D1117),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Color(0xFF26A69A).withOpacity(0.3),
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF26A69A).withOpacity(0.15),
                                    blurRadius: 20,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 56,
                                        height: 56,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF26A69A),
                                              Color(0xFF00897B),
                                            ],
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xFF26A69A).withOpacity(0.4),
                                              blurRadius: 12,
                                              spreadRadius: 2,
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          Icons.attach_money_rounded,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'CURRENT PRICE',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF64B5F6),
                                                letterSpacing: 1.5,
                                              ),
                                            ),
                                            SizedBox(height: 6),
                                            Text(
                                              amount.isEmpty ? '\$0.00' : '\$$amount',
                                              style: TextStyle(
                                                fontSize: 28,
                                                fontWeight: FontWeight.w900,
                                                color: Color(0xFF26A69A),
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
                          ),

                          SizedBox(height: 24),

                          // Date Card
                          TweenAnimationBuilder(
                            duration: Duration(milliseconds: 700),
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
                                    blurRadius: 20,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 56,
                                    height: 56,
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
                                          blurRadius: 12,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.calendar_today_rounded,
                                      color: Colors.white,
                                      size: 26,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'LAST UPDATED',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF64B5F6),
                                            letterSpacing: 1.5,
                                          ),
                                        ),
                                        SizedBox(height: 6),
                                        Text(
                                          date.isEmpty ? 'N/A' : date,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 24),

                          // Info Banner
                          TweenAnimationBuilder(
                            duration: Duration(milliseconds: 800),
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
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Color(0xFF1E88E5).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Color(0xFF1E88E5).withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: Color(0xFF64B5F6),
                                    size: 24,
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'Prices are updated in real-time based on market conditions',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF64B5F6),
                                        height: 1.4,
                                      ),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}