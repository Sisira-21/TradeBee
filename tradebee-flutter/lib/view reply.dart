// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// import 'Userhome.dart';
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
//       home: UserViewreply(title: 'View Reply'),
//     );
//   }
// }
//
// class UserViewreply extends StatefulWidget {
//   const UserViewreply({super.key, required this.title});
//   final String title;
//
//   @override
//   State<UserViewreply> createState() => _UserViewreplyState();
// }
//
// class _UserViewreplyState extends State<UserViewreply> {
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
//       String lid = sh.getString('lid') ?? '';
//       String img = sh.getString('img_url') ?? '';
//       String apiUrl = '$urls/user_viewreply/';
//
//       var response = await http.post(Uri.parse(apiUrl), body: {
//
//         'lid':lid
//       });
//       var jsonData = json.decode(response.body);
//
//       if (jsonData['status'] == 'ok') {
//         List<Map<String, dynamic>> tempList = [];
//         for (var item in jsonData['data']) {
//           tempList.add({
//             'id': item['id'],
//             'complaint': item['complaint'],
//             'reply': item['reply'],
//             'status': item['status'],
//             'date': item['date'],
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
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => const BankingDashboard()),
//           );
//           return true; // Prevent default pop
//         },
//         child:Scaffold(
//           appBar: AppBar(
//             backgroundColor: Color.fromARGB(255, 232, 177, 61),
//             title: Text('View Reply'),
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
//                   title: Text(user['complaint'], style: TextStyle(fontWeight: FontWeight.bold)),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("reply: ${user['reply']}"),
//                       Text("status: ${user['status']}"),
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

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'Userhome.dart';
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
//       debugShowCheckedModeBanner: false,
//       home: UserViewreply(title: 'View Reply'),
//     );
//   }
// }
//
// class UserViewreply extends StatefulWidget {
//   const UserViewreply({super.key, required this.title});
//   final String title;
//
//   @override
//   State<UserViewreply> createState() => _UserViewreplyState();
// }
//
// class _UserViewreplyState extends State<UserViewreply> with SingleTickerProviderStateMixin {
//   List<Map<String, dynamic>> users = [];
//   bool isLoading = true;
//   String filterStatus = 'All';
//
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
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
//     viewUsers("");
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   Future<void> viewUsers(String searchValue) async {
//     setState(() {
//       isLoading = true;
//     });
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url') ?? '';
//       String lid = sh.getString('lid') ?? '';
//       String apiUrl = '$urls/user_viewreply/';
//
//       var response = await http.post(Uri.parse(apiUrl), body: {
//         'lid': lid
//       });
//       var jsonData = json.decode(response.body);
//
//       if (jsonData['status'] == 'ok') {
//         List<Map<String, dynamic>> tempList = [];
//         for (var item in jsonData['data']) {
//           tempList.add({
//             'id': item['id'],
//             'complaint': item['complaint'],
//             'reply': item['reply'],
//             'status': item['status'],
//             'date': item['date'],
//           });
//         }
//         setState(() {
//           users = tempList;
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       print("Error fetching users: $e");
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   List<Map<String, dynamic>> getFilteredUsers() {
//     if (filterStatus == 'All') {
//       return users;
//     }
//     return users.where((user) => user['status'] == filterStatus).toList();
//   }
//
//   Color _getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'pending':
//         return Color(0xFFFFCA28);
//       case 'replied':
//       case 'resolved':
//         return Color(0xFF26A69A);
//       case 'rejected':
//         return Color(0xFFEF5350);
//       default:
//         return Color(0xFF64B5F6);
//     }
//   }
//
//   IconData _getStatusIcon(String status) {
//     switch (status.toLowerCase()) {
//       case 'pending':
//         return Icons.pending_outlined;
//       case 'replied':
//       case 'resolved':
//         return Icons.check_circle_outline;
//       case 'rejected':
//         return Icons.cancel_outlined;
//       default:
//         return Icons.info_outline;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final filteredUsers = getFilteredUsers();
//
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const BankingDashboard()),
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
//                                     builder: (context) => const BankingDashboard(),
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
//                                 Icons.question_answer_outlined,
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
//                                     'Complaint Replies',
//                                     style: TextStyle(
//                                       fontSize: 22,
//                                       fontWeight: FontWeight.w900,
//                                       color: Colors.white,
//                                       letterSpacing: 1,
//                                     ),
//                                   ),
//                                   Text(
//                                     '${filteredUsers.length} ${filterStatus == 'All' ? 'Total' : filterStatus}',
//                                     style: TextStyle(
//                                       fontSize: 12,
//                                       color: Color(0xFF64B5F6),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             IconButton(
//                               onPressed: () => viewUsers(""),
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
//                         // Filter Chips
//                         SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Row(
//                             children: [
//                               _buildFilterChip('All'),
//                               SizedBox(width: 8),
//                               _buildFilterChip('pending'),
//                               SizedBox(width: 8),
//                               _buildFilterChip('replied'),
//                               SizedBox(width: 8),
//                               _buildFilterChip('resolved'),
//                             ],
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
//                           'Loading replies...',
//                           style: TextStyle(
//                             color: Color(0xFF64B5F6),
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                       : filteredUsers.isEmpty
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
//                               Icons.inbox_outlined,
//                               size: 50,
//                               color: Color(0xFF64B5F6),
//                             ),
//                           ),
//                           SizedBox(height: 24),
//                           Text(
//                             'No Replies Found',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             filterStatus == 'All'
//                                 ? 'You haven\'t received any replies yet'
//                                 : 'No $filterStatus complaints found',
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
//                     onRefresh: () => viewUsers(""),
//                     color: Color(0xFF1E88E5),
//                     backgroundColor: Color(0xFF0D1117),
//                     child: ListView.builder(
//                       padding: EdgeInsets.all(20),
//                       physics: AlwaysScrollableScrollPhysics(),
//                       itemCount: filteredUsers.length,
//                       itemBuilder: (context, index) {
//                         final user = filteredUsers[index];
//                         return FadeTransition(
//                           opacity: _fadeAnimation,
//                           child: _buildComplaintCard(user, index),
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
//   Widget _buildFilterChip(String label) {
//     final isSelected = filterStatus == label;
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           filterStatus = label;
//         });
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         decoration: BoxDecoration(
//           gradient: isSelected
//               ? LinearGradient(
//             colors: [
//               Color(0xFF1E88E5),
//               Color(0xFF1565C0),
//             ],
//           )
//               : null,
//           color: isSelected ? null : Color(0xFF0D1117),
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(
//             color: isSelected
//                 ? Color(0xFF1E88E5)
//                 : Color(0xFF1E88E5).withOpacity(0.3),
//             width: 1.5,
//           ),
//           boxShadow: isSelected
//               ? [
//             BoxShadow(
//               color: Color(0xFF1E88E5).withOpacity(0.3),
//               blurRadius: 12,
//               spreadRadius: 2,
//             ),
//           ]
//               : [],
//         ),
//         child: Text(
//           label,
//           style: TextStyle(
//             color: isSelected ? Colors.white : Color(0xFF64B5F6),
//             fontSize: 13,
//             fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildComplaintCard(Map<String, dynamic> user, int index) {
//     final statusColor = _getStatusColor(user['status']);
//     final statusIcon = _getStatusIcon(user['status']);
//     final hasReply = user['reply'] != null && user['reply'].toString().isNotEmpty;
//
//     return Container(
//       margin: EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: Color(0xFF0D1117),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: statusColor.withOpacity(0.3),
//           width: 1.5,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: statusColor.withOpacity(0.1),
//             blurRadius: 15,
//             spreadRadius: 2,
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header with Status
//           Container(
//             padding: EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: statusColor.withOpacity(0.1),
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(16),
//                 topRight: Radius.circular(16),
//               ),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: statusColor.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Icon(
//                     statusIcon,
//                     color: statusColor,
//                     size: 20,
//                   ),
//                 ),
//                 SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Complaint #${user['id']}',
//                         style: TextStyle(
//                           color: Color(0xFF8B9DC3),
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       SizedBox(height: 2),
//                       Text(
//                         user['status'].toString().toUpperCase(),
//                         style: TextStyle(
//                           color: statusColor,
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: 0.5,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Text(
//                   user['date'] ?? '',
//                   style: TextStyle(
//                     color: Color(0xFF8B9DC3),
//                     fontSize: 11,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // Complaint Content
//           Padding(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.report_problem_outlined,
//                       color: Color(0xFFEC407A),
//                       size: 18,
//                     ),
//                     SizedBox(width: 8),
//                     Text(
//                       'Your Complaint',
//                       style: TextStyle(
//                         color: Color(0xFF64B5F6),
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   user['complaint'],
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 14,
//                     height: 1.5,
//                   ),
//                 ),
//
//                 if (hasReply) ...[
//                   SizedBox(height: 16),
//                   Divider(
//                     color: Color(0xFF1E88E5).withOpacity(0.2),
//                     thickness: 1,
//                   ),
//                   SizedBox(height: 16),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.support_agent,
//                         color: Color(0xFF26A69A),
//                         size: 18,
//                       ),
//                       SizedBox(width: 8),
//                       Text(
//                         'Support Team Reply',
//                         style: TextStyle(
//                           color: Color(0xFF26A69A),
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Container(
//                     padding: EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Color(0xFF26A69A).withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(
//                         color: Color(0xFF26A69A).withOpacity(0.3),
//                         width: 1,
//                       ),
//                     ),
//                     child: Text(
//                       user['reply'],
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         height: 1.5,
//                       ),
//                     ),
//                   ),
//                 ] else ...[
//                   SizedBox(height: 12),
//                   Container(
//                     padding: EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Color(0xFFFFCA28).withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(
//                         color: Color(0xFFFFCA28).withOpacity(0.3),
//                         width: 1,
//                       ),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.schedule,
//                           color: Color(0xFFFFCA28),
//                           size: 16,
//                         ),
//                         SizedBox(width: 8),
//                         Expanded(
//                           child: Text(
//                             'Waiting for support team response',
//                             style: TextStyle(
//                               color: Color(0xFFFFCA28),
//                               fontSize: 12,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tradebee1/sendcomplaint.dart';
import 'Userhome.dart';

void main() {
  runApp(const ViewHouseApp());
}

class ViewHouseApp extends StatelessWidget {
  const ViewHouseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserViewreply(title: 'View Reply'),
    );
  }
}

class UserViewreply extends StatefulWidget {
  const UserViewreply({super.key, required this.title});
  final String title;

  @override
  State<UserViewreply> createState() => _UserViewreplyState();
}

class _UserViewreplyState extends State<UserViewreply> with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> users = [];
  bool isLoading = true;
  String filterStatus = 'All';

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
      String apiUrl = '$urls/user_viewreply/';

      var response = await http.post(Uri.parse(apiUrl), body: {
        'lid': lid
      });
      var jsonData = json.decode(response.body);

      if (jsonData['status'] == 'ok') {
        List<Map<String, dynamic>> tempList = [];
        for (var item in jsonData['data']) {
          tempList.add({
            'id': item['id'],
            'complaint': item['complaint'],
            'reply': item['reply'],
            'status': item['status'],
            'date': item['date'],
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
      print("Error fetching users: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  List<Map<String, dynamic>> getFilteredUsers() {
    if (filterStatus == 'All') {
      return users;
    }
    return users.where((user) => user['status'] == filterStatus).toList();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Color(0xFFFFCA28);
      case 'replied':
      case 'resolved':
        return Color(0xFF26A69A);
      case 'rejected':
        return Color(0xFFEF5350);
      default:
        return Color(0xFF64B5F6);
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Icons.pending_outlined;
      case 'replied':
      case 'resolved':
        return Icons.check_circle_outline;
      case 'rejected':
        return Icons.cancel_outlined;
      default:
        return Icons.info_outline;
    }
  }

  // void _showSendComplaintDialog() {
  //   final TextEditingController complaintController = TextEditingController();
  //
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         backgroundColor: Colors.transparent,
  //         child: Container(
  //           decoration: BoxDecoration(
  //             color: Color(0xFF0D1117),
  //             borderRadius: BorderRadius.circular(20),
  //             border: Border.all(
  //               color: Color(0xFF1E88E5).withOpacity(0.3),
  //               width: 1.5,
  //             ),
  //           ),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               // Header
  //               Container(
  //                 padding: EdgeInsets.all(20),
  //                 decoration: BoxDecoration(
  //                   gradient: LinearGradient(
  //                     colors: [
  //                       Color(0xFF1E88E5),
  //                       Color(0xFF1565C0),
  //                     ],
  //                   ),
  //                   borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(20),
  //                     topRight: Radius.circular(20),
  //                   ),
  //                 ),
  //                 child: Row(
  //                   children: [
  //                     Icon(
  //                       Icons.add_comment,
  //                       color: Colors.white,
  //                       size: 24,
  //                     ),
  //                     SizedBox(width: 12),
  //                     Text(
  //                       'Send New Complaint',
  //                       style: TextStyle(
  //                         color: Colors.white,
  //                         fontSize: 18,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //
  //               // Content
  //               Padding(
  //                 padding: EdgeInsets.all(20),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       'Describe your complaint',
  //                       style: TextStyle(
  //                         color: Color(0xFF64B5F6),
  //                         fontSize: 14,
  //                         fontWeight: FontWeight.w600,
  //                       ),
  //                     ),
  //                     SizedBox(height: 12),
  //                     Container(
  //                       decoration: BoxDecoration(
  //                         color: Color(0xFF000000).withOpacity(0.3),
  //                         borderRadius: BorderRadius.circular(12),
  //                         border: Border.all(
  //                           color: Color(0xFF1E88E5).withOpacity(0.3),
  //                           width: 1,
  //                         ),
  //                       ),
  //                       child: TextField(
  //                         controller: complaintController,
  //                         maxLines: 5,
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                           fontSize: 14,
  //                         ),
  //                         decoration: InputDecoration(
  //                           hintText: 'Enter your complaint here...',
  //                           hintStyle: TextStyle(
  //                             color: Color(0xFF8B9DC3),
  //                             fontSize: 14,
  //                           ),
  //                           border: InputBorder.none,
  //                           contentPadding: EdgeInsets.all(16),
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(height: 20),
  //
  //                     // Buttons
  //                     Row(
  //                       children: [
  //                         Expanded(
  //                           child: TextButton(
  //                             onPressed: () {
  //                               Navigator.pop(context);
  //                             },
  //                             style: TextButton.styleFrom(
  //                               padding: EdgeInsets.symmetric(vertical: 14),
  //                               backgroundColor: Color(0xFF1E1E1E),
  //                               shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(12),
  //                                 side: BorderSide(
  //                                   color: Color(0xFF1E88E5).withOpacity(0.3),
  //                                   width: 1,
  //                                 ),
  //                               ),
  //                             ),
  //                             child: Text(
  //                               'Cancel',
  //                               style: TextStyle(
  //                                 color: Color(0xFF8B9DC3),
  //                                 fontSize: 14,
  //                                 fontWeight: FontWeight.w600,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         SizedBox(width: 12),
  //                         Expanded(
  //                           child: ElevatedButton(
  //                             onPressed: () async {
  //
  //                               Navigator.push(context, MaterialPageRoute(builder: (context) => MySendComplaint(title: '')));
  //                               // if (complaintController.text.trim().isEmpty) {
  //                               //   ScaffoldMessenger.of(context).showSnackBar(
  //                               //     SnackBar(
  //                               //       content: Text('Please enter a complaint'),
  //                               //       backgroundColor: Color(0xFFEF5350),
  //                               //     ),
  //                               //   );
  //                               //   return;
  //                               // }
  //                               //
  //                               // // TODO: Implement send complaint API
  //                               // // await sendComplaint(complaintController.text);
  //                               //
  //                               // Navigator.pop(context);
  //                               // ScaffoldMessenger.of(context).showSnackBar(
  //                               //   SnackBar(
  //                               //     content: Row(
  //                               //       children: [
  //                               //         Icon(Icons.check_circle, color: Colors.white),
  //                               //         SizedBox(width: 8),
  //                               //         Text('Complaint sent successfully!'),
  //                               //       ],
  //                               //     ),
  //                               //     backgroundColor: Color(0xFF26A69A),
  //                               //   ),
  //                               // );
  //                               //
  //                               // // Refresh the list
  //                               // viewUsers("");
  //                             },
  //                             style: ElevatedButton.styleFrom(
  //                               padding: EdgeInsets.symmetric(vertical: 14),
  //                               backgroundColor: Color(0xFF1E88E5),
  //                               shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(12),
  //                               ),
  //                               elevation: 0,
  //                             ),
  //                             child: Text(
  //                               'Send',
  //                               style: TextStyle(
  //                                 color: Colors.white,
  //                                 fontSize: 14,
  //                                 fontWeight: FontWeight.bold,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final filteredUsers = getFilteredUsers();

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BankingDashboard()),
        );
        return false;
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => MySendComplaint(title: '')));

          },
          backgroundColor: Color(0xFF1E88E5),
          elevation: 8,
          icon: Icon(Icons.add, color: Colors.white, size: 22),
          label: Text(
            'New Complaint',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 0.5,
            ),
          ),
        ),
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
            child: Column(
              children: [
                // Header
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const BankingDashboard(),
                                  ),
                                );
                              },
                              icon: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color(0xFF0D1117),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Color(0xFF1E88E5).withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Color(0xFF64B5F6),
                                  size: 20,
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF5C6BC0),
                                    Color(0xFF3949AB),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF5C6BC0).withOpacity(0.4),
                                    blurRadius: 15,
                                    spreadRadius: 3,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.question_answer_outlined,
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
                                    'Complaint Replies',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  Text(
                                    '${filteredUsers.length} ${filterStatus == 'All' ? 'Total' : filterStatus}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF64B5F6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () => viewUsers(""),
                              icon: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color(0xFF0D1117),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Color(0xFF1E88E5).withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Icon(
                                  Icons.refresh,
                                  color: Color(0xFF64B5F6),
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),

                        // Filter Chips
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _buildFilterChip('All'),
                              SizedBox(width: 8),
                              _buildFilterChip('pending'),
                              SizedBox(width: 8),
                              _buildFilterChip('replied'),
                              SizedBox(width: 8),
                              _buildFilterChip('resolved'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Content
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
                          'Loading replies...',
                          style: TextStyle(
                            color: Color(0xFF64B5F6),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  )
                      : filteredUsers.isEmpty
                      ? Center(
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF0D1117),
                              border: Border.all(
                                color: Color(0xFF1E88E5).withOpacity(0.3),
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.inbox_outlined,
                              size: 50,
                              color: Color(0xFF64B5F6),
                            ),
                          ),
                          SizedBox(height: 24),
                          Text(
                            'No Replies Found',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            filterStatus == 'All'
                                ? 'You haven\'t received any replies yet'
                                : 'No $filterStatus complaints found',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF8B9DC3),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                      : RefreshIndicator(
                    onRefresh: () => viewUsers(""),
                    color: Color(0xFF1E88E5),
                    backgroundColor: Color(0xFF0D1117),
                    child: ListView.builder(
                      padding: EdgeInsets.all(20),
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = filteredUsers[index];
                        return FadeTransition(
                          opacity: _fadeAnimation,
                          child: _buildComplaintCard(user, index),
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

  Widget _buildFilterChip(String label) {
    final isSelected = filterStatus == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          filterStatus = label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
            colors: [
              Color(0xFF1E88E5),
              Color(0xFF1565C0),
            ],
          )
              : null,
          color: isSelected ? null : Color(0xFF0D1117),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Color(0xFF1E88E5)
                : Color(0xFF1E88E5).withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: Color(0xFF1E88E5).withOpacity(0.3),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Color(0xFF64B5F6),
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildComplaintCard(Map<String, dynamic> user, int index) {
    final statusColor = _getStatusColor(user['status']);
    final statusIcon = _getStatusIcon(user['status']);
    final hasReply = user['reply'] != null && user['reply'].toString().isNotEmpty;

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Color(0xFF0D1117),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: statusColor.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Status
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    statusIcon,
                    color: statusColor,
                    size: 20,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Complaint #${user['id']}',
                        style: TextStyle(
                          color: Color(0xFF8B9DC3),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        user['status'].toString().toUpperCase(),
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  user['date'] ?? '',
                  style: TextStyle(
                    color: Color(0xFF8B9DC3),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          // Complaint Content
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.report_problem_outlined,
                      color: Color(0xFFEC407A),
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Your Complaint',
                      style: TextStyle(
                        color: Color(0xFF64B5F6),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  user['complaint'],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),

                if (hasReply) ...[
                  SizedBox(height: 16),
                  Divider(
                    color: Color(0xFF1E88E5).withOpacity(0.2),
                    thickness: 1,
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(
                        Icons.support_agent,
                        color: Color(0xFF26A69A),
                        size: 18,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Support Team Reply',
                        style: TextStyle(
                          color: Color(0xFF26A69A),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFF26A69A).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(0xFF26A69A).withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      user['reply'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ),
                ] else ...[
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFCA28).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Color(0xFFFFCA28).withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          color: Color(0xFFFFCA28),
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Waiting for support team response',
                            style: TextStyle(
                              color: Color(0xFFFFCA28),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}