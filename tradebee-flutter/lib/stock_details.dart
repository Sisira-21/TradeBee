import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradebee1/viewstock.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(207, 97, 161, 156)),
        useMaterial3: true,
      ),
      home: const ViewStockDetails(title: 'Stock Details'),
    );
  }
}

class ViewStockDetails extends StatefulWidget {
  const ViewStockDetails({super.key, required this.title});
  final String title;

  @override
  State<ViewStockDetails> createState() => _ViewStockDetailsState();
}

class _ViewStockDetailsState extends State<ViewStockDetails> with SingleTickerProviderStateMixin {
  List<String> date_ = [];
  List<double> open_ = [];
  List<double> high_ = [];
  List<double> low_ = [];
  List<double> close_ = [];
  List<double> volume_ = [];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _fetchStockDetails();
    // _fetchProfileData();
  }



  Future<void> _fetchStockDetails() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url') ?? '';
      String nm = sh.getString('name') ?? '';
      String url = '$urls/stock_detail/';

      var data = await http.post(Uri.parse(url), body: {'name': nm});
      var jsondata = json.decode(data.body);

      if (jsondata['status'] == 'ok') {
        var arr = jsondata["data"];

        setState(() {
          date_ = arr.map<String>((e) => e['date'].toString()).toList();
          open_ = arr.map<double>((e) => double.tryParse(e['open'].toString()) ?? 0).toList();
          high_ = arr.map<double>((e) => double.tryParse(e['high'].toString()) ?? 0).toList();
          low_ = arr.map<double>((e) => double.tryParse(e['low'].toString()) ?? 0).toList();
          close_ = arr.map<double>((e) => double.tryParse(e['close'].toString()) ?? 0).toList();
          volume_ = arr.map<double>((e) => double.tryParse(e['volume'].toString()) ?? 0).toList();
        });
      } else {
        Fluttertoast.showToast(msg: "Failed to fetch data");
      }
    } catch (e) {
      print("Error ------------------- $e");
      Fluttertoast.showToast(msg: "Error fetching stock details");
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<charts.Series<TimeSeriesStock, DateTime>> _createSeries(List<double> values) {
    final data = <TimeSeriesStock>[];
    for (int i = 0; i < date_.length; i++) {
      final dt = DateTime.tryParse(date_[i]) ?? DateTime.now();
      data.add(TimeSeriesStock(dt, values[i]));
    }

    return [
      charts.Series<TimeSeriesStock, DateTime>(
        id: 'Stock',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesStock stock, _) => stock.time,
        measureFn: (TimeSeriesStock stock, _) => stock.value,
        data: data,
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => StockListPage(title: 'Stocks')),
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:  Color.fromARGB(255, 232, 177, 61),
          title: Text(widget.title),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: const [
              Tab(text: 'Open'),
              Tab(text: 'High'),
              Tab(text: 'Low'),
              Tab(text: 'Close'),
              Tab(text: 'Volume'),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: date_.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
          controller: _tabController,
          children: [
            charts.TimeSeriesChart(_createSeries(open_), animate: true),
            charts.TimeSeriesChart(_createSeries(high_), animate: true),
            charts.TimeSeriesChart(_createSeries(low_), animate: true),
            charts.TimeSeriesChart(_createSeries(close_), animate: true),
            charts.TimeSeriesChart(_createSeries(volume_), animate: true),
          ],
        ),
      ),
    );
  }
}

class TimeSeriesStock {
  final DateTime time;
  final double value;

  TimeSeriesStock(this.time, this.value);
}
