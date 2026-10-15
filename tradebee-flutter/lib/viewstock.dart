// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tradebee1/stock_details.dart';
//
// import 'Userhome.dart';
// import 'login.dart';
//
// void main() {
//   runApp(const Viewhigh());
// }
//
// class Viewhigh extends StatelessWidget {
//   const Viewhigh({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'View Stock Details',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: const Color.fromARGB(207, 97, 161, 156),
//         ),
//         useMaterial3: true,
//       ),
//       home: const StockListPage(title: 'Stocks'),
//     );
//   }
// }
//
// class StockListPage extends StatefulWidget {
//   const StockListPage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<StockListPage> createState() => _StockListPageState();
// }
//
// class _StockListPageState extends State<StockListPage> {
//   List<String> name_ = <String>[];
//   List<String> a_ = <String>[];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchStocks();
//
//
//   }
//
//   Future<void> _fetchStocks() async {
//     List<String> name = <String>[];
//     List<String> a = <String>[];
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       String url = '$urls/getallstock/';
//
//       var data = await http.post(Uri.parse(url), body: {'lid': lid});
//       var jsondata = json.decode(data.body);
//       if (jsondata['status'] == 'ok') {
//         var arr = jsondata["data"];
//         for (int i = 0; i < arr.length; i++) {
//           name.add(arr[i]['name'].toString());
//           a.add(arr[i]['a'].toString());
//         }
//       }
//       setState(() {
//         name_ = name;
//         a_ = a;
//       });
//     } catch (e) {
//       print("Error ------------------- " + e.toString());
//       Fluttertoast.showToast(msg: "Error fetching stocks: $e");
//     }
//   }
  //
  // String name__ = "";
  // String gender_ = "";
  // String email_ = "";
  // String dob_ = "";
  // String phone_ = "";
  // String place_ = "";
  // String district_ = "";
  // String state_ = "";
  // String pin_ = "";
  // String photo_ = "";
  //
  //
  // void _fetchProfileData() async {
  //   SharedPreferences sh = await SharedPreferences.getInstance();
  //   String url = sh.getString('url').toString();
  //   String lid = sh.getString('lid').toString();
  //   String img = sh.getString('img_url').toString();
  //
  //   final urls = Uri.parse('$url/view_userprofile/');
  //   try {
  //     final response = await http.post(urls, body: {'lid': lid});
  //     if (response.statusCode == 200) {
  //       String status = jsonDecode(response.body)['status'];
  //       if (status == 'ok') {
  //         setState(() {
  //           name__ = jsonDecode(response.body)['name'].toString();
  //           dob_ = jsonDecode(response.body)['dob'].toString();
  //           gender_ = jsonDecode(response.body)['gender'].toString();
  //           email_ = jsonDecode(response.body)['email'].toString();
  //           phone_ = jsonDecode(response.body)['phone'].toString();
  //           place_ = jsonDecode(response.body)['place'].toString();
  //           district_ = jsonDecode(response.body)['district'].toString();
  //           state_ = jsonDecode(response.body)['state'].toString();
  //           pin_ = jsonDecode(response.body)['pin'].toString();
  //           photo_ = img + jsonDecode(response.body)['photo'].toString();
  //         });
  //       } else {
  //         Fluttertoast.showToast(msg: 'Profile Not Found');
  //       }
  //     } else {
  //       Fluttertoast.showToast(msg: 'Network Error');
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: e.toString());
  //   }
  // }
  //
  // Widget _drawerItem(IconData icon, String title, VoidCallback onTap,
  //     {Color? color}) {
  //   return ListTile(
  //     leading: Icon(icon, color: color ?? Colors.blueAccent),
  //     title: Text(title, style: TextStyle(color: color ?? Colors.blueAccent)),
  //     onTap: () {
  //       Navigator.pop(context);
  //       onTap();
  //     },
  //   );
  // }
  // Widget _buildDrawer() {
  //   return Drawer(
  //     backgroundColor: Colors.white,
  //     child: Column(
  //       children: [
  //         UserAccountsDrawerHeader(
  //           decoration: BoxDecoration(
  //             gradient: LinearGradient(
  //               colors: [Colors.lightBlueAccent, Colors.blueAccent],
  //               begin: Alignment.topLeft,
  //               end: Alignment.bottomRight,
  //             ),
  //           ),
  //           accountName:  Text(
  //             "Hello, $name__!",
  //             style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
  //           ),
  //           accountEmail: const Text(
  //             "Welcome back!",
  //             style: TextStyle(color: Colors.white70),
  //           ),
  //           currentAccountPicture: CircleAvatar(
  //             backgroundImage: NetworkImage(photo_),
  //           ),
  //         ),
  //         Expanded(
  //           child: ListView(
  //             padding: EdgeInsets.zero,
  //             children: [
  //               _drawerItem(Icons.person, "View Profile", () {
  //                 Navigator.push(
  //                     context,
  //                     MaterialPageRoute(builder: (context) => ViewProfilePage(title: '')));
  //               }, color: Colors.blueAccent),
  //               _drawerItem(Icons.video_library, "View Videos", () {
  //                 Navigator.push(context,
  //                     MaterialPageRoute(builder: (context) => view_videos(title: '')));
  //               }, color: Colors.blueAccent),
  //               _drawerItem(Icons.newspaper, "View Latest News", () {
  //                 Navigator.push(context,
  //                     MaterialPageRoute(builder: (context) => view_news(title: '')));
  //               }, color: Colors.blueAccent),
  //               _drawerItem(Icons.notifications, "View Notifications", () {
  //                 Navigator.push(context,
  //                     MaterialPageRoute(builder: (context) => view_notification(title: '')));
  //               }, color: Colors.blueAccent),
  //               _drawerItem(Icons.reviews, "Send Review", () {
  //                 Navigator.push(context,
  //                     MaterialPageRoute(builder: (context) => review(title: '')));
  //               }, color: Colors.blueAccent),
  //               _drawerItem(Icons.report_problem, "Send Complaint", () {
  //                 Navigator.push(
  //                     context,
  //                     MaterialPageRoute(builder: (context) => sendcomplaint(title: '')));
  //               }, color: Colors.blueAccent),
  //
  //               _drawerItem(Icons.reply, "View Reply", () {
  //                 Navigator.push(context,
  //                     MaterialPageRoute(builder: (context) => view_reply(title: '')));
  //               }, color: Colors.blueAccent),
  //
  //               _drawerItem(Icons.lock, "Change Password", () {
  //                 Navigator.push(context,
  //                     MaterialPageRoute(builder: (context) => Change_password()));
  //               }, color: Colors.blueAccent),
  //               const Divider(),
  //               _drawerItem(Icons.logout, "Log Out", () {
  //                 Navigator.pushReplacement(
  //                   context,
  //                   MaterialPageRoute(builder: (context) => const MyLoginPage(title: '')),
  //                 );
  //               }, color: Colors.redAccent),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => BankingDashboard()),
