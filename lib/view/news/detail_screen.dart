import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterjumantik/model/news_model.dart';
import 'package:flutterjumantik/repository/detail_news_repository.dart';
import 'package:flutterjumantik/src/resource.dart';

class DetailNews extends StatefulWidget {
  final id;

  DetailNews({@required this.id});

  @override
  _DetailNewsState createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {
  NewsModel _newsModel;

  bool _isLoading = false;

  getData() async {
    _isLoading = true;
    await DetailNewsRepository().getData('${widget.id}').then((value) {
      setState(() {
        _isLoading = false;
        _newsModel = value;
      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
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
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '${_newsModel.title}',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${_newsModel.date}',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Hero(
                      tag: _newsModel.cover,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: CachedNetworkImage(imageUrl: _newsModel.cover)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(_newsModel.content),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
