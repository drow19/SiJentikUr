import 'package:flutter/material.dart';
import 'package:flutterjumantik/src/resource.dart';
import 'package:flutterjumantik/view/auth/tab_item.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    color: mainGreen,
                    child: Stack(
                      children: [
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Image.asset('images/top.png')),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                child: Image.asset('images/logo.png'),
                              ),
                              Text(
                                'Sistem Informasi Jentik untuk daerah\n Urban dan Rural',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
              Expanded(flex: 3, child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: TabItem())),
            ],
          )
        ],
      ),
    );
  }
}
