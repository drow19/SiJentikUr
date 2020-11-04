import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterjumantik/src/resource.dart';
import 'package:flutterjumantik/view/home/headline_materi.dart';
import 'package:flutterjumantik/view/home/headline_news.dart';
import 'package:flutterjumantik/view/materi/materi_screen.dart';
import 'package:flutterjumantik/view/news/news_screen.dart';
import 'package:flutterjumantik/view/profile/profile_screen.dart';
import 'package:flutterjumantik/view/qr_screen.dart';
import 'package:flutterjumantik/view/report/report_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _menu = [
    {"id": 'pantau', 'icon': 'images/menu_pantau.png'},
    {"id": 'qr', 'icon': 'images/menu_qr.png'},
    {"id": 'laporan', 'icon': 'images/menu_laporan.png'},
    {"id": 'profile', 'icon': 'images/menu_akun.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f3f3),
      appBar: AppBar(
        backgroundColor: mainGreen,
        elevation: 0.0,
        title: Text(
          'SI JENTIK UR',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 80,
                width: double.infinity,
                color: mainGreen,
              ),
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 50),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Mengenal Jumantik',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MateriScreen()));
                              },
                              child: Text(
                                'Lihat Semua',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: mainGreen,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        HeadLineMateri(),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Berita Terkini',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NewsScreen()));
                              },
                              child: Text(
                                'Lihat Semua',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: mainGreen,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        HeadLineNews()
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: 30,
            left: 15,
            right: 15,
            child: Container(
              height: 80,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              child: ListView.builder(
                  itemCount: _menu.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        print(_menu[index]['id']);
                        if (_menu[index]['id'] == 'pantau') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReportScreen()));
                        } else if (_menu[index]['id'] == 'qr') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QrScreen()));
                        } else if (_menu[index]['id'] == 'profile') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileScreen()));
                        }
                      },
                      child: Container(
                        height: 90,
                        width: 95,
                        child: Image.asset(_menu[index]['icon']),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
