
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
//       home: const view_fav_stock(title: 'Stocks'),
//     );
//   }
// }
//
// class view_fav_stock extends StatefulWidget {
//   const view_fav_stock({super.key, required this.title});
//   final String title;
//
//   @override
//   State<view_fav_stock> createState() => _view_fav_stockState();
// }
//
// class _view_fav_stockState extends State<view_fav_stock>
//     with SingleTickerProviderStateMixin {
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
//       String url = '$urls/view_favstock/';
//
//       var data = await http.post(Uri.parse(url), body: {'lid': lid});
//       var jsondata = json.decode(data.body);
//       if (jsondata['status'] == 'ok') {
//         var arr = jsondata["data"];
//         for (int i = 0; i < arr.length; i++) {
//           name.add(arr[i]['name'].toString());
//           // a.add(arr[i]['a'].toString());
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
//                     SharedPreferences sh =
//                     await SharedPreferences.getInstance();
//                     String? url = sh.getString('url');
//                     String lid = sh.getString('lid').toString();
//
//                     if (url == null) {
//                       Fluttertoast.showToast(
//                           msg: "Server URL not found.");
//                       return;
//                     }
//
//                     final uri = Uri.parse('$url/add_fav/');
//                     var request =
//                     http.MultipartRequest('POST', uri);
//                     request.fields['name'] = filteredNames[index];
//                     request.fields['lid'] = lid;
//
//                     try {
//                       var response = await request.send();
//                       var respStr =
//                       await response.stream.bytesToString();
//                       var data = jsonDecode(respStr);
//
//                       if (response.statusCode == 200 &&
//                           data['status'] == 'ok') {
//                         Fluttertoast.showToast(
//                             msg: likedStatus[index]
//                                 ? "Removed from favorites"
//                                 : "Added to favorites");
//                         setState(() {
//                           likedStatus[index] =
//                           !likedStatus[index]; // ✅ toggle only this one
//                         });
//                       } else {
//                         Fluttertoast.showToast(
//                             msg: "Submission failed.");
//                       }
//                     } catch (e) {
//                       Fluttertoast.showToast(msg: "Error: $e");
//                     }
//                   },
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
//             // SizedBox(height: 4),
//             // Container(
//             //   padding:
//             //   EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//             //   decoration: BoxDecoration(
//             //     color: Color(0xFF26A69A).withOpacity(0.2),
//             //     borderRadius: BorderRadius.circular(8),
//             //   ),
//             //   child: Text(
//             //     'View',
//             //     style: TextStyle(
//             //       fontSize: 10,
//             //       color: Color(0xFF26A69A),
//             //       fontWeight: FontWeight.w600,
//             //     ),
//             //   ),
//             // ),
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
//       home: const view_fav_stock(title: 'Stocks'),
//     );
//   }
// }
//
// class view_fav_stock extends StatefulWidget {
//   const view_fav_stock({super.key, required this.title});
//   final String title;
//
//   @override
//   State<view_fav_stock> createState() => _view_fav_stockState();
// }
//
// class _view_fav_stockState extends State<view_fav_stock>
//     with SingleTickerProviderStateMixin {
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
//       duration: const Duration(milliseconds: 800),
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
//       String url = '$urls/view_favstock/';
//
//       var data = await http.post(Uri.parse(url), body: {'lid': lid});
//       var jsondata = json.decode(data.body);
//       if (jsondata['status'] == 'ok') {
//         var arr = jsondata["data"];
//         for (int i = 0; i < arr.length; i++) {
//           name.add(arr[i]['name'].toString());
//         }
//       }
//       setState(() {
//         name_ = name;
//         a_ = a;
//         filteredNames = name;
//         filteredA = a;
//         likedStatus = List<bool>.filled(name.length, true); // ❤️ all favorites
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
//           decoration: const BoxDecoration(
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
//                 // Header Section
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
//                                 padding: const EdgeInsets.all(8),
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xFF0D1117),
//                                   borderRadius: BorderRadius.circular(12),
//                                   border: Border.all(
//                                     color: const Color(0xFF1E88E5)
//                                         .withOpacity(0.3),
//                                     width: 1,
//                                   ),
//                                 ),
//                                 child: const Icon(
//                                   Icons.arrow_back,
//                                   color: Color(0xFF64B5F6),
//                                   size: 20,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 12),
//                             Container(
//                               width: 45,
//                               height: 45,
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 gradient: const LinearGradient(
//                                   colors: [
//                                     Color(0xFF5C6BC0),
//                                     Color(0xFF3949AB),
//                                   ],
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: const Color(0xFF5C6BC0)
//                                         .withOpacity(0.4),
//                                     blurRadius: 15,
//                                     spreadRadius: 3,
//                                   ),
//                                 ],
//                               ),
//                               child: const Icon(
//                                 Icons.show_chart,
//                                 size: 24,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             const SizedBox(width: 12),
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Text(
//                                     'Favorite Stocks',
//                                     style: TextStyle(
//                                       fontSize: 22,
//                                       fontWeight: FontWeight.w900,
//                                       color: Colors.white,
//                                       letterSpacing: 1,
//                                     ),
//                                   ),
//                                   Text(
//                                     '${filteredNames.length} stocks saved',
//                                     style: const TextStyle(
//                                       fontSize: 12,
//                                       color: Color(0xFF64B5F6),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             IconButton(
//                               onPressed: _fetchStocks,
//                               icon: Container(
//                                 padding: const EdgeInsets.all(8),
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xFF0D1117),
//                                   borderRadius: BorderRadius.circular(12),
//                                   border: Border.all(
//                                     color: const Color(0xFF1E88E5)
//                                         .withOpacity(0.3),
//                                     width: 1,
//                                   ),
//                                 ),
//                                 child: const Icon(
//                                   Icons.refresh,
//                                   color: Color(0xFF64B5F6),
//                                   size: 20,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 16),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: const Color(0xFF0D1117),
//                             borderRadius: BorderRadius.circular(16),
//                             border: Border.all(
//                               color:
//                               const Color(0xFF1E88E5).withOpacity(0.3),
//                               width: 1.5,
//                             ),
//                           ),
//                           child: TextField(
//                             controller: _searchController,
//                             onChanged: _filterStocks,
//                             style: const TextStyle(color: Colors.white),
//                             decoration: InputDecoration(
//                               hintText: 'Search favorite stocks...',
//                               hintStyle: const TextStyle(
//                                 color: Color(0xFF8B9DC3),
//                                 fontSize: 14,
//                               ),
//                               prefixIcon: const Icon(
//                                 Icons.search,
//                                 color: Color(0xFF64B5F6),
//                               ),
//                               suffixIcon: searchQuery.isNotEmpty
//                                   ? IconButton(
//                                 icon: const Icon(
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
//                               contentPadding: const EdgeInsets.symmetric(
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
//                 // Body Section
//                 Expanded(
//                   child: isLoading
//                       ? const Center(
//                     child: CircularProgressIndicator(
//                       valueColor: AlwaysStoppedAnimation<Color>(
//                         Color(0xFF1E88E5),
//                       ),
//                     ),
//                   )
//                       : filteredNames.isEmpty
//                       ? const Center(
//                     child: Text(
//                       "No favorite stocks found",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                       ),
//                     ),
//                   )
//                       : RefreshIndicator(
//                     onRefresh: _fetchStocks,
//                     color: const Color(0xFF1E88E5),
//                     backgroundColor: const Color(0xFF0D1117),
//                     child: GridView.builder(
//                       padding: const EdgeInsets.all(20),
//                       physics: const AlwaysScrollableScrollPhysics(),
//                       gridDelegate:
//                       const SliverGridDelegateWithFixedCrossAxisCount(
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
//           color: const Color(0xFF0D1117),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: const Color(0xFF1E88E5).withOpacity(0.3),
//             width: 1.5,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xFF1E88E5).withOpacity(0.1),
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
//                 gradient: const LinearGradient(
//                   colors: [
//                     Color(0xFF1E88E5),
//                     Color(0xFF1565C0),
//                   ],
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: const Color(0xFF1E88E5).withOpacity(0.3),
//                     blurRadius: 10,
//                     spreadRadius: 2,
//                   ),
//                 ],
//               ),
//               child: const Icon(
//                 Icons.trending_up,
//                 size: 20,
//                 color: Colors.white,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(
//                   onPressed: () async {
//                     SharedPreferences sh =
//                     await SharedPreferences.getInstance();
//                     String? url = sh.getString('url');
//                     String lid = sh.getString('lid').toString();
//
//                     if (url == null) {
//                       Fluttertoast.showToast(
//                           msg: "Server URL not found.");
//                       return;
//                     }
//
//                     final uri = Uri.parse('$url/add_fav/');
//                     var request =
//                     http.MultipartRequest('POST', uri);
//                     request.fields['name'] = filteredNames[index];
//                     request.fields['lid'] = lid;
//
//                     try {
//                       var response = await request.send();
//                       var respStr =
//                       await response.stream.bytesToString();
//                       var data = jsonDecode(respStr);
//
//                       if (response.statusCode == 200 &&
//                           data['status'] == 'ok') {
//                         Fluttertoast.showToast(
//                             msg: "Removed from favorites");
//                         setState(() {
//                           filteredNames.removeAt(index);
//                           likedStatus.removeAt(index);
//                         });
//                       } else {
//                         Fluttertoast.showToast(
//                             msg: "");
//                       }
//                     } catch (e) {
//                       Fluttertoast.showToast(msg: "Error: $e");
//                     }
//                   },
//                   icon: const Icon(
//                     Icons.favorite,
//                     color: Colors.red,
//                   ),
//                 ),
//                 Expanded(
//                   child: Text(
//                     filteredNames[index],
//                     textAlign: TextAlign.center,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       height: 1.2,
//                     ),
//                   ),
//                 ),
//               ],
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
//       title: 'View Favorite Stocks',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: const Color.fromARGB(207, 97, 161, 156),
//         ),
//         useMaterial3: true,
//       ),
//       home: const view_fav_stock(title: 'Favorite Stocks'),
//     );
//   }
// }
//
// class view_fav_stock extends StatefulWidget {
//   const view_fav_stock({super.key, required this.title});
//   final String title;
//
//   @override
//   State<view_fav_stock> createState() => _view_fav_stockState();
// }
//
// class _view_fav_stockState extends State<view_fav_stock>
//     with SingleTickerProviderStateMixin {
//   List<String> name_ = [];
//   List<String> id_ = [];
//   List<String> filteredNames = [];
//   List<String> filteredIds = [];
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
//       duration: const Duration(milliseconds: 800),
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
//   // 🔹 Fetch favorite stocks from API
//   Future<void> _fetchStocks() async {
//     setState(() {
//       isLoading = true;
//     });
//
//     List<String> name = [];
//     List<String> id = [];
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       String url = '$urls/view_favstock/';
//
//       var data = await http.post(Uri.parse(url), body: {'lid': lid});
//       var jsondata = json.decode(data.body);
//
//       if (jsondata['status'] == 'ok') {
//         var arr = jsondata["data"];
//         for (int i = 0; i < arr.length; i++) {
//           name.add(arr[i]['name'].toString());
//           id.add(arr[i]['id'].toString());
//         }
//       }
//
//       setState(() {
//         name_ = List<String>.from(name);
//         id_ = List<String>.from(id);
//         filteredNames = List<String>.from(name);
//         filteredIds = List<String>.from(id);
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       Fluttertoast.showToast(msg: "Error fetching stocks: $e");
//     }
//   }
//
//   // 🔹 Filter stocks by search query
//   void _filterStocks(String query) {
//     setState(() {
//       searchQuery = query;
//       if (query.isEmpty) {
//         filteredNames = List<String>.from(name_);
//         filteredIds = List<String>.from(id_);
//       } else {
//         List<String> tempNames = [];
//         List<String> tempIds = [];
//         for (int i = 0; i < name_.length; i++) {
//           if (name_[i].toLowerCase().contains(query.toLowerCase())) {
//             tempNames.add(name_[i]);
//             tempIds.add(id_[i]);
//           }
//         }
//         filteredNames = tempNames;
//         filteredIds = tempIds;
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
//           decoration: const BoxDecoration(
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
//                 // Header Section
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
//                                 padding: const EdgeInsets.all(8),
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xFF0D1117),
//                                   borderRadius: BorderRadius.circular(12),
//                                   border: Border.all(
//                                     color: const Color(0xFF1E88E5)
//                                         .withOpacity(0.3),
//                                     width: 1,
//                                   ),
//                                 ),
//                                 child: const Icon(
//                                   Icons.arrow_back,
//                                   color: Color(0xFF64B5F6),
//                                   size: 20,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 12),
//                             const Text(
//                               'Favorite Stocks',
//                               style: TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.w900,
//                                 color: Colors.white,
//                                 letterSpacing: 1,
//                               ),
//                             ),
//                             const Spacer(),
//                             IconButton(
//                               onPressed: _fetchStocks,
//                               icon: Container(
//                                 padding: const EdgeInsets.all(8),
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xFF0D1117),
//                                   borderRadius: BorderRadius.circular(12),
//                                   border: Border.all(
//                                     color: const Color(0xFF1E88E5)
//                                         .withOpacity(0.3),
//                                     width: 1,
//                                   ),
//                                 ),
//                                 child: const Icon(
//                                   Icons.refresh,
//                                   color: Color(0xFF64B5F6),
//                                   size: 20,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 16),
//                         // Search box
//                         Container(
//                           decoration: BoxDecoration(
//                             color: const Color(0xFF0D1117),
//                             borderRadius: BorderRadius.circular(16),
//                             border: Border.all(
//                               color:
//                               const Color(0xFF1E88E5).withOpacity(0.3),
//                               width: 1.5,
//                             ),
//                           ),
//                           child: TextField(
//                             controller: _searchController,
//                             onChanged: _filterStocks,
//                             style: const TextStyle(color: Colors.white),
//                             decoration: InputDecoration(
//                               hintText: 'Search favorite stocks...',
//                               hintStyle: const TextStyle(
//                                 color: Color(0xFF8B9DC3),
//                                 fontSize: 14,
//                               ),
//                               prefixIcon: const Icon(
//                                 Icons.search,
//                                 color: Color(0xFF64B5F6),
//                               ),
//                               suffixIcon: searchQuery.isNotEmpty
//                                   ? IconButton(
//                                 icon: const Icon(
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
//                               contentPadding: const EdgeInsets.symmetric(
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
//                 // Body Section
//                 Expanded(
//                   child: isLoading
//                       ? const Center(
//                     child: CircularProgressIndicator(
//                       valueColor:
//                       AlwaysStoppedAnimation<Color>(Color(0xFF1E88E5)),
//                     ),
//                   )
//                       : filteredNames.isEmpty
//                       ? const Center(
//                     child: Text(
//                       "No favorite stocks found",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                       ),
//                     ),
//                   )
//                       : RefreshIndicator(
//                     onRefresh: _fetchStocks,
//                     color: const Color(0xFF1E88E5),
//                     backgroundColor: const Color(0xFF0D1117),
//                     child: GridView.builder(
//                       padding: const EdgeInsets.all(20),
//                       physics:
//                       const AlwaysScrollableScrollPhysics(),
//                       gridDelegate:
//                       const SliverGridDelegateWithFixedCrossAxisCount(
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
//   // 🔹 Single stock card
//   Widget _buildStockTile(BuildContext context, int index) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFF0D1117),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: const Color(0xFF1E88E5).withOpacity(0.3),
//           width: 1.5,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0xFF1E88E5).withOpacity(0.1),
//             blurRadius: 15,
//             spreadRadius: 2,
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.trending_up, color: Colors.white, size: 30),
//           const SizedBox(height: 8),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(
//                 onPressed: () async {
//                   SharedPreferences sh =
//                   await SharedPreferences.getInstance();
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
//                   request.fields['lid'] = lid;
//                   request.fields['name'] = filteredNames[index];
//                   request.fields['id'] = filteredIds[index];
//                   request.fields['price'] = "";
//
//                   try {
//                     var response = await request.send();
//                     var respStr = await response.stream.bytesToString();
//                     var data = jsonDecode(respStr);
//
//                     if (response.statusCode == 200 &&
//                         data['status'] == 'ok') {
//                       Fluttertoast.showToast(
//                           msg: "Removed from favorites");
//                       setState(() {
//                         filteredNames.removeAt(index);
//                         filteredIds.removeAt(index);
//                       });
//                     } else {
//                       Fluttertoast.showToast(
//                           msg: "Failed to remove favorite");
//                     }
//                   } catch (e) {
//                     Fluttertoast.showToast(msg: "Error: $e");
//                   }
//                 },
//                 icon: const Icon(Icons.favorite, color: Colors.red),
//               ),
//               Expanded(
//                 child: Text(
//                   filteredNames[index],
//                   textAlign: TextAlign.center,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               ElevatedButton(onPressed: ()async{
//                 SharedPreferences sh = await SharedPreferences.getInstance();
//                 String? url = sh.getString('url');
//                 String lid = sh.getString('lid').toString();
//
//                 if (url == null) {
//                   Fluttertoast.showToast(msg: "Server URL not found.");
//                   return;
//                 }
//
//                 final uri = Uri.parse('$url/priceprediction/');
//                 var request = http.MultipartRequest('POST', uri);
//                 request.fields['name'] = filteredNames[index];
//                 // request.fields['lid'] = lid;
//
//
//
//
//
//                 try {
//                   var response = await request.send();
//                   var respStr = await response.stream.bytesToString();
//                   var data = jsonDecode(respStr);
//
//                   if (response.statusCode == 200 && data['status'] == 'ok') {
//                     String rf = data['rf'].toString();
//                     String lr = data['lr'].toString();
//                     String avg = data['avg'].toString();
//                     print(rf);
//                     print("rrrrrrrrrrr");
//                     Fluttertoast.showToast(msg: "$rf,$lr,$avg");
//
//
//                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>UserViewreply(title: '',)));
//
//                   } else {
//                     Fluttertoast.showToast(msg: "Submission failed.");
//                   }
//                 } catch (e) {
//                   Fluttertoast.showToast(msg: "Error: $e");
//                 }
//               }, child: Text('pr'))
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const Viewhigh());
}

