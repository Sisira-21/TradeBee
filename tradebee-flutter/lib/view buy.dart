// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:tradebee1/Userhome.dart';
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
//       home: Viewbuystock(title: 'View Buy Stock'),
//     );
//   }
// }
//
// class Viewbuystock extends StatefulWidget {
//   const Viewbuystock({super.key, required this.title});
//   final String title;
//
//   @override
//   State<Viewbuystock> createState() => _ViewbuystockState();
// }
//
// class _ViewbuystockState extends State<Viewbuystock> {
//   List<Map<String, dynamic>> users = [];
//   List<Map<String, dynamic>> filteredUsers = [];
//   List<String> nameSuggestions = [];
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
//       String lid = sh.getString('lid').toString();
//       // String img = sh.getString('img_url') ?? '';
//       String apiUrl = '$urls/user_viewbuy/';
//
//       var response = await http.post(Uri.parse(apiUrl), body: {
//         'lid':lid
//       });
//       var jsonData = json.decode(response.body);
//
//       if (jsonData['status'] == 'ok') {
//         List<Map<String, dynamic>> tempList = [];
//         for (var item in jsonData['data']) {
//           tempList.add({
//             'id': item['id'],
//             'name': item['name'],
//             'quantity': item['quantity'],
//             'amount': item['amount'],
//             'date': item['date'],
//           });
//         }
//         setState(() {
//           users = tempList;
//           filteredUsers = tempList
//               .where((user) =>
//               user['name']
//                   .toString()
//                   .toLowerCase()
//                   .contains(searchValue.toLowerCase()))
//               .toList();
//           nameSuggestions = users.map((e) => e['name'].toString()).toSet().toList();
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
//           return false; // Prevent default pop
//         },
//         child:Scaffold(
//           appBar: AppBar(),
//           body: ListView.builder(
//             shrinkWrap: true,
//             physics: BouncingScrollPhysics(),
//             itemCount: filteredUsers.length,
//             itemBuilder: (context, index) {
//               final user = filteredUsers[index];
//               return Card(
//                 margin: const EdgeInsets.all(10),
//                 elevation: 5,
//                 child: ListTile(
//                    subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("name: ${user['name']}"),
//                       Text("quantity: ${user['quantity']}"),
//                       Text("amount: ${user['amount']}"),
//                       Text("date: ${user['date']}"),
//
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
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tradebee1/Userhome.dart';

void main() {
  runApp(const ViewHouseApp());
}

class ViewHouseApp extends StatelessWidget {
  const ViewHouseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Viewbuystock(title: 'View Buy Stock'),
    );
  }
}

class Viewbuystock extends StatefulWidget {
  const Viewbuystock({super.key, required this.title});
  final String title;

  @override
  State<Viewbuystock> createState() => _ViewbuystockState();
}

