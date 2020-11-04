import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterjumantik/helper/shared_helper.dart';
import 'package:flutterjumantik/helper/validator.dart';
import 'package:flutterjumantik/model/user_model.dart';
import 'package:flutterjumantik/repository/login_repository.dart';
import 'package:flutterjumantik/src/resource.dart';
import 'file:///C:/Users/Drow/AndroidStudioProjects/flutter_jumantik/lib/view/home/home_screen.dart';
import 'package:flutterjumantik/widget/widget.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  login() async {
    if (formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      await LoginRepository()
          .getData(_emailController.text, _passwordController.text)
          .then((value) {
        var json = jsonDecode(value);
        if (json['success'] == '1') {
          print(json['data']);
          var data = json['data'];
          UserModel.fromJson(data);
          SharedHelper.setUserId(data['id']);
          SharedHelper.setUserName(data['nama']);
          SharedHelper.setUserEmail(data['email']);
          SharedHelper.setUserLogin(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          setState(() {
            _isLoading = false;
          });
          _snackbar(json['message']);
        }
      }).catchError((e) {
        setState(() {
          _isLoading = false;
        });
        _snackbar('Connection problem...');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Stack(
        children: [
          Column(
            children: [
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => emailValidator(value),
                        style: textFieldStyle(context),
                        decoration: textFieldDecoration('Email'),
                        maxLines: 1,
                        minLines: 1,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        validator: (value) => passwordValidator(value),
                        style: textFieldStyle(context),
                        decoration: textFieldDecoration('Password'),
                        obscureText: true,
                        maxLines: 1,
                        minLines: 1,
                      ),
                    ],
                  )),
              SizedBox(
                height: 26,
              ),
              InkWell(
                onTap: login,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: mainOrange,
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    'LOGIN',
                    style: GoogleFonts.roboto(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              )
            ],
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container()
        ],
      ),
    );
  }

  void _snackbar(String message) {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(message),
      duration: Duration(seconds: 2),
    ));
  }
}
