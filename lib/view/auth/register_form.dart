import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterjumantik/helper/validator.dart';
import 'package:flutterjumantik/repository/register_repository.dart';
import 'package:flutterjumantik/src/resource.dart';
import 'package:flutterjumantik/widget/widget.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmationPasswordController =
      new TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  register() async {
    if (formKey.currentState.validate()) {
      if (_passwordController.text == _confirmationPasswordController.text) {
        setState(() {
          _isLoading = true;
        });
        await RegisterRepository()
            .postData(_userNameController.text, _emailController.text,
                _passwordController.text, _confirmationPasswordController.text)
            .then((value) {
          var json = jsonDecode(value);
          if (json['success'] == '1') {
            var data = json['data'];
            /*UserModel.fromJson(data);
              SharedHelper.setUserId(data['id']);
              SharedHelper.setUserName(data['nama']);
              SharedHelper.setUserEmail(data['email']);*/
            _snackbar(json['message']);
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
                        controller: _userNameController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => userNameValidator(value),
                        style: textFieldStyle(context),
                        decoration: textFieldDecorationUsername('Username'),
                        maxLines: 1,
                        minLines: 1,
                      ),
                      SizedBox(
                        height: 16,
                      ),
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
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _confirmationPasswordController,
                        keyboardType: TextInputType.text,
                        validator: (value) => passwordValidator(value),
                        style: textFieldStyle(context),
                        decoration:
                            textFieldDecoration('Confirmation Password'),
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
                onTap: register,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: mainOrange,
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(
                    'REGISTER',
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

  Widget _snackbar(String message) {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(message),
      duration: Duration(seconds: 2),
    ));
  }
}
