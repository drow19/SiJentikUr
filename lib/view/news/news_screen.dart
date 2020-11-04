import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterjumantik/model/news_model.dart';
import 'package:flutterjumantik/repository/news_repository.dart';
import 'package:flutterjumantik/src/resource.dart';
import 'package:flutterjumantik/view/news/detail_screen.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  ScrollController _scrollController = ScrollController();
  List<NewsModel> _list = new List<NewsModel>();

  bool _isLoading = false;
  bool hasReachMax = false;
  int page = 1;

  scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        hasReachMax = true;
        page++;
        print("print : $page");
      });
      getData();
    }
  }

  getData() async {
    if (hasReachMax == false) {
      setState(() {
        _isLoading = true;
      });
    }
    await NewsRepository().getData(page).then((value) {
      setState(() {
        if (hasReachMax == true) {
          List<NewsModel> newList = value;
          _list = [..._list, ...newList];
        } else {
          _isLoading = false;
          _list = value;
        }
      });
    }).catchError((e) {
      _isLoading = false;
      print(e.toString());
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
    _scrollController.addListener(scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainGreen,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: ListView.separated(
                  controller: _scrollController,
                  itemCount: _list.length,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => Divider(
                        thickness: 2,
                      ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailNews(id: _list[index].id),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${_list[index].title}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      '${_list[index].date}',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Hero(
                                tag: _list[index].cover,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: CachedNetworkImage(
                                      imageUrl: _list[index].cover),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
    );
  }
}
