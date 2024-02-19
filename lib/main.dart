import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Internet Connectivity',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InternetConnectivityPage(),
    );
  }
}

class InternetConnectivityPage extends StatefulWidget {
  @override
  _InternetConnectivityPageState createState() =>
      _InternetConnectivityPageState();
}

class _InternetConnectivityPageState extends State<InternetConnectivityPage> {
  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        showToast("No internet connection");
      } else if (result == ConnectivityResult.mobile) {
        showToast("Connected to mobile network");
      } else if (result == ConnectivityResult.wifi) {
        showToast("Connected to WiFi network");
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Internet Connectivity'),
      ),
      body: Center(
        child: Text(
          'Check internet connectivity',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
