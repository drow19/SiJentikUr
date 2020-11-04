import 'package:flutter/material.dart';
import 'package:flutterjumantik/src/resource.dart';
import 'package:flutterjumantik/view/auth/login_form.dart';
import 'package:flutterjumantik/view/auth/register_form.dart';
import 'package:google_fonts/google_fonts.dart';

class TabItem extends StatefulWidget {
  @override
  _TabItemState createState() => _TabItemState();
}

class _TabItemState extends State<TabItem> {
  List<String> _tabItem = ['LOGIN', 'REGISTER'];

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: ListView.builder(
                itemCount: _tabItem.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedTab = index;
                      });
                    },
                    child: Container(
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      '${_tabItem[index]}',
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: selectedTab == index
                                              ? mainGreen
                                              : darkGrey),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 5),
                                    height: 2,
                                    width: 200,
                                    color: selectedTab == index
                                        ? mainGreen
                                        : Colors.transparent,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 8,
          ),
          selectedTab == 0 ? LoginForm() : RegisterForm()
        ],
      ),
    );
  }
}
