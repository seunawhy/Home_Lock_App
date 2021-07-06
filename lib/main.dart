import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:project_finals/services/service_locator.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:local_auth/local_auth.dart';
import 'BlueScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HomeLock',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home:  FingerPage()
    );
  }
}

class FingerPage extends StatefulWidget {
  @override
  _FingerPageState createState() => _FingerPageState();
}

class _FingerPageState extends State<FingerPage> {
  final LocalAuthentication localAuth = LocalAuthentication();
  bool _canCheckBiometric = false;

  String _authorizeText = "DEPARTMENT OF COMPUTER ENGINEERING \n"
            "FACULTY OF ENGINEERING AND TECHNOLOGY \n"
            "UNIVERSITY OF ILORIN.";

  List<BiometricType> availableBiometrics = List<BiometricType>();

  Future<void> _authorize() async {
    bool _isAuthorized = false;
    try {
      _isAuthorized = await localAuth.authenticateWithBiometrics(
        localizedReason: 'Please authenticate to verify identity',
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      if (_isAuthorized) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BlueScreen()),
        );
      } else {
        _authorizeText = "DEPARTMENT OF COMPUTER ENGINEERING \n"
            "FACULTY OF ENGINEERING AND TECHNOLOGY \n"
            "UNIVERSITY OF ILORIN.";
        
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text('HomeLock App'), backgroundColor: Colors.lightBlueAccent),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
         Container(
           width:120,
           height: 120,
           child: Image.asset('assets/images/unilorin.jpg'),
             ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _authorizeText,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize:16,shadows:List(6)),
            ),
          ),
          RaisedButton(
            child: Text(
              'Welcome',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            color: Colors.blue[700],
            onPressed: _authorize,
          ),
         
        ],
      )),
    );
  }
}