class _ViewbuystockState extends State<Viewbuystock>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> users = [];
  bool isLoading = true;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.easeInOut),
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
    setState(() => isLoading = true);
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url') ?? '';
      String lid = sh.getString('lid').toString();
      String apiUrl = '$urls/user_viewbuy/';

      var response =
      await http.post(Uri.parse(apiUrl), body: {'lid': lid});
      var jsonData = json.decode(response.body);

      if (jsonData['status'] == 'ok') {
        List<Map<String, dynamic>> tempList = [];
        for (var item in jsonData['data']) {
          tempList.add({
            'id': item['id'],
            'name': item['name'],
            'quantity': item['quantity'],
            'amount': item['amount'],
            'date': item['date'],
            'currstockprice_old': item['currstockprice_old'],
            'currstockprice': item['currstockprice'],
            'status': item['status'],
          });
        }
        setState(() {
          users = tempList;
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      debugPrint("Error fetching users: $e");
      setState(() => isLoading = false);
    }
  }

  double get _totalInvested => users.fold(
      0.0, (sum, u) => sum + (double.tryParse(u['amount'].toString()) ?? 0));

  int get _totalQty => users.fold(
      0, (sum, u) => sum + (int.tryParse(u['quantity'].toString()) ?? 0));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const BankingDashboard()),
        );
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
                // ── Header ──────────────────────────────────────
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const BankingDashboard()),
                              ),
                              icon: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0D1117),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xFF1E88E5)
                                        .withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Color(0xFF64B5F6),
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            // ── NEW ICON: trending_up inside teal circle ──
                            Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF00897B),
                                    Color(0xFF00695C),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF00897B)
                                        .withOpacity(0.45),
                                    blurRadius: 15,
                                    spreadRadius: 3,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.trending_up_rounded,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'My Purchases',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  Text(
                                    '${users.length} Total Stocks',
                                    style: const TextStyle(
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
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0D1117),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xFF1E88E5)
                                        .withOpacity(0.3),
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

                        // ── Summary Row ──────────────────────────
                        if (!isLoading && users.isNotEmpty)
                          Row(
                            children: [
                              _SummaryTile(
                                icon: Icons.account_balance_wallet_rounded,
                                label: 'Total Invested',
                                value:
                                '₹${_totalInvested.toStringAsFixed(2)}',
                                color: const Color(0xFF26A69A),
                              ),
                              const SizedBox(width: 12),
                              _SummaryTile(
                                icon: Icons.bar_chart_rounded,
                                label: 'Total Shares',
                                value: '$_totalQty qty',
                                color: const Color(0xFF1E88E5),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),

                // ── List / Loading / Empty ───────────────────────
                Expanded(
                  child: isLoading
                      ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFF1E88E5)),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Loading purchases...',
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
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF0D1117),
                              border: Border.all(
                                color: const Color(0xFF1E88E5)
                                    .withOpacity(0.3),
                                width: 2,
                              ),
                            ),
                            child: const Icon(
                              Icons.shopping_bag_outlined,
                              size: 50,
                              color: Color(0xFF64B5F6),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'No Purchases Found',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "You haven't bought any stocks yet",
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
                    color: const Color(0xFF1E88E5),
                    backgroundColor: const Color(0xFF0D1117),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(20),
                      physics:
                      const AlwaysScrollableScrollPhysics(),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        return FadeTransition(
                          opacity: _fadeAnimation,
                          child: _buildStockCard(
                              users[index], index),
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

  Widget _buildStockCard(Map<String, dynamic> user, int index) {
    final List<Color> accentColors = [
      const Color(0xFF1E88E5),
      const Color(0xFF26A69A),
      const Color(0xFF5C6BC0),
      const Color(0xFFEC407A),
    ];
    final color = accentColors[index % accentColors.length];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1117),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Card Header (mirrors complaint card header) ───
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.trending_up_rounded,
                    color: color,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order #${user['id']}',
                        style: const TextStyle(
                          color: Color(0xFF8B9DC3),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        user['name'].toString().toUpperCase(),
                        style: TextStyle(
                          color: color,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        user['currstockprice_old'].toString().toUpperCase(),
                        style: TextStyle(
                          color: color,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        user['currstockprice'].toString().toUpperCase(),
                        style: TextStyle(
                          color: color,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        user['status'].toString().toUpperCase(),
                        style: TextStyle(
                          color: color,
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
                  style: const TextStyle(
                    color: Color(0xFF8B9DC3),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          // ── Card Body ────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Quantity block
                Expanded(
                  child: _InfoBlock(
                    icon: Icons.layers_rounded,
                    label: 'Quantity',
                    value: '${user['quantity']} shares',
                    iconColor: const Color(0xFF64B5F6),
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: const Color(0xFF1E88E5).withOpacity(0.2),
                ),
                // Amount block
                Expanded(
                  child: _InfoBlock(
                    icon: Icons.currency_rupee_rounded,
                    label: 'Amount Paid',
                    value: 'ETH.${user['amount']}',
                    iconColor: const Color(0xFF26A69A),
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity, // makes button take full card width
              child: ElevatedButton(
                onPressed: () async{
                  SharedPreferences sh =await SharedPreferences.getInstance();
                  sh.setString("stock", user['name'].toString());
                  sh.setString("qty", user['quantity'].toString());
                  String? url = sh.getString('url');
                  String lid = sh.getString('lid').toString();
                  String stock = sh.getString('stock').toString();
                  String qty = sh.getString('qty').toString();

                  if (url == null) {
                    Fluttertoast.showToast(msg: "Server URL not found.");
                    return;
                  }

                  final uri = Uri.parse('$url/sell/');
                  var request = http.MultipartRequest('POST', uri);
                  request.fields['lid'] = lid;
                  request.fields['stock'] = stock;
                  request.fields['qty'] = qty;

                  try {
                    var response = await request.send();
                    var respStr = await response.stream.bytesToString();
                    var data = jsonDecode(respStr);

                    if (response.statusCode == 200 && data['status'] == 'ok') {
                      Fluttertoast.showToast(msg: "Saled Successfully.");
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => MyLogin(
                      //           title: '',
                      //         )));
                    } else {
                      Fluttertoast.showToast(msg: "failed.");
                    }
                  } catch (e) {
                    Fluttertoast.showToast(msg: "Error: $e");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // black background
                  foregroundColor: Colors.white, // text color
                  side: BorderSide(color: Colors.blue, width: 2), // blue border
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14), // optional height
                ),
                child: Text('Sell'),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ── Summary Tile ──────────────────────────────────────────────────────────────
class _SummaryTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _SummaryTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF0D1117),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 12,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    label,
                    style: const TextStyle(
                      color: Color(0xFF8B9DC3),
                      fontSize: 10,
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

// ── Info Block ────────────────────────────────────────────────────────────────
class _InfoBlock extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;

  const _InfoBlock({
    required this.icon,
    required this.label,
    required this.value,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 14),
              const SizedBox(width: 5),
              Text(
                label,
                style: TextStyle(
                  color: iconColor,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