//         );
//         return true;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.deepPurpleAccent,
//           title: Text('Stock',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
//           centerTitle: true,
//         ),
//
//         backgroundColor: Colors.white,
//         body: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: name_.isEmpty
//               ? const Center(child: CircularProgressIndicator())
//               : GridView.builder(
//             physics: const BouncingScrollPhysics(),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3, // 4 columns
//               crossAxisSpacing: 12,
//               mainAxisSpacing: 12,
//               childAspectRatio: 1.0,
//             ),
//             itemCount: name_.length,
//             itemBuilder: (context, index) {
//               return _buildStockTile(context, index);
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStockTile(BuildContext context, int index) {
//     return GestureDetector(
//       onTap: () async {
//         SharedPreferences sh = await SharedPreferences.getInstance();
//         sh.setString("name", name_[index]);
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ViewStockDetails(title: 'Stock Details'),
//           ),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.cyan.shade200,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 4,
//               offset: Offset(2, 2),
//             ),
//           ],
//         ),
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               name_[index],
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//
// }
//===========================
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tradebee1/stock_details.dart';
// import 'Userhome.dart';
// import 'login.dart';
//
// void main() {
//   runApp(const Viewhigh());
// }
//
// class Viewhigh extends StatelessWidget {
//   const Viewhigh({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'View Stock Details',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: const Color.fromARGB(207, 97, 161, 156),
//         ),
//         useMaterial3: true,
//       ),
//       home: const StockListPage(title: 'Stocks'),
//     );
//   }
// }
//
// class StockListPage extends StatefulWidget {
//   const StockListPage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<StockListPage> createState() => _StockListPageState();
// }
//
// class _StockListPageState extends State<StockListPage> with SingleTickerProviderStateMixin {
//   List<String> name_ = <String>[];
//   List<String> a_ = <String>[];
//   List<String> filteredNames = <String>[];
//   List<String> filteredA = <String>[];
//   bool isLoading = true;
//   String searchQuery = '';
//
//   bool isLiked = false;
//
//
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   final TextEditingController _searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: Duration(milliseconds: 800),
//       vsync: this,
//     );
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//     );
//     _animationController.forward();
//     _fetchStocks();
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _fetchStocks() async {
//     setState(() {
//       isLoading = true;
//     });
//
//     List<String> name = <String>[];
//     List<String> a = <String>[];
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       String url = '$urls/getallstock/';
//
//       var data = await http.post(Uri.parse(url), body: {'lid': lid});
//       var jsondata = json.decode(data.body);
//       if (jsondata['status'] == 'ok') {
//         var arr = jsondata["data"];
//         for (int i = 0; i < arr.length; i++) {
//           name.add(arr[i]['name'].toString());
//           a.add(arr[i]['a'].toString());
//         }
//       }
//       setState(() {
//         name_ = name;
//         a_ = a;
//         filteredNames = name;
//         filteredA = a;
//         isLoading = false;
//       });
//     } catch (e) {
//       print("Error ------------------- " + e.toString());
//       setState(() {
//         isLoading = false;
//       });
//       Fluttertoast.showToast(msg: "Error fetching stocks: $e");
//     }
//   }
//
//   void _filterStocks(String query) {
//     setState(() {
//       searchQuery = query;
//       if (query.isEmpty) {
//         filteredNames = name_;
//         filteredA = a_;
//       } else {
//         List<String> tempNames = [];
//         List<String> tempA = [];
//         for (int i = 0; i < name_.length; i++) {
//           if (name_[i].toLowerCase().contains(query.toLowerCase())) {
//             tempNames.add(name_[i]);
//             tempA.add(a_[i]);
//           }
//         }
//         filteredNames = tempNames;
//         filteredA = tempA;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => BankingDashboard()),
//         );
//         return false;
//       },
//       child: Scaffold(
//         body: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Color(0xFF000000),
//                 Color(0xFF0A1628),
//                 Color(0xFF000000),
//               ],
//             ),
//           ),
//           child: SafeArea(
//             child: Column(
//               children: [
//                 // Header
//                 FadeTransition(
//                   opacity: _fadeAnimation,
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             IconButton(
//                               onPressed: () {
//                                 Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => BankingDashboard(),
//                                   ),
//                                 );
//                               },
//                               icon: Container(
//                                 padding: EdgeInsets.all(8),
//                                 decoration: BoxDecoration(
//                                   color: Color(0xFF0D1117),
//                                   borderRadius: BorderRadius.circular(12),
//                                   border: Border.all(
//                                     color: Color(0xFF1E88E5).withOpacity(0.3),
//                                     width: 1,
//                                   ),
//                                 ),
//                                 child: Icon(
//                                   Icons.arrow_back,
//                                   color: Color(0xFF64B5F6),
//                                   size: 20,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 12),
//                             Container(
//                               width: 45,
//                               height: 45,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 gradient: LinearGradient(
//                                   colors: [
//                                     Color(0xFF5C6BC0),
//                                     Color(0xFF3949AB),
//                                   ],
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Color(0xFF5C6BC0).withOpacity(0.4),
//                                     blurRadius: 15,
//                                     spreadRadius: 3,
//                                   ),
//                                 ],
//                               ),
//                               child: Icon(
//                                 Icons.show_chart,
//                                 size: 24,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             SizedBox(width: 12),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Stock Market',
//                                     style: TextStyle(
//                                       fontSize: 22,
//                                       fontWeight: FontWeight.w900,
//                                       color: Colors.white,
//                                       letterSpacing: 1,
//                                     ),
//                                   ),
//                                   Text(
//                                     '${filteredNames.length} stocks available',
//                                     style: TextStyle(
//                                       fontSize: 12,
//                                       color: Color(0xFF64B5F6),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             IconButton(
//                               onPressed: () => _fetchStocks(),
//                               icon: Container(
//                                 padding: EdgeInsets.all(8),
//                                 decoration: BoxDecoration(
//                                   color: Color(0xFF0D1117),
//                                   borderRadius: BorderRadius.circular(12),
//                                   border: Border.all(
//                                     color: Color(0xFF1E88E5).withOpacity(0.3),
//                                     width: 1,
//                                   ),
//                                 ),
//                                 child: Icon(
//                                   Icons.refresh,
//                                   color: Color(0xFF64B5F6),
//                                   size: 20,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 16),
//
//                         // Search Bar
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Color(0xFF0D1117),
//                             borderRadius: BorderRadius.circular(16),
//                             border: Border.all(
//                               color: Color(0xFF1E88E5).withOpacity(0.3),
//                               width: 1.5,
//                             ),
//                           ),
//                           child: TextField(
//                             controller: _searchController,
//                             onChanged: _filterStocks,
//                             style: TextStyle(color: Colors.white),
//                             decoration: InputDecoration(
//                               hintText: 'Search stocks...',
//                               hintStyle: TextStyle(
//                                 color: Color(0xFF8B9DC3),
//                                 fontSize: 14,
//                               ),
//                               prefixIcon: Icon(
//                                 Icons.search,
//                                 color: Color(0xFF64B5F6),
//                               ),
//                               suffixIcon: searchQuery.isNotEmpty
//                                   ? IconButton(
//                                 icon: Icon(
//                                   Icons.clear,
//                                   color: Color(0xFF64B5F6),
//                                 ),
//                                 onPressed: () {
//                                   _searchController.clear();
//                                   _filterStocks('');
//                                 },
//                               )
//                                   : null,
//                               border: InputBorder.none,
//                               contentPadding: EdgeInsets.symmetric(
//                                 horizontal: 16,
//                                 vertical: 14,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 // Content
//                 Expanded(
//                   child: isLoading
//                       ? Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircularProgressIndicator(
//                           valueColor: AlwaysStoppedAnimation<Color>(
//                             Color(0xFF1E88E5),
//                           ),
//                         ),
//                         SizedBox(height: 16),
//                         Text(
//                           'Loading stocks...',
//                           style: TextStyle(
//                             color: Color(0xFF64B5F6),
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                       : filteredNames.isEmpty
//                       ? Center(
//                     child: FadeTransition(
//                       opacity: _fadeAnimation,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             width: 120,
//                             height: 120,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Color(0xFF0D1117),
//                               border: Border.all(
//                                 color: Color(0xFF1E88E5).withOpacity(0.3),
//                                 width: 2,
//                               ),
//                             ),
//                             child: Icon(
//                               Icons.search_off,
//                               size: 50,
//                               color: Color(0xFF64B5F6),
//                             ),
//                           ),
//                           SizedBox(height: 24),
//                           Text(
//                             searchQuery.isEmpty
//                                 ? 'No Stocks Available'
//                                 : 'No Results Found',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             searchQuery.isEmpty
//                                 ? 'No stocks to display'
//                                 : 'Try a different search term',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Color(0xFF8B9DC3),
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                       : RefreshIndicator(
//                     onRefresh: _fetchStocks,
//                     color: Color(0xFF1E88E5),
//                     backgroundColor: Color(0xFF0D1117),
//                     child: GridView.builder(
//                       padding: EdgeInsets.all(20),
//                       physics: AlwaysScrollableScrollPhysics(),
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         crossAxisSpacing: 12,
//                         mainAxisSpacing: 12,
//                         childAspectRatio: 1.0,
//                       ),
//                       itemCount: filteredNames.length,
//                       itemBuilder: (context, index) {
//                         return FadeTransition(
//                           opacity: _fadeAnimation,
//                           child: _buildStockTile(context, index),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStockTile(BuildContext context, int index) {
//     return GestureDetector(
//       onTap: () async {
//         SharedPreferences sh = await SharedPreferences.getInstance();
//         sh.setString("name", filteredNames[index]);
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ViewStockDetails(title: 'Stock Details'),
//           ),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Color(0xFF0D1117),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: Color(0xFF1E88E5).withOpacity(0.3),
//             width: 1.5,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Color(0xFF1E88E5).withOpacity(0.1),
//               blurRadius: 15,
//               spreadRadius: 2,
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 40,
//               height: 40,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: LinearGradient(
//                   colors: [
//                     Color(0xFF1E88E5),
//                     Color(0xFF1565C0),
//                   ],
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Color(0xFF1E88E5).withOpacity(0.3),
//                     blurRadius: 10,
//                     spreadRadius: 2,
//                   ),
//                 ],
//               ),
//               child: Icon(
//                 Icons.trending_up,
//                 size: 20,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(height: 4),
//             // Text(
//             //   'View',
//             //   style: TextStyle(
//             //     fontSize: 10,
//             //     color: Color(0xFF26A69A),
//             //     fontWeight: FontWeight.w600,
//             //   ),
//             // ),
//             Row(children: [
//                 IconButton
//
//                 (
//
//                 onPressed: () async{
//
//                   SharedPreferences sh = await SharedPreferences.getInstance();
//                   String? url = sh.getString('url');
//                   String lid = sh.getString('lid').toString();
//
//                   if (url == null) {
//                     Fluttertoast.showToast(msg: "Server URL not found.");
//                     return;
//                   }
//
//                   final uri = Uri.parse('$url/add_fav/');
//                   var request = http.MultipartRequest('POST', uri);
//                   request.fields['name'] = filteredNames[index];
//                   request.fields['lid'] = lid;
//
//
//
//
//
//                   try {
//                     var response = await request.send();
//                     var respStr = await response.stream.bytesToString();
//                     var data = jsonDecode(respStr);
//
//                     if (response.statusCode == 200 && data['status'] == 'ok') {
//                       // Fluttertoast.showToast(msg: ".");
//                       _fetchStocks();
//                       // Navigator.push(context, MaterialPageRoute(builder: (context)=>UserViewreply(title: '',)));
//
//                     } else {
//                       Fluttertoast.showToast(msg: "Submission failed.");
//                     }
//                   } catch (e) {
//                     Fluttertoast.showToast(msg: "Error: $e");
//                   }
//       setState(() {
//       isLiked = !isLiked;
//       });
//       },
//         icon: Icon(
//           isLiked ? Icons.favorite : Icons.favorite_border,
//           color: isLiked ? Colors.red : Colors.grey,
//         ),
//       ),
//               Text(
//                 filteredNames[index],
//                 textAlign: TextAlign.center,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   height: 1.2,
//                 ),
//               ),
//             //   Padding(
//             //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             //   child: Text(
//             //     filteredNames[index],
//             //     textAlign: TextAlign.center,
//             //     maxLines: 2,
//             //     overflow: TextOverflow.ellipsis,
//             //     style: TextStyle(
//             //       fontSize: 12,
//             //       fontWeight: FontWeight.bold,
//             //       color: Colors.white,
//             //       height: 1.2,
//             //     ),
//             //   ),
//             // ),
//             ],),
//             SizedBox(height: 4),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: BoxDecoration(
//                 color: Color(0xFF26A69A).withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child:
//               Text(
//                 'View',
//                 style: TextStyle(
//                   fontSize: 10,
//                   color: Color(0xFF26A69A),
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tradebee1/stock_details.dart';
// import 'Userhome.dart';
// import 'login.dart';
//
// void main() {
//   runApp(const Viewhigh());
// }
//
// class Viewhigh extends StatelessWidget {
//   const Viewhigh({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'View Stock Details',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: const Color.fromARGB(207, 97, 161, 156),
//         ),
//         useMaterial3: true,
//       ),
//       home: const StockListPage(title: 'Stocks'),
//     );
//   }
// }
//
// class StockListPage extends StatefulWidget {
//   const StockListPage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<StockListPage> createState() => _StockListPageState();
// }
//
// class _StockListPageState extends State<StockListPage>
//
//
//     with SingleTickerProviderStateMixin {
//
//   Future<void> _showAddFavoriteDialog(BuildContext context, int index) async {
//     TextEditingController priceController = TextEditingController();
//
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: const Color(0xFF0D1117),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           title: const Text(
//             "Add Favorite Stock",
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 filteredNames[index],
//                 style: const TextStyle(
//                     color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500),
//               ),
//               const SizedBox(height: 12),
//               TextField(
//                 controller: priceController,
//                 keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 style: const TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   labelText: "Set Target Price",
//                   labelStyle: const TextStyle(color: Color(0xFF64B5F6)),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(color: Color(0xFF1E88E5)),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(color: Color(0xFF64B5F6)),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF1E88E5),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10)),
//               ),
//               onPressed: () async {
//                 String enteredPrice = priceController.text.trim();
//
//                 if (enteredPrice.isEmpty) {
//                   Fluttertoast.showToast(msg: "Please enter a price");
//                   return;
//                 }
//
//                 SharedPreferences sh = await SharedPreferences.getInstance();
//                 String? url = sh.getString('url');
//                 String lid = sh.getString('lid').toString();
//
//                 if (url == null) {
//                   Fluttertoast.showToast(msg: "Server URL not found.");
//                   return;
//                 }
//
//                 final uri = Uri.parse('$url/add_fav/');
//                 var request = http.MultipartRequest('POST', uri);
//                 request.fields['name'] = filteredNames[index];
//                 request.fields['lid'] = lid;
//                 request.fields['price'] = enteredPrice;
//
//                 try {
//                   var response = await request.send();
//                   var respStr = await response.stream.bytesToString();
//                   var data = jsonDecode(respStr);
//
//                   if (response.statusCode == 200 && data['status'] == 'ok') {
//                     Fluttertoast.showToast(msg: "Added to favorites");
//                     setState(() {
//                       likedStatus[index] = true;
//                     });
//                     Navigator.pop(context);
//                   } else {
//                     Fluttertoast.showToast(msg: "Failed to add favorite");
//                   }
//                 } catch (e) {
//                   Fluttertoast.showToast(msg: "Error: $e");
//                 }
//               },
//               child: const Text(
//                 "Add",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   List<String> name_ = <String>[];
//   List<String> a_ = <String>[];
//   List<String> filteredNames = <String>[];
//   List<String> filteredA = <String>[];
//   List<bool> likedStatus = []; // ✅ Added list to track liked items
//   bool isLoading = true;
//   String searchQuery = '';
//
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   final TextEditingController _searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: Duration(milliseconds: 800),
//       vsync: this,
//     );
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//     );
//     _animationController.forward();
//     _fetchStocks();
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _fetchStocks() async {
//     setState(() {
//       isLoading = true;
//     });
//
//     List<String> name = <String>[];
//     List<String> a = <String>[];
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       String url = '$urls/getallstock/';
//
//       var data = await http.post(Uri.parse(url), body: {'lid': lid});
//       var jsondata = json.decode(data.body);
//       if (jsondata['status'] == 'ok') {
//         var arr = jsondata["data"];
//         for (int i = 0; i < arr.length; i++) {
//           name.add(arr[i]['name'].toString());
//           a.add(arr[i]['a'].toString());
//         }
//       }
//       setState(() {
//         name_ = name;
//         a_ = a;
//         filteredNames = name;
//         filteredA = a;
//         likedStatus = List<bool>.filled(name.length, false); // ✅ initialize
//         isLoading = false;
//       });
//     } catch (e) {
//       print("Error ------------------- " + e.toString());
//       setState(() {
//         isLoading = false;
//       });
//       Fluttertoast.showToast(msg: "Error fetching stocks: $e");
//     }
//   }
//
//   void _filterStocks(String query) {
//     setState(() {
//       searchQuery = query;
//       if (query.isEmpty) {
//         filteredNames = name_;
//         filteredA = a_;
//       } else {
//         List<String> tempNames = [];
//         List<String> tempA = [];
//         for (int i = 0; i < name_.length; i++) {
//           if (name_[i].toLowerCase().contains(query.toLowerCase())) {
//             tempNames.add(name_[i]);
//             tempA.add(a_[i]);
//           }
//         }
//         filteredNames = tempNames;
//         filteredA = tempA;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => BankingDashboard()),
//         );
//         return false;
//       },
//       child: Scaffold(
//         body: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Color(0xFF000000),
//                 Color(0xFF0A1628),
//                 Color(0xFF000000),
//               ],
//             ),
//           ),
//           child: SafeArea(
//             child: Column(
//               children: [
//                 // Header
//                 FadeTransition(
//                   opacity: _fadeAnimation,
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             IconButton(
//                               onPressed: () {
//                                 Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => BankingDashboard(),
//                                   ),
//                                 );
//                               },
//                               icon: Container(
//                                 padding: EdgeInsets.all(8),
//                                 decoration: BoxDecoration(
//                                   color: Color(0xFF0D1117),
//                                   borderRadius: BorderRadius.circular(12),
//                                   border: Border.all(
//                                     color:
//                                     Color(0xFF1E88E5).withOpacity(0.3),
//                                     width: 1,
//                                   ),
//                                 ),
//                                 child: Icon(
//                                   Icons.arrow_back,
//                                   color: Color(0xFF64B5F6),
//                                   size: 20,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 12),
//                             Container(
//                               width: 45,
//                               height: 45,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 gradient: LinearGradient(
//                                   colors: [
//                                     Color(0xFF5C6BC0),
//                                     Color(0xFF3949AB),
//                                   ],
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color:
//                                     Color(0xFF5C6BC0).withOpacity(0.4),
//                                     blurRadius: 15,
//                                     spreadRadius: 3,
//                                   ),
//                                 ],
//                               ),
//                               child: Icon(
//                                 Icons.show_chart,
//                                 size: 24,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             SizedBox(width: 12),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Stock Market',
//                                     style: TextStyle(
//                                       fontSize: 22,
//                                       fontWeight: FontWeight.w900,
//                                       color: Colors.white,
//                                       letterSpacing: 1,
//                                     ),
//                                   ),
//                                   Text(
//                                     '${filteredNames.length} stocks available',
//                                     style: TextStyle(
//                                       fontSize: 12,
//                                       color: Color(0xFF64B5F6),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             IconButton(
//                               onPressed: () => _fetchStocks(),
//                               icon: Container(
//                                 padding: EdgeInsets.all(8),
//                                 decoration: BoxDecoration(
//                                   color: Color(0xFF0D1117),
//                                   borderRadius: BorderRadius.circular(12),
//                                   border: Border.all(
//                                     color:
//                                     Color(0xFF1E88E5).withOpacity(0.3),
//                                     width: 1,
//                                   ),
//                                 ),
//                                 child: Icon(
//                                   Icons.refresh,
//                                   color: Color(0xFF64B5F6),
//                                   size: 20,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 16),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Color(0xFF0D1117),
//                             borderRadius: BorderRadius.circular(16),
//                             border: Border.all(
//                               color: Color(0xFF1E88E5).withOpacity(0.3),
//                               width: 1.5,
//                             ),
//                           ),
//                           child: TextField(
//                             controller: _searchController,
//                             onChanged: _filterStocks,
//                             style: TextStyle(color: Colors.white),
//                             decoration: InputDecoration(
//                               hintText: 'Search stocks...',
//                               hintStyle: TextStyle(
//                                 color: Color(0xFF8B9DC3),
//                                 fontSize: 14,
//                               ),
//                               prefixIcon: Icon(
//                                 Icons.search,
//                                 color: Color(0xFF64B5F6),
//                               ),
//                               suffixIcon: searchQuery.isNotEmpty
//                                   ? IconButton(
//                                 icon: Icon(
//                                   Icons.clear,
//                                   color: Color(0xFF64B5F6),
//                                 ),
//                                 onPressed: () {
//                                   _searchController.clear();
//                                   _filterStocks('');
//                                 },
//                               )
//                                   : null,
//                               border: InputBorder.none,
//                               contentPadding: EdgeInsets.symmetric(
//                                 horizontal: 16,
//                                 vertical: 14,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 // Content
//                 Expanded(
//                   child: isLoading
//                       ? Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CircularProgressIndicator(
//                           valueColor: AlwaysStoppedAnimation<Color>(
//                             Color(0xFF1E88E5),
//                           ),
//                         ),
//                         SizedBox(height: 16),
//                         Text(
//                           'Loading stocks...',
//                           style: TextStyle(
//                             color: Color(0xFF64B5F6),
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                       : filteredNames.isEmpty
//                       ? Center(
//                     child: FadeTransition(
//                       opacity: _fadeAnimation,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             width: 120,
//                             height: 120,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Color(0xFF0D1117),
//                               border: Border.all(
//                                 color: Color(0xFF1E88E5)
//                                     .withOpacity(0.3),
//                                 width: 2,
//                               ),
//                             ),
//                             child: Icon(
//                               Icons.search_off,
//                               size: 50,
//                               color: Color(0xFF64B5F6),
//                             ),
//                           ),
//                           SizedBox(height: 24),
//                           Text(
//                             searchQuery.isEmpty
//                                 ? 'No Stocks Available'
//                                 : 'No Results Found',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             searchQuery.isEmpty
//                                 ? 'No stocks to display'
//                                 : 'Try a different search term',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Color(0xFF8B9DC3),
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                       : RefreshIndicator(
//                     onRefresh: _fetchStocks,
//                     color: Color(0xFF1E88E5),
//                     backgroundColor: Color(0xFF0D1117),
//                     child: GridView.builder(
//                       padding: EdgeInsets.all(20),
//                       physics: AlwaysScrollableScrollPhysics(),
//                       gridDelegate:
//                       SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         crossAxisSpacing: 12,
//                         mainAxisSpacing: 12,
//                         childAspectRatio: 1.0,
//                       ),
//                       itemCount: filteredNames.length,
//                       itemBuilder: (context, index) {
//                         return FadeTransition(
//                           opacity: _fadeAnimation,
//                           child:
//                           _buildStockTile(context, index),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStockTile(BuildContext context, int index) {
//     return GestureDetector(
//       onTap: () async {
//         SharedPreferences sh = await SharedPreferences.getInstance();
//         sh.setString("name", filteredNames[index]);
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ViewStockDetails(title: 'Stock Details'),
//           ),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Color(0xFF0D1117),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: Color(0xFF1E88E5).withOpacity(0.3),
//             width: 1.5,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Color(0xFF1E88E5).withOpacity(0.1),
//               blurRadius: 15,
//               spreadRadius: 2,
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 40,
//               height: 40,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: LinearGradient(
//                   colors: [
//                     Color(0xFF1E88E5),
//                     Color(0xFF1565C0),
//                   ],
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Color(0xFF1E88E5).withOpacity(0.3),
//                     blurRadius: 10,
//                     spreadRadius: 2,
//                   ),
//                 ],
//               ),
//               child: Icon(
//                 Icons.trending_up,
//                 size: 20,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(height: 4),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(
//                   onPressed: () async {
//                     if (likedStatus[index]) {
//                       // Already liked → remove favorite directly
//                       SharedPreferences sh = await SharedPreferences.getInstance();
//                       String? url = sh.getString('url');
//                       String lid = sh.getString('lid').toString();
//
//                       if (url == null) {
//                         Fluttertoast.showToast(msg: "Server URL not found.");
//                         return;
//                       }
//
//                       final uri = Uri.parse('$url/add_fav/');
//                       var request = http.MultipartRequest('POST', uri);
//                       request.fields['name'] = filteredNames[index];
//                       request.fields['lid'] = lid;
//
//                       try {
//                         var response = await request.send();
//                         var respStr = await response.stream.bytesToString();
//                         var data = jsonDecode(respStr);
//
//                         if (response.statusCode == 200 && data['status'] == 'ok') {
//                           Fluttertoast.showToast(msg: "Removed from favorites");
//                           setState(() {
//                             likedStatus[index] = false;
//                           });
//                         } else {
//                           Fluttertoast.showToast(msg: "Failed to remove favorite");
//                         }
//                       } catch (e) {
//                         Fluttertoast.showToast(msg: "Error: $e");
//                       }
//                     } else {
//                       // Not liked yet → show popup to set price
//                       _showAddFavoriteDialog(context, index);
//                     }
//                   },
//
//                   // onPressed: () async {
//                   //   SharedPreferences sh =
//                   //   await SharedPreferences.getInstance();
//                   //   String? url = sh.getString('url');
//                   //   String lid = sh.getString('lid').toString();
//                   //
//                   //   if (url == null) {
//                   //     Fluttertoast.showToast(
//                   //         msg: "Server URL not found.");
//                   //     return;
//                   //   }
//                   //
//                   //   final uri = Uri.parse('$url/add_fav/');
//                   //   var request =
//                   //   http.MultipartRequest('POST', uri);
//                   //   request.fields['name'] = filteredNames[index];
//                   //   request.fields['lid'] = lid;
//                   //
//                   //   try {
//                   //     var response = await request.send();
//                   //     var respStr =
//                   //     await response.stream.bytesToString();
//                   //     var data = jsonDecode(respStr);
//                   //
//                   //     if (response.statusCode == 200 &&
//                   //         data['status'] == 'ok') {
//                   //       Fluttertoast.showToast(
//                   //           msg: likedStatus[index]
//                   //               ? "Removed from favorites"
//                   //               : "Added to favorites");
//                   //       setState(() {
//                   //         likedStatus[index] =
//                   //         !likedStatus[index]; // ✅ toggle only this one
//                   //       });
//                   //     } else {
//                   //       Fluttertoast.showToast(
//                   //           msg: "Submission failed.");
//                   //     }
//                   //   } catch (e) {
//                   //     Fluttertoast.showToast(msg: "Error: $e");
//                   //   }
//                   // },
//                   icon: Icon(
//                     likedStatus[index]
//                         ? Icons.favorite
//                         : Icons.favorite_border,
//                     color: likedStatus[index]
//                         ? Colors.red
//                         : Colors.grey,
//                   ),
//                 ),
//                 Text(
//                   filteredNames[index],
//                   textAlign: TextAlign.center,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     height: 1.2,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 4),
//             Container(
//               padding:
//               EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: BoxDecoration(
//                 color: Color(0xFF26A69A).withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 'View',
//                 style: TextStyle(
//                   fontSize: 10,
//                   color: Color(0xFF26A69A),
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tradebee1/stock_details.dart';
// import 'Userhome.dart';
// import 'login.dart';
//
// void main() {
//   runApp(const Viewhigh());
// }
//
// class Viewhigh extends StatelessWidget {
//   const Viewhigh({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'View Stock Details',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: const Color.fromARGB(207, 97, 161, 156),
//         ),
//         useMaterial3: true,
//       ),
//       home: const StockListPage(title: 'Stocks'),
//     );
//   }
// }
//
// class StockListPage extends StatefulWidget {
//   const StockListPage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<StockListPage> createState() => _StockListPageState();
// }
//
// class _StockListPageState extends State<StockListPage>
//     with SingleTickerProviderStateMixin {
//
//   Future<void> _showAddFavoriteDialog(BuildContext context, int index) async {
//     TextEditingController priceController = TextEditingController();
//
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: const Color(0xFF0D1117),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//             side: BorderSide(color: Color(0xFF1E88E5).withOpacity(0.3), width: 1.5),
//           ),
//           title: Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Color(0xFF1E88E5), Color(0xFF1565C0)],
//                   ),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Icon(Icons.star, color: Colors.white, size: 20),
//               ),
//               SizedBox(width: 12),
//               Text(
//                 "Add to Favorites",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 ),
//               ),
//             ],
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding: EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Color(0xFF1E88E5).withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Color(0xFF1E88E5).withOpacity(0.3)),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(Icons.trending_up, color: Color(0xFF64B5F6), size: 20),
//                     SizedBox(width: 8),
//                     Expanded(
//                       child: Text(
//                         filteredNames[index],
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 "Set Target Price",
//                 style: TextStyle(
//                   color: Color(0xFF64B5F6),
//                   fontSize: 13,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: priceController,
//                 keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 style: const TextStyle(color: Colors.white, fontSize: 16),
//                 decoration: InputDecoration(
//                   hintText: "Enter price",
//                   hintStyle: TextStyle(color: Color(0xFF8B9DC3)),
//                   prefixIcon: Icon(Icons.currency_rupee, color: Color(0xFF64B5F6), size: 20),
//                   filled: true,
//                   fillColor: Color(0xFF0D1117),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Color(0xFF1E88E5).withOpacity(0.5)),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(color: Color(0xFF64B5F6), width: 2),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               style: TextButton.styleFrom(
//                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//               ),
//               child: const Text(
//                 "Cancel",
//                 style: TextStyle(color: Colors.grey, fontSize: 15),
//               ),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF1E88E5),
//                 padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 elevation: 0,
//               ),
//               onPressed: () async {
//                 String enteredPrice = priceController.text.trim();
//
//                 if (enteredPrice.isEmpty) {
//                   Fluttertoast.showToast(msg: "Please enter a price");
//                   return;
//                 }
//
//                 SharedPreferences sh = await SharedPreferences.getInstance();
//                 String? url = sh.getString('url');
//                 String lid = sh.getString('lid').toString();
//
//                 if (url == null) {
//                   Fluttertoast.showToast(msg: "Server URL not found.");
//                   return;
//                 }
//
//                 final uri = Uri.parse('$url/add_fav/');
//                 var request = http.MultipartRequest('POST', uri);
//                 request.fields['name'] = filteredNames[index];
//                 request.fields['lid'] = lid;
//                 request.fields['price'] = enteredPrice;
//
//                 try {
//                   var response = await request.send();
//                   var respStr = await response.stream.bytesToString();
//                   var data = jsonDecode(respStr);
//
//                   if (response.statusCode == 200 && data['status'] == 'ok') {
//                     Fluttertoast.showToast(msg: "Added to favorites");
//                     setState(() {
//                       likedStatus[index] = true;
//                     });
//                     Navigator.pop(context);
//                   } else {
//                     Fluttertoast.showToast(msg: "Failed to add favorite");
//                   }
//                 } catch (e) {
//                   Fluttertoast.showToast(msg: "Error: $e");
//                 }
//               },
//               child: const Text(
//                 "Add to Favorites",
//                 style: TextStyle(color: Colors.white, fontSize: 15),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   List<String> name_ = <String>[];
//   List<String> a_ = <String>[];
//   List<String> filteredNames = <String>[];
//   List<String> filteredA = <String>[];
//   List<bool> likedStatus = [];
//   bool isLoading = true;
//   String searchQuery = '';
//
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   final TextEditingController _searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: Duration(milliseconds: 600),
//       vsync: this,
//     );
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
//     );
//     _animationController.forward();
//     _fetchStocks();
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _fetchStocks() async {
//     setState(() {
//       isLoading = true;
//     });
//
//     List<String> name = <String>[];
//     List<String> a = <String>[];
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       String url = '$urls/getallstock/';
//
//       var data = await http.post(Uri.parse(url), body: {'lid': lid});
//       var jsondata = json.decode(data.body);
//       if (jsondata['status'] == 'ok') {
//         var arr = jsondata["data"];
//         for (int i = 0; i < arr.length; i++) {
//           name.add(arr[i]['name'].toString());
//           a.add(arr[i]['a'].toString());
//         }
//       }
//       setState(() {
//         name_ = name;
//         a_ = a;
//         filteredNames = name;
//         filteredA = a;
//         likedStatus = List<bool>.filled(name.length, false);
//         isLoading = false;
//       });
//     } catch (e) {
//       print("Error ------------------- " + e.toString());
//       setState(() {
//         isLoading = false;
//       });
//       Fluttertoast.showToast(msg: "Error fetching stocks: $e");
//     }
//   }
//
//   void _filterStocks(String query) {
//     setState(() {
//       searchQuery = query;
//       if (query.isEmpty) {
//         filteredNames = name_;
//         filteredA = a_;
//       } else {
//         List<String> tempNames = [];
//         List<String> tempA = [];
//         for (int i = 0; i < name_.length; i++) {
//           if (name_[i].toLowerCase().contains(query.toLowerCase())) {
//             tempNames.add(name_[i]);
//             tempA.add(a_[i]);
//           }
//         }
//         filteredNames = tempNames;
//         filteredA = tempA;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => BankingDashboard()),
//         );
//         return false;
//       },
//       child: Scaffold(
//         body: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Color(0xFF000000),
//                 Color(0xFF0A1628),
//                 Color(0xFF001233),
//                 Color(0xFF000000),
//               ],
//               stops: [0.0, 0.3, 0.7, 1.0],
//             ),
//           ),
//           child: SafeArea(
//             child: Column(
//               children: [
//                 // Modern Header
//                 FadeTransition(
//                   opacity: _fadeAnimation,
//                   child: Container(
//                     margin: EdgeInsets.all(16),
//                     padding: EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Color(0xFF0D1117).withOpacity(0.6),
//                       borderRadius: BorderRadius.circular(24),
//                       border: Border.all(
//                         color: Color(0xFF1E88E5).withOpacity(0.3),
//                         width: 1.5,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Color(0xFF1E88E5).withOpacity(0.1),
//                           blurRadius: 20,
//                           spreadRadius: 5,
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => BankingDashboard(),
//                                   ),
//                                 );
//                               },
//                               child: Container(
//                                 padding: EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       Color(0xFF1E88E5).withOpacity(0.3),
//                                       Color(0xFF1565C0).withOpacity(0.3),
//                                     ],
//                                   ),
//                                   borderRadius: BorderRadius.circular(14),
//                                   border: Border.all(
//                                     color: Color(0xFF64B5F6).withOpacity(0.5),
//                                     width: 1,
//                                   ),
//                                 ),
//                                 child: Icon(
//                                   Icons.arrow_back_ios_new,
//                                   color: Color(0xFF64B5F6),
//                                   size: 18,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 16),
//                             Container(
//                               padding: EdgeInsets.all(14),
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 gradient: LinearGradient(
//                                   colors: [
//                                     Color(0xFF5C6BC0),
//                                     Color(0xFF3949AB),
//                                   ],
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Color(0xFF5C6BC0).withOpacity(0.5),
//                                     blurRadius: 20,
//                                     spreadRadius: 3,
//                                   ),
//                                 ],
//                               ),
//                               child: Icon(
//                                 Icons.show_chart_rounded,
//                                 size: 26,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             SizedBox(width: 16),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Stock Market',
//                                     style: TextStyle(
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.w900,
//                                       color: Colors.white,
//                                       letterSpacing: 0.5,
//                                     ),
//                                   ),
//                                   SizedBox(height: 4),
//                                   Row(
//                                     children: [
//                                       Container(
//                                         padding: EdgeInsets.symmetric(
//                                           horizontal: 8,
//                                           vertical: 4,
//                                         ),
//                                         decoration: BoxDecoration(
//                                           color: Color(0xFF1E88E5).withOpacity(0.2),
//                                           borderRadius: BorderRadius.circular(8),
//                                         ),
//                                         child: Text(
//                                           '${filteredNames.length} stocks',
//                                           style: TextStyle(
//                                             fontSize: 12,
//                                             color: Color(0xFF64B5F6),
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () => _fetchStocks(),
//                               child: Container(
//                                 padding: EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       Color(0xFF1E88E5).withOpacity(0.3),
//                                       Color(0xFF1565C0).withOpacity(0.3),
//                                     ],
//                                   ),
//                                   borderRadius: BorderRadius.circular(14),
//                                   border: Border.all(
//                                     color: Color(0xFF64B5F6).withOpacity(0.5),
//                                     width: 1,
//                                   ),
//                                 ),
//                                 child: Icon(
//                                   Icons.refresh_rounded,
//                                   color: Color(0xFF64B5F6),
//                                   size: 22,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 20),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Color(0xFF0D1117),
//                             borderRadius: BorderRadius.circular(18),
//                             border: Border.all(
//                               color: Color(0xFF1E88E5).withOpacity(0.4),
//                               width: 1.5,
//                             ),
//                           ),
//                           child: TextField(
//                             controller: _searchController,
//                             onChanged: _filterStocks,
//                             style: TextStyle(color: Colors.white, fontSize: 15),
//                             decoration: InputDecoration(
//                               hintText: 'Search stocks by name...',
//                               hintStyle: TextStyle(
//                                 color: Color(0xFF8B9DC3),
//                                 fontSize: 14,
//                               ),
//                               prefixIcon: Container(
//                                 margin: EdgeInsets.all(8),
//                                 padding: EdgeInsets.all(8),
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       Color(0xFF1E88E5).withOpacity(0.3),
//                                       Color(0xFF1565C0).withOpacity(0.3),
//                                     ],
//                                   ),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Icon(
//                                   Icons.search_rounded,
//                                   color: Color(0xFF64B5F6),
//                                   size: 20,
//                                 ),
//                               ),
//                               suffixIcon: searchQuery.isNotEmpty
//                                   ? IconButton(
//                                 icon: Icon(
//                                   Icons.close_rounded,
//                                   color: Color(0xFF64B5F6),
//                                   size: 20,
//                                 ),
//                                 onPressed: () {
//                                   _searchController.clear();
//                                   _filterStocks('');
//                                 },
//                               )
//                                   : null,
//                               border: InputBorder.none,
//                               contentPadding: EdgeInsets.symmetric(
//                                 horizontal: 16,
//                                 vertical: 16,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 // Content
//                 Expanded(
//                   child: isLoading
//                       ? Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(20),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             gradient: LinearGradient(
//                               colors: [
//                                 Color(0xFF1E88E5).withOpacity(0.2),
//                                 Color(0xFF1565C0).withOpacity(0.2),
//                               ],
//                             ),
//                           ),
//                           child: CircularProgressIndicator(
//                             valueColor: AlwaysStoppedAnimation<Color>(
//                               Color(0xFF1E88E5),
//                             ),
//                             strokeWidth: 3,
//                           ),
//                         ),
//                         SizedBox(height: 24),
//                         Text(
//                           'Loading stocks...',
//                           style: TextStyle(
//                             color: Color(0xFF64B5F6),
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                       : filteredNames.isEmpty
//                       ? Center(
//                     child: FadeTransition(
//                       opacity: _fadeAnimation,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             width: 140,
//                             height: 140,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               gradient: LinearGradient(
//                                 colors: [
//                                   Color(0xFF1E88E5).withOpacity(0.1),
//                                   Color(0xFF1565C0).withOpacity(0.1),
//                                 ],
//                               ),
//                               border: Border.all(
//                                 color: Color(0xFF1E88E5).withOpacity(0.3),
//                                 width: 2,
//                               ),
//                             ),
//                             child: Icon(
//                               searchQuery.isEmpty
//                                   ? Icons.inventory_2_outlined
//                                   : Icons.search_off_rounded,
//                               size: 60,
//                               color: Color(0xFF64B5F6),
//                             ),
//                           ),
//                           SizedBox(height: 32),
//                           Text(
//                             searchQuery.isEmpty
//                                 ? 'No Stocks Available'
//                                 : 'No Results Found',
//                             style: TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                           SizedBox(height: 12),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 40),
//                             child: Text(
//                               searchQuery.isEmpty
//                                   ? 'There are no stocks to display at the moment'
//                                   : 'Try searching with a different keyword',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Color(0xFF8B9DC3),
//                                 height: 1.5,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                       : RefreshIndicator(
//                     onRefresh: _fetchStocks,
//                     color: Color(0xFF1E88E5),
//                     backgroundColor: Color(0xFF0D1117),
//                     child: ListView.builder(
//                       padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
//                       physics: AlwaysScrollableScrollPhysics(),
//                       itemCount: filteredNames.length,
//                       itemBuilder: (context, index) {
//                         return FadeTransition(
//                           opacity: _fadeAnimation,
//                           child: _buildStockCard(context, index),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStockCard(BuildContext context, int index) {
//     return GestureDetector(
//       onTap: () async {
//         SharedPreferences sh = await SharedPreferences.getInstance();
//         sh.setString("name", filteredNames[index]);
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ViewStockDetails(title: 'Stock Details'),
//           ),
//         );
//       },
//       child: Container(
//         margin: EdgeInsets.only(bottom: 12),
//         decoration: BoxDecoration(
//           color: Color(0xFF0D1117).withOpacity(0.6),
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(
//             color: Color(0xFF1E88E5).withOpacity(0.3),
//             width: 1.5,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Color(0xFF1E88E5).withOpacity(0.08),
//               blurRadius: 15,
//               spreadRadius: 2,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(16),
//           child: Row(
//             children: [
//               Container(
//                 width: 56,
//                 height: 56,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   gradient: LinearGradient(
//                     colors: [
//                       Color(0xFF1E88E5),
//                       Color(0xFF1565C0),
//                     ],
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color(0xFF1E88E5).withOpacity(0.4),
//                       blurRadius: 15,
//                       spreadRadius: 2,
//                     ),
//                   ],
//                 ),
//                 child: Icon(
//                   Icons.trending_up_rounded,
//                   size: 28,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       filteredNames[index],
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         letterSpacing: 0.3,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     SizedBox(height: 6),
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Color(0xFF26A69A).withOpacity(0.2),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         'Tap to view details',
//                         style: TextStyle(
//                           fontSize: 11,
//                           color: Color(0xFF26A69A),
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(width: 12),
//               GestureDetector(
//                 onTap: () async {
//                   if (likedStatus[index]) {
//                     SharedPreferences sh = await SharedPreferences.getInstance();
//                     String? url = sh.getString('url');
//                     String lid = sh.getString('lid').toString();
//
//                     if (url == null) {
//                       Fluttertoast.showToast(msg: "Server URL not found.");
//                       return;
//                     }
//
//                     final uri = Uri.parse('$url/add_fav/');
//                     var request = http.MultipartRequest('POST', uri);
//                     request.fields['name'] = filteredNames[index];
//                     request.fields['lid'] = lid;
//
//                     try {
//                       var response = await request.send();
//                       var respStr = await response.stream.bytesToString();
//                       var data = jsonDecode(respStr);
//
//                       if (response.statusCode == 200 && data['status'] == 'ok') {
//                         Fluttertoast.showToast(msg: "Removed from favorites");
//                         setState(() {
//                           likedStatus[index] = false;
//                         });
//                       } else {
//                         Fluttertoast.showToast(msg: "Failed to remove favorite");
//                       }
//                     } catch (e) {
//                       Fluttertoast.showToast(msg: "Error: $e");
//                     }
//                   } else {
//                     _showAddFavoriteDialog(context, index);
//                   }
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: likedStatus[index]
//                         ? Colors.red.withOpacity(0.2)
//                         : Color(0xFF1E88E5).withOpacity(0.2),
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: likedStatus[index]
//                           ? Colors.red.withOpacity(0.4)
//                           : Color(0xFF1E88E5).withOpacity(0.4),
//                       width: 1.5,
//                     ),
//                   ),
//                   child: Icon(
//                     likedStatus[index] ? Icons.favorite : Icons.favorite_border,
//                     color: likedStatus[index] ? Colors.red : Color(0xFF64B5F6),
//                     size: 22,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tradebee1/stock_details.dart';
// import 'package:tradebee1/view%20price.dart';
// import 'Userhome.dart';
//
// void main() {
//   runApp(const Viewhigh());
// }
//
// class Viewhigh extends StatelessWidget {
//   const Viewhigh({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'View Stock Details',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: const Color.fromARGB(207, 97, 161, 156),
//         ),
//         useMaterial3: true,
//       ),
//       home: const StockListPage(title: 'Stocks'),
//     );
//   }
// }
//
// class StockListPage extends StatefulWidget {
//   const StockListPage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<StockListPage> createState() => _StockListPageState();
// }
//
// class _StockListPageState extends State<StockListPage>
//     with SingleTickerProviderStateMixin {
//
//   Future<void> _showBuyDialog(BuildContext context, String stockName) async {
//     TextEditingController quantityController = TextEditingController();
//     TextEditingController addressController = TextEditingController();
//     TextEditingController privateKeyController = TextEditingController();
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: const Color(0xFF0D1117),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//             side: BorderSide(
//               color: const Color(0xFF1E88E5).withOpacity(0.3),
//               width: 1.5,
//             ),
//           ),
//           title: Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [Color(0xFF1E88E5), Color(0xFF1565C0)],
//                   ),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Icon(Icons.shopping_cart, color: Colors.white, size: 20),
//               ),
//               const SizedBox(width: 12),
//               const Text(
//                 "Buy Stock",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 ),
//               ),
//             ],
//           ),
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Stock name display
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF1E88E5).withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(
//                       color: const Color(0xFF1E88E5).withOpacity(0.3),
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       const Icon(Icons.trending_up, color: Color(0xFF64B5F6), size: 20),
//                       const SizedBox(width: 8),
//                       Expanded(
//                         child: Text(
//                           stockName,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // Quantity Input
//                 const Text(
//                   "Enter Quantity",
//                   style: TextStyle(
//                     color: Color(0xFF64B5F6),
//                     fontSize: 13,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 TextField(
//                   controller: quantityController,
//                   keyboardType: TextInputType.number,
//                   style: const TextStyle(color: Colors.white, fontSize: 16),
//                   decoration: InputDecoration(
//                     hintText: "e.g. 10",
//                     hintStyle: const TextStyle(color: Color(0xFF8B9DC3)),
//                     prefixIcon: const Icon(Icons.confirmation_num, color: Color(0xFF64B5F6)),
//                     filled: true,
//                     fillColor: const Color(0xFF0D1117),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: const Color(0xFF1E88E5).withOpacity(0.5)),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(color: Color(0xFF64B5F6), width: 2),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // Blockchain Address Input
//                 const Text(
//                   "Blockchain Address",
//                   style: TextStyle(
//                     color: Color(0xFF64B5F6),
//                     fontSize: 13,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 TextField(
//                   controller: addressController,
//                   keyboardType: TextInputType.text,
//                   style: const TextStyle(color: Colors.white, fontSize: 16),
//                   decoration: InputDecoration(
//                     hintText: "Enter blockchain wallet address",
//                     hintStyle: const TextStyle(color: Color(0xFF8B9DC3)),
//                     prefixIcon: const Icon(Icons.account_balance_wallet, color: Color(0xFF64B5F6)),
//                     filled: true,
//                     fillColor: const Color(0xFF0D1117),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: const Color(0xFF1E88E5).withOpacity(0.5)),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(color: Color(0xFF64B5F6), width: 2),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // Private Key Input
//                 const Text(
//                   "Private Key",
//                   style: TextStyle(
//                     color: Color(0xFF64B5F6),
//                     fontSize: 13,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 TextField(
//                   controller: privateKeyController,
//                   keyboardType: TextInputType.text,
//                   obscureText: true,
//                   style: const TextStyle(color: Colors.white, fontSize: 16),
//                   decoration: InputDecoration(
//                     hintText: "Enter private key",
//                     hintStyle: const TextStyle(color: Color(0xFF8B9DC3)),
//                     prefixIcon: const Icon(Icons.vpn_key, color: Color(0xFF64B5F6)),
//                     filled: true,
//                     fillColor: const Color(0xFF0D1117),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: const Color(0xFF1E88E5).withOpacity(0.5)),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(color: Color(0xFF64B5F6), width: 2),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               style: TextButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//               ),
//               child: const Text(
//                 "Cancel",
//                 style: TextStyle(color: Colors.grey, fontSize: 15),
//               ),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF1E88E5),
//                 padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               onPressed: () async {
//                 String qty = quantityController.text.trim();
//                 String address = addressController.text.trim();
//                 String privateKey = privateKeyController.text.trim();
//                 // String address = (context.findAncestorWidgetOfExactType<AlertDialog>() as AlertDialog?)?.content != null
//                 //     ? ''
//                 //     : ''; // placeholder
//
//                 if (qty.isEmpty || address.isEmpty || privateKey.isEmpty) {
//                   Fluttertoast.showToast(msg: "All fields are required");
//                   return;
//                 }
//
//                 Navigator.pop(context);
//                 Fluttertoast.showToast(msg: "Buying $qty shares of $stockName...");
//
//                 SharedPreferences sh = await SharedPreferences.getInstance();
//                 String? url = sh.getString('url');
//                 String lid = sh.getString('lid').toString();
//
//                 final uri = Uri.parse('$url/buy/');
//                 var request = http.MultipartRequest('POST', uri);
//                 request.fields['lid'] = lid;
//                 request.fields['stock'] = stockName;
//                 request.fields['quantity'] = qty;
//                 request.fields['address'] = address;
//                 request.fields['private_key'] = privateKey;// replace with your variable
//
//                 var response = await request.send();
//                 var respStr = await response.stream.bytesToString();
//                 var data = jsonDecode(respStr);
//
//                 if (data['status'] == 'ok') {
//                   Fluttertoast.showToast(msg: "Purchase successful!");
//                 } else {
//                   Fluttertoast.showToast(msg: "Purchase failed!");
//                 }
//               },
//               child: const Text(
//                 "OK",
//                 style: TextStyle(color: Colors.white, fontSize: 15),
//               ),
//             ),
//           ],
//         );
//
//         // return AlertDialog(
//         //   backgroundColor: const Color(0xFF0D1117),
//         //   shape: RoundedRectangleBorder(
//         //     borderRadius: BorderRadius.circular(20),
//         //     side: BorderSide(
//         //       color: const Color(0xFF1E88E5).withOpacity(0.3),
//         //       width: 1.5,
//         //     ),
//         //   ),
//         //   title: Row(
//         //     children: [
//         //       Container(
//         //         padding: const EdgeInsets.all(8),
//         //         decoration: BoxDecoration(
//         //           gradient: const LinearGradient(
//         //             colors: [Color(0xFF1E88E5), Color(0xFF1565C0)],
//         //           ),
//         //           borderRadius: BorderRadius.circular(10),
//         //         ),
//         //         child: const Icon(Icons.shopping_cart, color: Colors.white, size: 20),
//         //       ),
//         //       const SizedBox(width: 12),
//         //       const Text(
//         //         "Buy Stock",
//         //         style: TextStyle(
//         //           color: Colors.white,
//         //           fontWeight: FontWeight.bold,
//         //           fontSize: 18,
//         //         ),
//         //       ),
//         //     ],
//         //   ),
//         //   content: Column(
//         //     mainAxisSize: MainAxisSize.min,
//         //     crossAxisAlignment: CrossAxisAlignment.start,
//         //     children: [
//         //       Container(
//         //         padding: const EdgeInsets.all(12),
//         //         decoration: BoxDecoration(
//         //           color: const Color(0xFF1E88E5).withOpacity(0.1),
//         //           borderRadius: BorderRadius.circular(12),
//         //           border: Border.all(
//         //             color: const Color(0xFF1E88E5).withOpacity(0.3),
//         //           ),
//         //         ),
//         //         child: Row(
//         //           children: [
//         //             const Icon(Icons.trending_up, color: Color(0xFF64B5F6), size: 20),
//         //             const SizedBox(width: 8),
//         //             Expanded(
//         //               child: Text(
//         //                 stockName,
//         //                 style: const TextStyle(
//         //                   color: Colors.white,
//         //                   fontSize: 16,
//         //                   fontWeight: FontWeight.w600,
//         //                 ),
//         //               ),
//         //             ),
//         //           ],
//         //         ),
//         //       ),
//         //       const SizedBox(height: 20),
//         //       const Text(
//         //         "Enter Quantity",
//         //         style: TextStyle(
//         //           color: Color(0xFF64B5F6),
//         //           fontSize: 13,
//         //           fontWeight: FontWeight.w500,
//         //         ),
//         //       ),
//         //       const SizedBox(height: 8),
//         //       TextField(
//         //         controller: quantityController,
//         //         keyboardType: TextInputType.number,
//         //         style: const TextStyle(color: Colors.white, fontSize: 16),
//         //         decoration: InputDecoration(
//         //           hintText: "e.g. 10",
//         //           hintStyle: const TextStyle(color: Color(0xFF8B9DC3)),
//         //           prefixIcon: const Icon(Icons.confirmation_num, color: Color(0xFF64B5F6)),
//         //           filled: true,
//         //           fillColor: const Color(0xFF0D1117),
//         //           enabledBorder: OutlineInputBorder(
//         //             borderSide: BorderSide(color: const Color(0xFF1E88E5).withOpacity(0.5)),
//         //             borderRadius: BorderRadius.circular(12),
//         //           ),
//         //           focusedBorder: OutlineInputBorder(
//         //             borderSide: const BorderSide(color: Color(0xFF64B5F6), width: 2),
//         //             borderRadius: BorderRadius.circular(12),
//         //           ),
//         //         ),
//         //       ),
//         //     ],
//         //   ),
//         //   actions: [
//         //     TextButton(
//         //       onPressed: () => Navigator.pop(context),
//         //       style: TextButton.styleFrom(
//         //         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//         //       ),
//         //       child: const Text(
//         //         "Cancel",
//         //         style: TextStyle(color: Colors.grey, fontSize: 15),
//         //       ),
//         //     ),
//         //     ElevatedButton(
//         //       style: ElevatedButton.styleFrom(
//         //         backgroundColor: const Color(0xFF1E88E5),
//         //         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//         //         shape: RoundedRectangleBorder(
//         //           borderRadius: BorderRadius.circular(12),
//         //         ),
//         //       ),
//         //       onPressed: () async {
//         //         String qty = quantityController.text.trim();
//         //
//         //         if (qty.isEmpty) {
//         //           Fluttertoast.showToast(msg: "Please enter quantity");
//         //           return;
//         //         }
//         //
//         //         Navigator.pop(context); // Close the dialog
//         //         Fluttertoast.showToast(
//         //             msg: "You are buying $qty shares of $stockName");
//         //
//         //         // 👇 You can add your API call for buying the stock here later.
//         //         // Example:
//         //
//         //       SharedPreferences sh = await SharedPreferences.getInstance();
//         //       String? url = sh.getString('url');
//         //       String lid = sh.getString('lid').toString();
//         //
//         //       final uri = Uri.parse('$url/buy/');
//         //       var request = http.MultipartRequest('POST', uri);
//         //       request.fields['lid'] = lid;
//         //       request.fields['stock'] = stockName;
//         //       request.fields['quantity'] = qty;
//         //
//         //       var response = await request.send();
//         //       var respStr = await response.stream.bytesToString();
//         //       var data = jsonDecode(respStr);
//         //
//         //       if (data['status'] == 'ok') {
//         //         Fluttertoast.showToast(msg: "Purchase successful!");
//         //       } else {
//         //         Fluttertoast.showToast(msg: "Purchase failed!");
//         //       }
//         //       },
//         //       child: const Text(
//         //         "OK",
//         //         style: TextStyle(color: Colors.white, fontSize: 15),
//         //       ),
//         //     ),
//         //   ],
//         // );
//       },
//     );
//   }
//
//
//   Future<void> _showAddFavoriteDialog(BuildContext context, int index) async {
//     TextEditingController priceController = TextEditingController();
//
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: const Color(0xFF0D1117),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//             side: BorderSide(color: Color(0xFF1E88E5).withOpacity(0.3), width: 1.5),
//           ),
//           title: Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Color(0xFF1E88E5), Color(0xFF1565C0)],
//                   ),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Icon(Icons.star, color: Colors.white, size: 20),
//               ),
//               SizedBox(width: 12),
//               Text(
//                 "Add to Favorites",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18,
//                 ),
//               ),
//             ],
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 padding: EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Color(0xFF1E88E5).withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Color(0xFF1E88E5).withOpacity(0.3)),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(Icons.trending_up, color: Color(0xFF64B5F6), size: 20),
//                     SizedBox(width: 8),
//                     Expanded(
//                       child: Text(
//                         filteredNames[index],
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 "Set Target Price",
//                 style: TextStyle(
//                   color: Color(0xFF64B5F6),
//                   fontSize: 13,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               TextField(
//                 controller: priceController,
//                 keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 style: const TextStyle(color: Colors.white, fontSize: 16),
//                 decoration: InputDecoration(
//                   hintText: "Enter price",
//                   hintStyle: TextStyle(color: Color(0xFF8B9DC3)),
//                   prefixIcon: Icon(Icons.currency_rupee, color: Color(0xFF64B5F6), size: 20),
//                   filled: true,
//                   fillColor: Color(0xFF0D1117),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Color(0xFF1E88E5).withOpacity(0.5)),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: const BorderSide(color: Color(0xFF64B5F6), width: 2),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               style: TextButton.styleFrom(
//                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//               ),
//               child: const Text(
//                 "Cancel",
//                 style: TextStyle(color: Colors.grey, fontSize: 15),
//               ),
//             ),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF1E88E5),
//                 padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 elevation: 0,
//               ),
//               onPressed: () async {
//                 String enteredPrice = priceController.text.trim();
//
//                 if (enteredPrice.isEmpty) {
//                   Fluttertoast.showToast(msg: "Please enter a price");
//                   return;
//                 }
//
//                 SharedPreferences sh = await SharedPreferences.getInstance();
//                 String? url = sh.getString('url');
//                 String lid = sh.getString('lid').toString();
//
//                 if (url == null) {
//                   Fluttertoast.showToast(msg: "Server URL not found.");
//                   return;
//                 }
//
//                 final uri = Uri.parse('$url/add_fav/');
//                 var request = http.MultipartRequest('POST', uri);
//                 request.fields['name'] = filteredNames[index];
//                 request.fields['lid'] = lid;
//                 request.fields['price'] = enteredPrice;
//
//                 try {
//                   var response = await request.send();
//                   var respStr = await response.stream.bytesToString();
//                   var data = jsonDecode(respStr);
//
//                   if (response.statusCode == 200 && data['status'] == 'ok') {
//                     Fluttertoast.showToast(msg: "Added to favorites");
//                     setState(() {
//                       likedStatus[index] = true;
//                     });
//                     Navigator.pop(context);
//                   } else {
//                     Fluttertoast.showToast(msg: "Failed to add favorite");
//                   }
//                 } catch (e) {
//                   Fluttertoast.showToast(msg: "Error: $e");
//                 }
//               },
//               child: const Text(
//                 "Add to Favorites",
//                 style: TextStyle(color: Colors.white, fontSize: 15),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   List<String> name_ = <String>[];
//   List<String> a_ = <String>[];
//   List<String> price_ = <String>[];
//   List<String> filteredNames = <String>[];
//   List<String> filteredA = <String>[];
//   List<bool> likedStatus = [];
//   bool isLoading = true;
//   String searchQuery = '';
//
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   final TextEditingController _searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: Duration(milliseconds: 600),
//       vsync: this,
//     );
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
//     );
//     _animationController.forward();
//     _fetchStocks();
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _fetchStocks() async {
//     setState(() {
//       isLoading = true;
//     });
//
//     List<String> name = <String>[];
//     List<String> a = <String>[];
//     List<String> price = <String>[];
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       String url = '$urls/getallstock/';
//
//       var data = await http.post(Uri.parse(url), body: {'lid': lid});
//       var jsondata = json.decode(data.body);
//       if (jsondata['status'] == 'ok') {
//         var arr = jsondata["data"];
//         for (int i = 0; i < arr.length; i++) {
//           name.add(arr[i]['name'].toString());
//           a.add(arr[i]['a'].toString());
//           price.add(arr[i]['price'].toString());
//         }
//       }
//       setState(() {
//         name_ = name;
//         a_ = a;
//         filteredNames = name;
//         price_ = price;
//         filteredA = a;
//         likedStatus = List<bool>.filled(name.length, false);
//         isLoading = false;
//       });
//     } catch (e) {
//       print("Error ------------------- " + e.toString());
//       setState(() {
//         isLoading = false;
//       });
//       Fluttertoast.showToast(msg: "Error fetching stocks: $e");
//     }
//   }
//
//   void _filterStocks(String query) {
//     setState(() {
//       searchQuery = query;
//       if (query.isEmpty) {
//         filteredNames = name_;
//         filteredA = a_;
//       } else {
//         List<String> tempNames = [];
//         List<String> tempA = [];
//         for (int i = 0; i < name_.length; i++) {
//           if (name_[i].toLowerCase().contains(query.toLowerCase())) {
//             tempNames.add(name_[i]);
//             tempA.add(a_[i]);
//           }
//         }
//         filteredNames = tempNames;
//         filteredA = tempA;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => BankingDashboard()),
//         );
//         return false;
//       },
//       child: Scaffold(
//         body: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Color(0xFF000000),
//                 Color(0xFF0A1628),
//                 Color(0xFF001233),
//                 Color(0xFF000000),
//               ],
//               stops: [0.0, 0.3, 0.7, 1.0],
//             ),
//           ),
//           child: SafeArea(
//             child: Column(
//               children: [
//                 // Modern Header
//                 FadeTransition(
//                   opacity: _fadeAnimation,
//                   child: Container(
//                     margin: EdgeInsets.all(16),
//                     padding: EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Color(0xFF0D1117).withOpacity(0.6),
//                       borderRadius: BorderRadius.circular(24),
//                       border: Border.all(
//                         color: Color(0xFF1E88E5).withOpacity(0.3),
//                         width: 1.5,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Color(0xFF1E88E5).withOpacity(0.1),
//                           blurRadius: 20,
//                           spreadRadius: 5,
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => BankingDashboard(),
//                                   ),
//                                 );
//                               },
//                               child: Container(
//                                 padding: EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       Color(0xFF1E88E5).withOpacity(0.3),
//                                       Color(0xFF1565C0).withOpacity(0.3),
//                                     ],
//                                   ),
//                                   borderRadius: BorderRadius.circular(14),
//                                   border: Border.all(
//                                     color: Color(0xFF64B5F6).withOpacity(0.5),
//                                     width: 1,
//                                   ),
//                                 ),
//                                 child: Icon(
//                                   Icons.arrow_back_ios_new,
//                                   color: Color(0xFF64B5F6),
//                                   size: 18,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 16),
//                             Container(
//                               padding: EdgeInsets.all(14),
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 gradient: LinearGradient(
//                                   colors: [
//                                     Color(0xFF5C6BC0),
//                                     Color(0xFF3949AB),
//                                   ],
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Color(0xFF5C6BC0).withOpacity(0.5),
//                                     blurRadius: 20,
//                                     spreadRadius: 3,
//                                   ),
//                                 ],
//                               ),
//                               child: Icon(
//                                 Icons.show_chart_rounded,
//                                 size: 26,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             SizedBox(width: 16),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     'Stock Market',
//                                     style: TextStyle(
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.w900,
//                                       color: Colors.white,
//                                       letterSpacing: 0.5,
//                                     ),
//                                   ),
//                                   SizedBox(height: 4),
//                                   Row(
//                                     children: [
//                                       Container(
//                                         padding: EdgeInsets.symmetric(
//                                           horizontal: 8,
//                                           vertical: 4,
//                                         ),
//                                         decoration: BoxDecoration(
//                                           color: Color(0xFF1E88E5).withOpacity(0.2),
//                                           borderRadius: BorderRadius.circular(8),
//                                         ),
//                                         child: Text(
//                                           '${filteredNames.length} stocks',
//                                           style: TextStyle(
//                                             fontSize: 12,
//                                             color: Color(0xFF64B5F6),
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () => _fetchStocks(),
//                               child: Container(
//                                 padding: EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       Color(0xFF1E88E5).withOpacity(0.3),
//                                       Color(0xFF1565C0).withOpacity(0.3),
//                                     ],
//                                   ),
//                                   borderRadius: BorderRadius.circular(14),
//                                   border: Border.all(
//                                     color: Color(0xFF64B5F6).withOpacity(0.5),
//                                     width: 1,
//                                   ),
//                                 ),
//                                 child: Icon(
//                                   Icons.refresh_rounded,
//                                   color: Color(0xFF64B5F6),
//                                   size: 22,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 20),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Color(0xFF0D1117),
//                             borderRadius: BorderRadius.circular(18),
//                             border: Border.all(
//                               color: Color(0xFF1E88E5).withOpacity(0.4),
//                               width: 1.5,
//                             ),
//                           ),
//                           child: TextField(
//                             controller: _searchController,
//                             onChanged: _filterStocks,
//                             style: TextStyle(color: Colors.white, fontSize: 15),
//                             decoration: InputDecoration(
//                               hintText: 'Search stocks by name...',
//                               hintStyle: TextStyle(
//                                 color: Color(0xFF8B9DC3),
//                                 fontSize: 14,
//                               ),
//                               prefixIcon: Container(
//                                 margin: EdgeInsets.all(8),
//                                 padding: EdgeInsets.all(8),
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       Color(0xFF1E88E5).withOpacity(0.3),
//                                       Color(0xFF1565C0).withOpacity(0.3),
//                                     ],
//                                   ),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Icon(
//                                   Icons.search_rounded,
//                                   color: Color(0xFF64B5F6),
//                                   size: 20,
//                                 ),
//                               ),
//                               suffixIcon: searchQuery.isNotEmpty
//                                   ? IconButton(
//                                 icon: Icon(
//                                   Icons.close_rounded,
//                                   color: Color(0xFF64B5F6),
//                                   size: 20,
//                                 ),
//                                 onPressed: () {
//                                   _searchController.clear();
//                                   _filterStocks('');
//                                 },
//                               )
//                                   : null,
//                               border: InputBorder.none,
//                               contentPadding: EdgeInsets.symmetric(
//                                 horizontal: 16,
//                                 vertical: 16,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 // Content
//                 Expanded(
//                   child: isLoading
//                       ? Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(20),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             gradient: LinearGradient(
//                               colors: [
//                                 Color(0xFF1E88E5).withOpacity(0.2),
//                                 Color(0xFF1565C0).withOpacity(0.2),
//                               ],
//                             ),
//                           ),
//                           child: CircularProgressIndicator(
//                             valueColor: AlwaysStoppedAnimation<Color>(
//                               Color(0xFF1E88E5),
//                             ),
//                             strokeWidth: 3,
//                           ),
//                         ),
//                         SizedBox(height: 24),
//                         Text(
//                           'Loading stocks...',
//                           style: TextStyle(
//                             color: Color(0xFF64B5F6),
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                       : filteredNames.isEmpty
//                       ? Center(
//                     child: FadeTransition(
//                       opacity: _fadeAnimation,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             width: 140,
//                             height: 140,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               gradient: LinearGradient(
//                                 colors: [
//                                   Color(0xFF1E88E5).withOpacity(0.1),
//                                   Color(0xFF1565C0).withOpacity(0.1),
//                                 ],
//                               ),
//                               border: Border.all(
//                                 color: Color(0xFF1E88E5).withOpacity(0.3),
//                                 width: 2,
//                               ),
//                             ),
//                             child: Icon(
//                               searchQuery.isEmpty
//                                   ? Icons.inventory_2_outlined
//                                   : Icons.search_off_rounded,
//                               size: 60,
//                               color: Color(0xFF64B5F6),
//                             ),
//                           ),
//                           SizedBox(height: 32),
//                           Text(
//                             searchQuery.isEmpty
//                                 ? 'No Stocks Available'
//                                 : 'No Results Found',
//                             style: TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                           SizedBox(height: 12),
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 40),
//                             child: Text(
//                               searchQuery.isEmpty
//                                   ? 'There are no stocks to display at the moment'
//                                   : 'Try searching with a different keyword',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Color(0xFF8B9DC3),
//                                 height: 1.5,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                       : RefreshIndicator(
//                     onRefresh: _fetchStocks,
//                     color: Color(0xFF1E88E5),
//                     backgroundColor: Color(0xFF0D1117),
//                     child: ListView.builder(
//                       padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
//                       physics: AlwaysScrollableScrollPhysics(),
//                       itemCount: filteredNames.length,
//                       itemBuilder: (context, index) {
//                         return FadeTransition(
//                           opacity: _fadeAnimation,
//                           child: _buildStockCard(context, index),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStockCard(BuildContext context, int index) {
//     return GestureDetector(
//       onTap: () async {
//         SharedPreferences sh = await SharedPreferences.getInstance();
//         sh.setString("name", filteredNames[index]);
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ViewStockDetails(title: 'Stock Details'),
//           ),
//         );
//       },
//       child: Container(
//         margin: EdgeInsets.only(bottom: 12),
//         decoration: BoxDecoration(
//           color: Color(0xFF0D1117).withOpacity(0.6),
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(
//             color: Color(0xFF1E88E5).withOpacity(0.3),
//             width: 1.5,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Color(0xFF1E88E5).withOpacity(0.08),
//               blurRadius: 15,
//               spreadRadius: 2,
//               offset: Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(16),
//           child: Row(
//             children: [
//               Container(
//                 width: 56,
//                 height: 56,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   gradient: LinearGradient(
//                     colors: [
//                       Color(0xFF1E88E5),
//                       Color(0xFF1565C0),
//                     ],
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color(0xFF1E88E5).withOpacity(0.4),
//                       blurRadius: 15,
//                       spreadRadius: 2,
//                     ),
//                   ],
//                 ),
//                 child: Icon(
//                   Icons.trending_up_rounded,
//                   size: 28,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       filteredNames[index],
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         letterSpacing: 0.3,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.currency_rupee,
//                           color: Color(0xFF26A69A),
//                           size: 22,
//                         ),
//                         Text(
//                          price_[index],
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             letterSpacing: 0.3,
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 6),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF1E88E5),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       onPressed: () {
//                         _showBuyDialog(context, filteredNames[index]);
//                       },
//                       child: const Text(
//                         'Buy',
//                         style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                       ),
//                     ),
//
//                     // ElevatedButton(onPressed: (){}, child: Text('buy')),
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Color(0xFF26A69A).withOpacity(0.2),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         'Tap to view details',
//                         style: TextStyle(
//                           fontSize: 11,
//                           color: Color(0xFF26A69A),
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(width: 12),
//               GestureDetector(
//                 onTap: () async{
//                   SharedPreferences sh = await SharedPreferences.getInstance();
//                   sh.setString("name", filteredNames[index]);
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) => view_price_detailes(title: '',)),
//                   );
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Color(0xFF26A69A).withOpacity(0.2),
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: Color(0xFF26A69A).withOpacity(0.4),
//                       width: 1.5,
//                     ),
//                   ),
//                   child: Icon(
//                     Icons.currency_rupee,
//                     color: Color(0xFF26A69A),
//                     size: 22,
//                   ),
//                 ),
//               ),
//               SizedBox(width: 8),
//               GestureDetector(
//                 onTap: () async {
//                   if (likedStatus[index]) {
//                     SharedPreferences sh = await SharedPreferences.getInstance();
//                     String? url = sh.getString('url');
//                     String lid = sh.getString('lid').toString();
//
//                     if (url == null) {
//                       Fluttertoast.showToast(msg: "Server URL not found.");
//                       return;
//                     }
//
//                     final uri = Uri.parse('$url/add_fav/');
//                     var request = http.MultipartRequest('POST', uri);
//                     request.fields['name'] = filteredNames[index];
//                     request.fields['lid'] = lid;
//
//                     try {
//                       var response = await request.send();
//                       var respStr = await response.stream.bytesToString();
//                       var data = jsonDecode(respStr);
//
//                       if (response.statusCode == 200 && data['status'] == 'ok') {
//                         Fluttertoast.showToast(msg: "Removed from favorites");
//                         setState(() {
//                           likedStatus[index] = false;
//                         });
//                       } else {
//                         Fluttertoast.showToast(msg: "Failed to remove favorite");
//                       }
//                     } catch (e) {
//                       Fluttertoast.showToast(msg: "Error: $e");
//                     }
//                   } else {
//                     _showAddFavoriteDialog(context, index);
//                   }
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: likedStatus[index]
//                         ? Colors.red.withOpacity(0.2)
//                         : Color(0xFF1E88E5).withOpacity(0.2),
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: likedStatus[index]
//                           ? Colors.red.withOpacity(0.4)
//                           : Color(0xFF1E88E5).withOpacity(0.4),
//                       width: 1.5,
//                     ),
//                   ),
//                   child: Icon(
//                     likedStatus[index] ? Icons.favorite : Icons.favorite_border,
//                     color: likedStatus[index] ? Colors.red : Color(0xFF64B5F6),
//                     size: 22,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//}
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradebee1/stock_details.dart';
import 'package:tradebee1/view%20price.dart';
import 'Userhome.dart';

void main() {
  runApp(const Viewhigh());
}

class Viewhigh extends StatelessWidget {
  const Viewhigh({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Stock Details',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(207, 97, 161, 156),
        ),
        useMaterial3: true,
      ),
      home: const StockListPage(title: 'Stocks'),
    );
  }
}

class StockListPage extends StatefulWidget {
  const StockListPage({super.key, required this.title});
  final String title;

  @override
  State<StockListPage> createState() => _StockListPageState();
}

class _StockListPageState extends State<StockListPage>
    with SingleTickerProviderStateMixin {

  // ─── YOUR ORIGINAL FUNCTION — UNCHANGED ──────────────────────────────────
  Future<void> _showBuyDialog(BuildContext context, String stockName,String pri) async {
    TextEditingController quantityController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController privateKeyController = TextEditingController();
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF0D1117),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: const Color(0xFF1E88E5).withOpacity(0.3),
              width: 1.5,
            ),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E88E5), Color(0xFF1565C0)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.shopping_cart, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                "Buy Stock",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E88E5).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF1E88E5).withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.trending_up, color: Color(0xFF64B5F6), size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          stockName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Enter Quantity",
                  style: TextStyle(
                    color: Color(0xFF64B5F6),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  onChanged: (value) async {



                     double b= double.parse(value.toString())* double.parse(pri) / 218000;
                     SharedPreferences sh= await SharedPreferences.getInstance();

                     sh.setString("b", b.toString());


                  },
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: "e.g. 10",
                    hintStyle: const TextStyle(color: Color(0xFF8B9DC3)),
                    prefixIcon: const Icon(Icons.confirmation_num, color: Color(0xFF64B5F6)),
                    filled: true,
                    fillColor: const Color(0xFF0D1117),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: const Color(0xFF1E88E5).withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF64B5F6), width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Blockchain Address",
                  style: TextStyle(
                    color: Color(0xFF64B5F6),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: addressController,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: "Enter blockchain wallet address",
                    hintStyle: const TextStyle(color: Color(0xFF8B9DC3)),
                    prefixIcon: const Icon(Icons.account_balance_wallet, color: Color(0xFF64B5F6)),
                    filled: true,
                    fillColor: const Color(0xFF0D1117),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: const Color(0xFF1E88E5).withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF64B5F6), width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Private Key",
                  style: TextStyle(
                    color: Color(0xFF64B5F6),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: privateKeyController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: "Enter private key",
                    hintStyle: const TextStyle(color: Color(0xFF8B9DC3)),
                    prefixIcon: const Icon(Icons.vpn_key, color: Color(0xFF64B5F6)),
                    filled: true,
                    fillColor: const Color(0xFF0D1117),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: const Color(0xFF1E88E5).withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF64B5F6), width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E88E5),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                String qty = quantityController.text.trim();
                String address = addressController.text.trim();
                String privateKey = privateKeyController.text.trim();

                if (qty.isEmpty || address.isEmpty || privateKey.isEmpty) {
                  Fluttertoast.showToast(msg: "All fields are required");
                  return;
                }

                Navigator.pop(context);
                Fluttertoast.showToast(msg: "Buying $qty shares of $stockName...");

                SharedPreferences sh = await SharedPreferences.getInstance();
                String? url = sh.getString('url');
                String lid = sh.getString('lid').toString();

                final uri = Uri.parse('$url/buy/');
                var request = http.MultipartRequest('POST', uri);
                request.fields['lid'] = lid;
                request.fields['stock'] = stockName;
                request.fields['quantity'] = qty;
                request.fields['actual'] = pri;
                request.fields['amount'] = sh.getString("b").toString();
                request.fields['address'] = address;
                request.fields['private_key'] = privateKey;

                var response = await request.send();
                var respStr = await response.stream.bytesToString();
                var data = jsonDecode(respStr);

                if (data['status'] == 'ok') {
                  Fluttertoast.showToast(msg: "Purchase successful!");
                } else {
                  Fluttertoast.showToast(msg: "Purchase failed!");
                }
              },
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ],
        );
      },
    );
  }

  // ─── YOUR ORIGINAL FUNCTION — UNCHANGED ──────────────────────────────────
  Future<void> _showAddFavoriteDialog(BuildContext context, int index) async {
    TextEditingController priceController = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF0D1117),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: const Color(0xFF1E88E5).withOpacity(0.3), width: 1.5),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E88E5), Color(0xFF1565C0)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.star, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                "Add to Favorites",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E88E5).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF1E88E5).withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.trending_up, color: Color(0xFF64B5F6), size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        filteredNames[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Set Target Price",
                style: TextStyle(
                  color: Color(0xFF64B5F6),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: priceController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration(
                  hintText: "Enter price",
                  hintStyle: const TextStyle(color: Color(0xFF8B9DC3)),
                  prefixIcon: const Icon(Icons.currency_rupee, color: Color(0xFF64B5F6), size: 20),
                  filled: true,
                  fillColor: const Color(0xFF0D1117),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: const Color(0xFF1E88E5).withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF64B5F6), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E88E5),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              onPressed: () async {
                String enteredPrice = priceController.text.trim();

                if (enteredPrice.isEmpty) {
                  Fluttertoast.showToast(msg: "Please enter a price");
                  return;
                }

                SharedPreferences sh = await SharedPreferences.getInstance();
                String? url = sh.getString('url');
                String lid = sh.getString('lid').toString();

                if (url == null) {
                  Fluttertoast.showToast(msg: "Server URL not found.");
                  return;
                }

                final uri = Uri.parse('$url/add_fav/');
                var request = http.MultipartRequest('POST', uri);
                request.fields['name'] = filteredNames[index];
                request.fields['lid'] = lid;
                request.fields['price'] = enteredPrice;

                try {
                  var response = await request.send();
                  var respStr = await response.stream.bytesToString();
                  var data = jsonDecode(respStr);

                  if (response.statusCode == 200 && data['status'] == 'ok') {
                    Fluttertoast.showToast(msg: "Added to favorites");
                    setState(() {
                      likedStatus[index] = true;
                    });
                    Navigator.pop(context);
                  } else {
                    Fluttertoast.showToast(msg: "Failed to add favorite");
                  }
                } catch (e) {
                  Fluttertoast.showToast(msg: "Error: $e");
                }
              },
              child: const Text(
                "Add to Favorites",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ],
        );
      },
    );
  }

  // ─── STATE VARIABLES — UNCHANGED ─────────────────────────────────────────
  List<String> name_ = <String>[];
  List<String> a_ = <String>[];
  List<String> price_ = <String>[];
  List<String> filteredNames = <String>[];
  List<String> filteredA = <String>[];
  List<String> filteredPrices = <String>[];
  List<bool> likedStatus = [];
  bool isLoading = true;
  String searchQuery = '';

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
    _fetchStocks();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // ─── YOUR ORIGINAL FUNCTION — UNCHANGED ──────────────────────────────────
  Future<void> _fetchStocks() async {
    setState(() {
      isLoading = true;
    });

    List<String> name = <String>[];
    List<String> a = <String>[];
    List<String> price = <String>[];
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/getallstock/';

      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      if (jsondata['status'] == 'ok') {
        var arr = jsondata["data"];
        for (int i = 0; i < arr.length; i++) {
          name.add(arr[i]['name'].toString());
          a.add(arr[i]['a'].toString());
          price.add(arr[i]['price'].toString());
        }
      }
      setState(() {
        name_ = name;
        a_ = a;
        filteredNames = name;
        price_ = price;
        filteredPrices = price;
        filteredA = a;
        likedStatus = List<bool>.filled(name.length, false);
        isLoading = false;
      });
    } catch (e) {
      print("Error ------------------- " + e.toString());
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: "Error fetching stocks: $e");
    }
  }

  // ─── YOUR ORIGINAL FUNCTION — UNCHANGED ──────────────────────────────────
  void _filterStocks(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredNames = name_;
        filteredA = a_;
        filteredPrices = price_;
      } else {
        List<String> tempNames = [];
        List<String> tempA = [];
        List<String> tempPrices = [];
        for (int i = 0; i < name_.length; i++) {
          if (name_[i].toLowerCase().contains(query.toLowerCase())) {
            tempNames.add(name_[i]);
            tempA.add(a_[i]);
            tempPrices.add(price_[i]);
          }
        }
        filteredNames = tempNames;
        filteredA = tempA;
        filteredPrices = tempPrices;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BankingDashboard()),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF000000),
                Color(0xFF0A1628),
                Color(0xFF001233),
                Color(0xFF000000),
              ],
              stops: [0.0, 0.3, 0.7, 1.0],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // ── HEADER ────────────────────────────────────────────────
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D1117).withOpacity(0.7),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xFF1E88E5).withOpacity(0.3),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1E88E5).withOpacity(0.08),
                          blurRadius: 24,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // Back button
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BankingDashboard(),
                                  ),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E88E5).withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: const Color(0xFF64B5F6).withOpacity(0.4),
                                    width: 1,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Color(0xFF64B5F6),
                                  size: 16,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),

                            // Logo circle
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF5C6BC0), Color(0xFF3949AB)],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF5C6BC0).withOpacity(0.45),
                                    blurRadius: 18,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.show_chart_rounded,
                                size: 22,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 14),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Stock Market',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1E88E5).withOpacity(0.18),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      '${filteredNames.length} stocks available',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFF64B5F6),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Refresh button
                            GestureDetector(
                              onTap: () => _fetchStocks(),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E88E5).withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: const Color(0xFF64B5F6).withOpacity(0.4),
                                    width: 1,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.refresh_rounded,
                                  color: Color(0xFF64B5F6),
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Search bar
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF0D1117),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF1E88E5).withOpacity(0.35),
                              width: 1.5,
                            ),
                          ),
                          child: TextField(
                            controller: _searchController,
                            onChanged: _filterStocks,
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'Search stocks by name...',
                              hintStyle: const TextStyle(
                                color: Color(0xFF8B9DC3),
                                fontSize: 13,
                              ),
                              prefixIcon: Container(
                                margin: const EdgeInsets.all(8),
                                padding: const EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E88E5).withOpacity(0.18),
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: const Icon(
                                  Icons.search_rounded,
                                  color: Color(0xFF64B5F6),
                                  size: 18,
                                ),
                              ),
                              suffixIcon: searchQuery.isNotEmpty
                                  ? IconButton(
                                icon: const Icon(
                                  Icons.close_rounded,
                                  color: Color(0xFF64B5F6),
                                  size: 18,
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                  _filterStocks('');
                                },
                              )
                                  : null,
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ── CONTENT ───────────────────────────────────────────────
                Expanded(
                  child: isLoading
                      ? _buildLoadingState()
                      : filteredNames.isEmpty
                      ? _buildEmptyState()
                      : RefreshIndicator(
                    onRefresh: _fetchStocks,
                    color: const Color(0xFF1E88E5),
                    backgroundColor: const Color(0xFF0D1117),
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: filteredNames.length,
                      itemBuilder: (context, index) {
                        return FadeTransition(
                          opacity: _fadeAnimation,
                          child: _buildStockCard(context, index),
                        );
                      },
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

  // ── LOADING STATE ──────────────────────────────────────────────────────────
  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF1E88E5).withOpacity(0.1),
              border: Border.all(
                color: const Color(0xFF1E88E5).withOpacity(0.3),
                width: 2,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1E88E5)),
                strokeWidth: 3,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Loading stocks...',
            style: TextStyle(
              color: Color(0xFF64B5F6),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Fetching live market data',
            style: TextStyle(color: Color(0xFF8B9DC3), fontSize: 12),
          ),
        ],
      ),
    );
  }

  // ── EMPTY STATE ────────────────────────────────────────────────────────────
  Widget _buildEmptyState() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF1E88E5).withOpacity(0.07),
                border: Border.all(
                  color: const Color(0xFF1E88E5).withOpacity(0.25),
                  width: 2,
                ),
              ),
              child: Icon(
                searchQuery.isEmpty
                    ? Icons.inventory_2_outlined
                    : Icons.search_off_rounded,
                size: 55,
                color: const Color(0xFF64B5F6),
              ),
            ),
            const SizedBox(height: 28),
            Text(
              searchQuery.isEmpty ? 'No Stocks Available' : 'No Results Found',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                searchQuery.isEmpty
                    ? 'There are no stocks to display at the moment'
                    : 'Try searching with a different keyword',
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF8B9DC3),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── STOCK CARD (REDESIGNED WITH PRICE) ────────────────────────────────────
  Widget _buildStockCard(BuildContext context, int index) {
    final String currentPrice = filteredPrices.length > index
        ? filteredPrices[index]
        : price_.length > index
        ? price_[index]
        : '0';

    // Detect if price is positive/negative change hint from 'a_' field
    final bool isTrendUp = filteredA.length > index
        ? (double.tryParse(filteredA[index]) ?? 0) >= 0
        : true;

    return GestureDetector(
      onTap: () async {
        SharedPreferences sh = await SharedPreferences.getInstance();
        sh.setString("name", filteredNames[index]);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewStockDetails(title: 'Stock Details'),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF0D1117).withOpacity(0.75),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: const Color(0xFF1E88E5).withOpacity(0.25),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1E88E5).withOpacity(0.06),
              blurRadius: 18,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // ── TOP SECTION ───────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stock icon
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF1E88E5), Color(0xFF1565C0)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1E88E5).withOpacity(0.35),
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.trending_up_rounded,
                      size: 26,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Name + price block
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Stock name
                        Text(
                          filteredNames[index],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 0.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        // const SizedBox(height: 2),
                        // const Text(
                        //   'NSE · Equity',
                        //   style: TextStyle(
                        //     fontSize: 10,
                        //     color: Color(0xFF8B9DC3),
                        //     fontWeight: FontWeight.w400,
                        //   ),
                        // ),
                        const SizedBox(height: 8),

                        // ── PRICE DISPLAY ─────────────────────────────────
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF26A69A).withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFF26A69A).withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.currency_rupee_rounded,
                                color: Color(0xFF26A69A),
                                size: 18,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                currentPrice,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF26A69A),
                                  letterSpacing: 0.3,
                                ),
                              ),
                              // const SizedBox(width: 8),
                              // Container(
                              //   padding: const EdgeInsets.symmetric(
                              //       horizontal: 6, vertical: 2),
                              //   decoration: BoxDecoration(
                              //     color: isTrendUp
                              //         ? const Color(0xFF26A69A).withOpacity(0.15)
                              //         : const Color(0xFFEF5350).withOpacity(0.15),
                              //     borderRadius: BorderRadius.circular(6),
                              //   ),
                              //   child: Row(
                              //     children: [
                              //       Icon(
                              //         isTrendUp
                              //             ? Icons.arrow_upward_rounded
                              //             : Icons.arrow_downward_rounded,
                              //         color: isTrendUp
                              //             ? const Color(0xFF26A69A)
                              //             : const Color(0xFFEF5350),
                              //         size: 10,
                              //       ),
                              //       const SizedBox(width: 2),
                              //       Text(
                              //         isTrendUp ? 'UP' : 'DN',
                              //         style: TextStyle(
                              //           fontSize: 9,
                              //           fontWeight: FontWeight.w700,
                              //           color: isTrendUp
                              //               ? const Color(0xFF26A69A)
                              //               : const Color(0xFFEF5350),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── RIGHT BUTTONS: price-detail + favorite ─────────────
                  Column(
                    children: [
                      // View price button
                      GestureDetector(
                        onTap: () async {
                          SharedPreferences sh =
                          await SharedPreferences.getInstance();
                          sh.setString("name", filteredNames[index]);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  view_price_detailes(title: ''),
                            ),
                          );
                        },
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFF26A69A).withOpacity(0.12),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF26A69A).withOpacity(0.35),
                              width: 1.5,
                            ),
                          ),
                          child: const Icon(
                            Icons.candlestick_chart_rounded,
                            color: Color(0xFF26A69A),
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Favorite button
                      GestureDetector(
                        onTap: () async {
                          if (likedStatus[index]) {
                            SharedPreferences sh =
                            await SharedPreferences.getInstance();
                            String? url = sh.getString('url');
                            String lid = sh.getString('lid').toString();

                            if (url == null) {
                              Fluttertoast.showToast(
                                  msg: "Server URL not found.");
                              return;
                            }

                            final uri = Uri.parse('$url/add_fav/');
                            var request =
                            http.MultipartRequest('POST', uri);
                            request.fields['name'] = filteredNames[index];
                            request.fields['lid'] = lid;

                            try {
                              var response = await request.send();
                              var respStr =
                              await response.stream.bytesToString();
                              var data = jsonDecode(respStr);

                              if (response.statusCode == 200 &&
                                  data['status'] == 'ok') {
                                Fluttertoast.showToast(
                                    msg: "Removed from favorites");
                                setState(() {
                                  likedStatus[index] = false;
                                });
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Failed to remove favorite");
                              }
                            } catch (e) {
                              Fluttertoast.showToast(msg: "Error: $e");
                            }
                          } else {
                            _showAddFavoriteDialog(context, index);
                          }
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: likedStatus[index]
                                ? Colors.red.withOpacity(0.15)
                                : const Color(0xFF1E88E5).withOpacity(0.12),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: likedStatus[index]
                                  ? Colors.red.withOpacity(0.4)
                                  : const Color(0xFF1E88E5).withOpacity(0.35),
                              width: 1.5,
                            ),
                          ),
                          child: Icon(
                            likedStatus[index]
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: likedStatus[index]
                                ? Colors.red
                                : const Color(0xFF64B5F6),
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── BOTTOM ACTION STRIP ───────────────────────────────────────
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF0A0F1A).withOpacity(0.6),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(22),
                ),
                border: Border(
                  top: BorderSide(
                    color: const Color(0xFF1E88E5).withOpacity(0.15),
                    width: 1,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                children: [
                  // View details hint
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF26A69A),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'Tap card to view charts',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF8B9DC3),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Buy button
                  GestureDetector(
                    onTap: () => _showBuyDialog(context, filteredNames[index],filteredPrices[index]),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF1E88E5), Color(0xFF1565C0)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1E88E5).withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 1,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.shopping_cart_rounded,
                              color: Colors.white, size: 14),
                          SizedBox(width: 6),
                          Text(
                            'Buy Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
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
      ),
    );
  }
}