class Viewhigh extends StatelessWidget {
  const Viewhigh({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Favorite Stocks',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const view_fav_stock(title: 'Favorite Stocks'),
    );
  }
}

class view_fav_stock extends StatefulWidget {
  const view_fav_stock({super.key, required this.title});
  final String title;

  @override
  State<view_fav_stock> createState() => _view_fav_stockState();
}

class _view_fav_stockState extends State<view_fav_stock>
    with SingleTickerProviderStateMixin {
  List<String> name_ = [];
  List<String> id_ = [];
  List<String> filteredNames = [];
  List<String> filteredIds = [];
  bool isLoading = true;
  String searchQuery = '';

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
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

  Future<void> _fetchStocks() async {
    setState(() {
      isLoading = true;
    });

    List<String> name = [];
    List<String> id = [];
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/view_favstock/';

      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);

      if (jsondata['status'] == 'ok') {
        var arr = jsondata["data"];
        for (int i = 0; i < arr.length; i++) {
          name.add(arr[i]['name'].toString());
          id.add(arr[i]['id'].toString());
        }
      }

      setState(() {
        name_ = List<String>.from(name);
        id_ = List<String>.from(id);
        filteredNames = List<String>.from(name);
        filteredIds = List<String>.from(id);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: "Error fetching stocks: $e");
    }
  }

  void _filterStocks(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredNames = List<String>.from(name_);
        filteredIds = List<String>.from(id_);
      } else {
        List<String> tempNames = [];
        List<String> tempIds = [];
        for (int i = 0; i < name_.length; i++) {
          if (name_[i].toLowerCase().contains(query.toLowerCase())) {
            tempNames.add(name_[i]);
            tempIds.add(id_[i]);
          }
        }
        filteredNames = tempNames;
        filteredIds = tempIds;
      }
    });
  }

  // Show Price Prediction Dialog
  void _showPredictionDialog(String stockName, String rf, String lr, String avg) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0D1117),
                Color(0xFF0A1628),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Color(0xFF1E88E5).withOpacity(0.3),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF1E88E5).withOpacity(0.3),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF1E88E5),
                      Color(0xFF1565C0),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF1E88E5).withOpacity(0.4),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.auto_graph_rounded,
                      size: 48,
                      color: Colors.white,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Price Prediction',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      stockName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Prediction Cards
              _buildPredictionCard(
                'Random Forest',
                rf,
                Icons.account_tree_rounded,
                Color(0xFF26A69A),
              ),
              SizedBox(height: 12),
              _buildPredictionCard(
                'Linear Regression',
                lr,
                Icons.show_chart_rounded,
                Color(0xFF42A5F5),
              ),
              SizedBox(height: 12),
              _buildPredictionCard(
                'Average Prediction',
                avg,
                Icons.analytics_rounded,
                Color(0xFFAB47BC),
              ),
              SizedBox(height: 24),

              // Close Button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 14),
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
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Text(
                    'CLOSE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPredictionCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF0D1117),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  color,
                  color.withOpacity(0.7),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64B5F6),
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '\n$value',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
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
            child: Column(
              children: [
                // Header Section
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0D1117),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xFF1E88E5).withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Color(0xFF64B5F6),
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFEF5350),
                                    Color(0xFFE91E63),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFEF5350).withOpacity(0.4),
                                    blurRadius: 15,
                                    spreadRadius: 3,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.favorite,
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
                                    'FAVORITES',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    '${filteredNames.length} stocks',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF64B5F6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: _fetchStocks,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0D1117),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xFF1E88E5).withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.refresh,
                                  color: Color(0xFF64B5F6),
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Search box
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF0D1117),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF1E88E5).withOpacity(0.3),
                              width: 1.5,
                            ),
                          ),
                          child: TextField(
                            controller: _searchController,
                            onChanged: _filterStocks,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Search favorite stocks...',
                              hintStyle: const TextStyle(
                                color: Color(0xFF8B9DC3),
                                fontSize: 14,
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Color(0xFF64B5F6),
                              ),
                              suffixIcon: searchQuery.isNotEmpty
                                  ? IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  color: Color(0xFF64B5F6),
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                  _filterStocks('');
                                },
                              )
                                  : null,
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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

                // Body Section
                Expanded(
                  child: isLoading
                      ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1E88E5)),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Loading favorites...',
                          style: TextStyle(
                            color: Color(0xFF64B5F6),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                      : filteredNames.isEmpty
                      ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 80,
                          color: Color(0xFF1E88E5).withOpacity(0.3),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "No favorite stocks found",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Add stocks to your favorites',
                          style: TextStyle(
                            color: Color(0xFF64B5F6),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                      : RefreshIndicator(
                    onRefresh: _fetchStocks,
                    color: const Color(0xFF1E88E5),
                    backgroundColor: const Color(0xFF0D1117),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(20),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: filteredNames.length,
                      itemBuilder: (context, index) {
                        return TweenAnimationBuilder(
                          duration: Duration(milliseconds: 300 + (index * 50)),
                          tween: Tween<double>(begin: 0, end: 1),
                          builder: (context, double value, child) {
                            return Transform.translate(
                              offset: Offset(0, 30 * (1 - value)),
                              child: Opacity(
                                opacity: value,
                                child: child,
                              ),
                            );
                          },
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

  Widget _buildStockCard(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1117),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF1E88E5).withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E88E5).withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Icon
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
                Icons.candlestick_chart,
                color: Colors.white,
                size: 28,
              ),
            ),
            SizedBox(width: 14),
            // Stock Name
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    filteredNames[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  // Text(
                  //   'Stock ID: ${filteredIds[index]}',
                  //   style: TextStyle(
                  //     color: Color(0xFF64B5F6),
                  //     fontSize: 12,
                  //   ),
                  // ),
                ],
              ),
            ),
            // Action Buttons
            Row(
              children: [
                // Predict Button
                GestureDetector(
                  onTap: () async {
                    SharedPreferences sh = await SharedPreferences.getInstance();
                    String? url = sh.getString('url');
                    String lid = sh.getString('lid').toString();

                    if (url == null) {
                      Fluttertoast.showToast(msg: "Server URL not found.");
                      return;
                    }

                    // Show loading
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1E88E5)),
                        ),
                      ),
                    );

                    final uri = Uri.parse('$url/priceprediction/');
                    var request = http.MultipartRequest('POST', uri);
                    request.fields['name'] = filteredNames[index];

                    try {
                      var response = await request.send();
                      var respStr = await response.stream.bytesToString();
                      var data = jsonDecode(respStr);

                      Navigator.pop(context); // Close loading

                      if (response.statusCode == 200 && data['status'] == 'ok') {
                        String rf = data['rf'].toString();
                        String lr = data['lr'].toString();
                        String avg = data['avg'].toString();

                        _showPredictionDialog(filteredNames[index], rf, lr, avg);
                      } else {
                        Fluttertoast.showToast(
                          msg: "Prediction failed.",
                          backgroundColor: Color(0xFFEF5350),
                        );
                      }
                    } catch (e) {
                      Navigator.pop(context); // Close loading
                      Fluttertoast.showToast(
                        msg: "Error: $e",
                        backgroundColor: Color(0xFFEF5350),
                      );
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF26A69A),
                          Color(0xFF00897B),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF26A69A).withOpacity(0.4),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.analytics,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'PREDICT',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                // Favorite Button
                GestureDetector(
                  onTap: () async {
                    SharedPreferences sh = await SharedPreferences.getInstance();
                    String? url = sh.getString('url');
                    String lid = sh.getString('lid').toString();

                    if (url == null) {
                      Fluttertoast.showToast(msg: "Server URL not found.");
                      return;
                    }

                    final uri = Uri.parse('$url/add_fav/');
                    var request = http.MultipartRequest('POST', uri);
                    request.fields['lid'] = lid;
                    request.fields['name'] = filteredNames[index];
                    request.fields['id'] = filteredIds[index];
                    request.fields['price'] = "";

                    try {
                      var response = await request.send();
                      var respStr = await response.stream.bytesToString();
                      var data = jsonDecode(respStr);

                      if (response.statusCode == 200 && data['status'] == 'ok') {
                        Fluttertoast.showToast(
                          msg: "Removed from favorites",
                          backgroundColor: Color(0xFFEF5350),
                        );
                        setState(() {
                          filteredNames.removeAt(index);
                          filteredIds.removeAt(index);
                        });
                      } else {
                        Fluttertoast.showToast(msg: "Failed to remove favorite");
                      }
                    } catch (e) {
                      Fluttertoast.showToast(msg: "Error: $e");
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFFEF5350).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color(0xFFEF5350).withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Color(0xFFEF5350),
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}