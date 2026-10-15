
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradebee1/stock_details.dart';
import 'Userhome.dart';
import 'login.dart';

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
  List<String> name_ = <String>[];
  List<String> a_ = <String>[];
  List<String> filteredNames = <String>[];
  List<String> filteredA = <String>[];
  List<bool> likedStatus = []; // ✅ Added list to track liked items
  bool isLoading = true;
  String searchQuery = '';

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final TextEditingController _searchController = TextEditingController();

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

    List<String> name = <String>[];
    List<String> a = <String>[];
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
        }
      }
      setState(() {
        name_ = name;
        a_ = a;
        filteredNames = name;
        filteredA = a;
        likedStatus = List<bool>.filled(name.length, false); // ✅ initialize
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

  void _filterStocks(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredNames = name_;
        filteredA = a_;
      } else {
        List<String> tempNames = [];
        List<String> tempA = [];
        for (int i = 0; i < name_.length; i++) {
          if (name_[i].toLowerCase().contains(query.toLowerCase())) {
            tempNames.add(name_[i]);
            tempA.add(a_[i]);
          }
        }
        filteredNames = tempNames;
        filteredA = tempA;
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
                                    builder: (context) => BankingDashboard(),
                                  ),
                                );
                              },
                              icon: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color(0xFF0D1117),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color:
                                    Color(0xFF1E88E5).withOpacity(0.3),
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
                                    color:
                                    Color(0xFF5C6BC0).withOpacity(0.4),
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
                                    'Stock Market',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  Text(
                                    '${filteredNames.length} stocks available',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF64B5F6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () => _fetchStocks(),
                              icon: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Color(0xFF0D1117),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color:
                                    Color(0xFF1E88E5).withOpacity(0.3),
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
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF0D1117),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Color(0xFF1E88E5).withOpacity(0.3),
                              width: 1.5,
                            ),
                          ),
                          child: TextField(
                            controller: _searchController,
                            onChanged: _filterStocks,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Search stocks...',
                              hintStyle: TextStyle(
                                color: Color(0xFF8B9DC3),
                                fontSize: 14,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Color(0xFF64B5F6),
                              ),
                              suffixIcon: searchQuery.isNotEmpty
                                  ? IconButton(
                                icon: Icon(
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
                              contentPadding: EdgeInsets.symmetric(
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
                          'Loading stocks...',
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
                                color: Color(0xFF1E88E5)
                                    .withOpacity(0.3),
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              Icons.search_off,
                              size: 50,
                              color: Color(0xFF64B5F6),
                            ),
                          ),
                          SizedBox(height: 24),
                          Text(
                            searchQuery.isEmpty
                                ? 'No Stocks Available'
                                : 'No Results Found',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            searchQuery.isEmpty
                                ? 'No stocks to display'
                                : 'Try a different search term',
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
                    onRefresh: _fetchStocks,
                    color: Color(0xFF1E88E5),
                    backgroundColor: Color(0xFF0D1117),
                    child: GridView.builder(
                      padding: EdgeInsets.all(20),
                      physics: AlwaysScrollableScrollPhysics(),
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: filteredNames.length,
                      itemBuilder: (context, index) {
                        return FadeTransition(
                          opacity: _fadeAnimation,
                          child:
                          _buildStockTile(context, index),
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

  Widget _buildStockTile(BuildContext context, int index) {
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
        decoration: BoxDecoration(
          color: Color(0xFF0D1117),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Color(0xFF1E88E5).withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF1E88E5).withOpacity(0.1),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
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
                    color: Color(0xFF1E88E5).withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                Icons.trending_up,
                size: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
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
                            msg: likedStatus[index]
                                ? "Removed from favorites"
                                : "Added to favorites");
                        setState(() {
                          likedStatus[index] =
                          !likedStatus[index]; // ✅ toggle only this one
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg: "Submission failed.");
                      }
                    } catch (e) {
                      Fluttertoast.showToast(msg: "Error: $e");
                    }
                  },
                  icon: Icon(
                    likedStatus[index]
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: likedStatus[index]
                        ? Colors.red
                        : Colors.grey,
                  ),
                ),
                Text(
                  filteredNames[index],
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Container(
              padding:
              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFF26A69A).withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'View',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF26A69A),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
