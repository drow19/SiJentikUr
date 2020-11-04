import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterjumantik/repository/report_repository.dart';
import 'package:flutterjumantik/src/resource.dart';
import 'package:flutterjumantik/view/report/detail_photo.dart';
import 'package:flutterjumantik/view/report/finish_report.dart';
import 'package:flutterjumantik/view/report/image_list.dart';
import 'package:flutterjumantik/widget/widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  TextEditingController _desc = new TextEditingController();
  GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();
  File _image;
  final picker = ImagePicker();

  List<File> _list = new List<File>();
  List<String> selectedChoices = List();

  int _radioValue = 0;
  bool _isSelected = false;
  int selectedIndex;

  List<String> _type = [
    'Bak Mandi',
    'Tempayan',
    'Ember',
    'Dispenser',
    'Kolam/Aquarium',
    'Ban Bekas',
    'Kaleng/Botol Bekas',
    'Pot/Vas Bunga',
    'Kolam',
    'Lain-lain'
  ];

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          print(_radioValue);
          break;
        case 1:
          print(_radioValue);
          break;
        case 2:
          break;
      }
    });
  }

  Future getImage() async {
    final pickerImage = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickerImage != null) {
        _image = File(pickerImage.path);
        _list.add(_image);
      } else {
        print('no image selected');
      }
    });
  }

  postData() async {
    loadingDialog(context);
    FocusScope.of(context).requestFocus(new FocusNode());
    await ReportRepository()
        .postData('$_radioValue', _desc.text, selectedChoices, _list)
        .then((value) {
      setState(() {
        Navigator.pop(context, false);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => FinishScreen()));
      });
    }).catchError((e) {
      setState(() {
        Navigator.pop(context, false);
        print('error $e');
        _scaffold.currentState.showSnackBar(snackBar('Connection Problem...'));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        print(selectedChoices);
        if (_list.length != 0) {
          return backDialog(context);
        } else {
          Navigator.pop(context);
        }
      },
      child: new Scaffold(
        key: _scaffold,
        appBar: AppBar(
          backgroundColor: mainGreen,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Upload foto kondisi di sekitar Anda',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 14.0),
                ),
                SizedBox(
                  height: 10,
                ),
                _list.length == 0
                    ? Center(child: _getImageButton())
                    : Row(
                        children: [
                          _list.length < 3 ? _getImageButton() : Container(),
                          BuildListImage(list: _list)
                        ],
                      ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Kondisi TPA di sekitar Anda',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 14.0),
                ),
                _buildRadioButton(),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Jenis',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 14.0),
                ),
                _buildListChips(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Catatan(Opsional)',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 14.0),
                ),
                _description(),
                SizedBox(
                  height: 16,
                ),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  /*TAKING PICTURE FROM CAMERA*/
  Widget _getImageButton() {
    return InkWell(
      onTap: getImage,
      child: Container(
        height: 130,
        width: 100,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: Icon(
          Icons.camera_alt,
          color: Colors.blue,
          size: 30,
        ),
      ),
    );
  }

  /*RADIO BUTTON*/
  Widget _buildRadioButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 40,
          child: Row(
            children: [
              new Radio(
                  value: 0,
                  groupValue: _radioValue,
                  onChanged: _handleRadioValueChange),
              Text(
                'Ada Jentik',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 14.0),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
          child: Row(
            children: [
              new Radio(
                  value: 1,
                  groupValue: _radioValue,
                  onChanged: _handleRadioValueChange),
              Text(
                'Tidak ada Jentik',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 14.0),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /*BUILD LIST OF CHIPS*/
  Widget _buildListChips() {
    return Wrap(
      alignment: WrapAlignment.start,
      children: List<Widget>.generate(_type.length, (index) {
        return Container(
          child: FilterChip(
            label: Text('${_type[index]}'),
            labelStyle: TextStyle(
                color: _isSelected ? Colors.white : Colors.black,
                fontSize: 12.0),
            selected: selectedChoices.contains(_type[index]),
            selectedColor: mainGreen,
            checkmarkColor: Colors.white,
            onSelected: (bool selected) {
              setState(() {
                selectedChoices.contains(_type[index])
                    ? selectedChoices.remove(_type[index])
                    : selectedChoices.add(_type[index]);
              });
              print(selectedChoices);
            },
          ),
        );
      }),
    );
  }

  /*TEXT AREA FOR DESCRIPTION*/
  Widget _description() {
    return Container(
      margin: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border(
            top: BorderSide(color: Colors.black),
            bottom: BorderSide(color: Colors.black),
            left: BorderSide(color: Colors.black),
            right: BorderSide(color: Colors.black),
          )),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            controller: _desc,
            maxLines: 8,
            decoration: InputDecoration.collapsed(
              hintText: "Enter your text here",
            ),
          ),
        ),
      ),
    );
  }

  /*BUTTON FOR SUBMIT*/
  Widget _buttonSubmit() {
    return InkWell(
      onTap: () {
        if (_list.length != 0) {
          postData();
        } else {
          _scaffold.currentState.showSnackBar(SnackBar(
            content: Text(
              'Image cant be empty..',
              style: GoogleFonts.roboto(color: Colors.white),
            ),
            duration: const Duration(seconds: 3),
          ));
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        margin: EdgeInsets.only(bottom: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: mainOrange, borderRadius: BorderRadius.circular(6)),
        child: Text(
          'LAPORKAN',
          style: GoogleFonts.roboto(
              fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
