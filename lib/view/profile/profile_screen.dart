import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutterjumantik/helper/shared_helper.dart';
import 'package:flutterjumantik/model/region_model.dart';
import 'package:flutterjumantik/repository/profile/edit_profile.dart';
import 'package:flutterjumantik/repository/profile/region.dart';
import 'package:flutterjumantik/src/resource.dart';
import 'package:flutterjumantik/src/type_head_services.dart';
import 'package:flutterjumantik/widget/widget.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  GlobalKey<ScaffoldState> _scaffold = new GlobalKey<ScaffoldState>();
  List<Provinsi> _provinsi = new List<Provinsi>();
  List<Kota> _kota = new List<Kota>();
  List<Kecamatan> _kecamatan = new List<Kecamatan>();
  List<Kelurahan> _kelurahan = new List<Kelurahan>();
  int idUser;
  var username;
  var email;
  var provinsi;
  var kota;
  var kecamatan;
  var kelurahan;
  var alamat;
  var rt;
  var rw;
  List<String> _listProvinsi = new List();
  List<String> _listKota = new List();
  List<String> _listKecamatan = new List();
  List<String> _listKelurahan = new List();

  var idProvinsi;
  var idKota;
  var idKecamatan;

  bool _isloading = false;

  getSharedPref() async {
    idUser = await SharedHelper.getUserId();
    username = await SharedHelper.getUserName();
    email = await SharedHelper.getUserEmail();

    print("print : $idUser, $username, $email");
  }

  getProvinsi() async {
    _isloading = true;
    await ProvinsiRepository().getData().then((value) {
      setState(() {
        _isloading = false;
        getSharedPref();
        _provinsi = value;
        for (int i = 0; i < _provinsi.length; i++) {
          setState(() {
            _listProvinsi.add(_provinsi[i].name);
          });
        }
      });
    }).catchError((e) {
      _isloading = false;
      print(e.toString());
    });
  }

  getKota() async {
    await KotaRepository().getData('$idProvinsi').then((value) {
      setState(() {
        _kota = value;
        for (int i = 0; i < _kota.length; i++) {
          _listKota.add(_kota[i].name);
        }
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  getKecamatan() async {
    await KecamatanRepository().getData('$idKota').then((value) {
      setState(() {
        _kecamatan = value;
        for (int i = 0; i < _kecamatan.length; i++) {
          _listKecamatan.add(_kecamatan[i].name);
        }
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  getKelurahan() async {
    await KelurahanRepository().getData('$idKecamatan').then((value) {
      setState(() {
        _kelurahan = value;
        for (int i = 0; i < _kelurahan.length; i++) {
          _listKelurahan.add(_kelurahan[i].name);
        }
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  postData() async{
    loadingDialog(context);
    PostDataProfile()
        .postData('$idUser', email, provinsi, kota, kecamatan,
        kelurahan, alamat, rt, rw)
        .then((value) {
          Navigator.pop(context, false);
      var json = jsonDecode(value);
      _scaffold.currentState.showSnackBar(snackBar(json['message']));
      print(value);
    }).catchError((e) {
      print(e.toString());
    });
  }

  @override
  void initState() {
    getProvinsi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: _buildUsername(),
          ),
          _buildForm(),
        ],
      ),
    );
  }

  Widget _buildUsername() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              height: 80,
              width: 80,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Colors.black54, Color.fromRGBO(0, 41, 102, 1)]),
                ),
                child: Text(
                  username != null ? '${username[0]}'.toUpperCase() : '',
                  style: GoogleFonts.roboto(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              )),
          SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username != null
                    ? '$username'.replaceFirst(
                        username[0],
                        username[0].toString().toUpperCase(),
                      )
                    : '',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500, color: black, fontSize: 16.0),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                email == null ? '' : '$email' ?? '',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  color: lightGrey,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          /* gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.black54, Color.fromRGBO(0, 41, 102, 1)]),*/
        ),
        child: ListView(
          children: [
            Column(
              children: [
                InkWell(
                  onTap: () => dialogProvinsi(),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                    child: Container(
                      height: 60,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            provinsi != null ? '$provinsi' : 'Provinsi',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border:
                              Border.all(width: 1.0, color: Colors.black)),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (idProvinsi != null) {
                      dialogKota();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                    child: Container(
                      height: 60,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            kota != null ? '$kota' : 'Kabupaten/Kota',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border:
                              Border.all(width: 1.0, color: Colors.black)),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (idKota != null) {
                      dialogKecamatan();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                    child: Container(
                      height: 60,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            kecamatan != null ? '$kecamatan' : 'Kecamatan',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border:
                              Border.all(width: 1.0, color: Colors.black)),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (idKecamatan != null) {
                      dialogKelurahan();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                    child: Container(
                      height: 60,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            kelurahan != null ? '$kelurahan' : 'Kelurahan',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border:
                              Border.all(width: 1.0, color: Colors.black)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: dialogAlamat,
                        child: Container(
                          width: 250,
                          height: 60,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                alamat != null ? '$alamat' : 'Alamat',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  width: 1.0, color: Colors.black)),
                        ),
                      ),
                      InkWell(
                        onTap: () => dialogRtRw('RT'),
                        child: Container(
                          width: 50,
                          height: 50,
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                rt != null ? '$rt' : 'RT',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              border: Border.all(
                                  width: 1.0, color: Colors.black)),
                        ),
                      ),
                      InkWell(
                        onTap: () => dialogRtRw('RW'),
                        child: Container(
                          width: 50,
                          height: 50,
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                rw != null ? '$rw' : 'RW',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              border: Border.all(
                                  width: 1.0, color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 22,),
            InkWell(
              onTap: postData,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 50,
                  width: 200,
                  child: Align(
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void dialogProvinsi() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: new Text("Pilih Provinsi"),
          content: SingleChildScrollView(
            child: Container(
              height: 100,
              child: TypeAheadField(
                getImmediateSuggestions: false,
                textFieldConfiguration: TextFieldConfiguration(
                  autofocus: false,
                  decoration: InputDecoration(
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintStyle: GoogleFonts.roboto(color: Colors.black),
                      hintText: 'Provinsi'),
                ),
                suggestionsCallback: (pattern) async {
                  return CitiesService.getSuggestions(pattern, _listProvinsi);
                },
                itemBuilder: (context, suggestion) {
                  return SingleChildScrollView(
                      child: ListTile(
                    title: Text(suggestion),
                  ));
                },
                onSuggestionSelected: (suggestion) {
                  for (int i = 0; i < _provinsi.length; i++) {
                    if (_provinsi[i].name == suggestion) {
                      idProvinsi = _provinsi[i].id;
                      kota = null;
                      kecamatan = null;
                      kelurahan = null;
                    }
                  }
                  setState(() {
                    provinsi = suggestion;
                    getKota();
                  });
                  Navigator.pop(context, false);
                },
                noItemsFoundBuilder: (suggestion) {
                  return ListTile(
                    title: Text(
                      'Data tidak ditemukan',
                      style: GoogleFonts.roboto(),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void dialogKota() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: new Text("Pilih Provinsi"),
          content: SingleChildScrollView(
            child: Container(
              height: 100,
              child: TypeAheadField(
                getImmediateSuggestions: false,
                textFieldConfiguration: TextFieldConfiguration(
                  autofocus: false,
                  decoration: InputDecoration(
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintStyle: GoogleFonts.roboto(color: Colors.black),
                      hintText: 'Kota'),
                ),
                suggestionsCallback: (pattern) async {
                  return CitiesService.getSuggestions(pattern, _listKota);
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  for (int i = 0; i < _kota.length; i++) {
                    if (_kota[i].name == suggestion) {
                      idKota = _kota[i].id;
                      kecamatan = null;
                      kelurahan = null;
                    }
                  }
                  setState(() {
                    kota = suggestion;
                    getKecamatan();
                  });
                  Navigator.pop(context, false);
                },
                noItemsFoundBuilder: (suggestion) {
                  return ListTile(
                    title: Text(
                      'Data tidak ditemukan',
                      style: GoogleFonts.roboto(),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void dialogKecamatan() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: new Text("Pilih Provinsi"),
          content: SingleChildScrollView(
            child: Container(
              height: 100,
              child: TypeAheadField(
                getImmediateSuggestions: false,
                textFieldConfiguration: TextFieldConfiguration(
                  autofocus: false,
                  decoration: InputDecoration(
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintStyle: GoogleFonts.roboto(color: Colors.black),
                      hintText: 'Kecamatan'),
                ),
                suggestionsCallback: (pattern) async {
                  return CitiesService.getSuggestions(pattern, _listKecamatan);
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  for (int i = 0; i < _kecamatan.length; i++) {
                    if (_kecamatan[i].name == suggestion) {
                      idKecamatan = _kecamatan[i].id;
                      kelurahan = null;
                    }
                  }
                  setState(() {
                    kecamatan = suggestion;
                    getKelurahan();
                  });

                  Navigator.pop(context, false);
                },
                noItemsFoundBuilder: (suggestion) {
                  return ListTile(
                    title: Text(
                      'Data tidak ditemukan',
                      style: GoogleFonts.roboto(),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void dialogKelurahan() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: new Text("Pilih Provinsi"),
          content: SingleChildScrollView(
            child: Container(
              height: 100,
              child: TypeAheadField(
                getImmediateSuggestions: false,
                textFieldConfiguration: TextFieldConfiguration(
                  autofocus: false,
                  decoration: InputDecoration(
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintStyle: GoogleFonts.roboto(color: Colors.black),
                      hintText: 'Kelurahan'),
                ),
                suggestionsCallback: (pattern) async {
                  return CitiesService.getSuggestions(pattern, _listKelurahan);
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  setState(() {
                    kelurahan = suggestion;
                  });
                  Navigator.pop(context, false);
                },
                noItemsFoundBuilder: (suggestion) {
                  return ListTile(
                    title: Text(
                      'Data tidak ditemukan',
                      style: GoogleFonts.roboto(),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void dialogAlamat() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: new Text("Isi Alamat"),
          content: SingleChildScrollView(
            child: Container(
              height: 100,
              child: TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintStyle: GoogleFonts.roboto(color: Colors.black),
                    hintText: 'Alamat'),
                inputFormatters: [
                  new LengthLimitingTextInputFormatter(50),
                ],
                onChanged: (value) {
                  setState(() {
                    alamat = value;
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void dialogRtRw(String hint) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: new Text("Isi $hint"),
          content: SingleChildScrollView(
            child: Container(
              height: 100,
              child: TextFormField(
                autofocus: false,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintStyle: GoogleFonts.roboto(color: Colors.black),
                    hintText: '$hint'),
                inputFormatters: [
                  new LengthLimitingTextInputFormatter(2),
                ],
                onChanged: (value) {
                  setState(() {
                    if (hint == 'RT') {
                      rt = value;
                    } else {
                      rw = value;
                    }
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
