import 'package:flutter/material.dart';
import 'package:flutterjumantik/helper/shared_helper.dart';
import 'package:flutterjumantik/view/auth/login.dart';
import 'file:///C:/Users/Drow/AndroidStudioProjects/flutter_jumantik/lib/view/home/home_screen.dart';

class AuthService extends StatefulWidget {
  @override
  _AuthServiceState createState() => _AuthServiceState();
}

class _AuthServiceState extends State<AuthService> {
  bool _isLogin;

  getAuth() async {
    await SharedHelper.getUserLogin().then((value) {
      setState(() {
        _isLogin = value;
      });
    });
  }

  @override
  void initState() {
    getAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLogin != null) {
      if (_isLogin == true) {
        return HomeScreen();
      } else {
        return LoginScreen();
      }
    } else {
      _isLogin = false;
      return LoginScreen();
    }
  }
}
