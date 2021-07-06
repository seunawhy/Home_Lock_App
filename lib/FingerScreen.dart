//import 'dart:async';
//import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
//import 'package:flutter_bluetooth/services/service_locator.dart';
//import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
//import 'HomeScreen.dart';
import 'BlueScreen.dart';

class FingerScreen extends StatefulWidget {
  @override
  _FingerScreenState createState() => _FingerScreenState();
}

class _FingerScreenState extends State<FingerScreen> {
  final LocalAuthentication localAuth = LocalAuthentication();
  bool _canCheckBiometric = false;

  //String _authorizeText = 'Not Authorized!';

  List<BiometricType> availableBiometrics = List<BiometricType>();

  get isAuthenticated => true;

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

    isAuthenticated ? print('Access Granted!') : print('Access Denied!');

    if (isAuthenticated) {
      {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BlueScreen()),
        );
      }
    }
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
  return MaterialApp(
      debugShowCheckedModeBanner: false,
    );
  }
}
