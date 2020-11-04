import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterjumantik/model/news_model.dart';
import 'package:flutterjumantik/repository/headline_repository.dart';
import 'package:flutterjumantik/view/news/detail_screen.dart';
import 'package:flutterjumantik/widget/shimmer.dart';

class HeadLineNews extends StatefulWidget {
  @override
  _HeadLineNewsState createState() => _HeadLineNewsState();
}

class _HeadLineNewsState extends State<HeadLineNews> {
  List<NewsModel> _list = new List<NewsModel>();
  bool _isLoading = false;

  getData() async {
    _isLoading = true;
    await HeadlineRepository().getData().then((value) {
      setState(() {
        _isLoading = false;
        _list = value;
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
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? ShimmerLoadingVertical(count: 3,)
        : Container(
            child: ListView.builder(
                itemCount: _list.length = 3,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailNews(id: _list[index].id)));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 6),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  '${_list[index].title}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 14.0),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  '${_list[index].date}',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ],
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
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
  }
}
