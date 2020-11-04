import 'package:flutter/material.dart';
import 'package:flutterjumantik/model/materi_model.dart';
import 'package:flutterjumantik/repository/materi_repository.dart';
import 'package:flutterjumantik/src/resource.dart';
import 'package:flutterjumantik/view/materi/detail_screen.dart';

class MateriScreen extends StatefulWidget {
  @override
  _MateriScreenState createState() => _MateriScreenState();
}

class _MateriScreenState extends State<MateriScreen> {
  List<MateriModel> _list = new List<MateriModel>();
  ScrollController _scrollController = ScrollController();

  List<String> _images = [
    'images/rnd_0.png',
    'images/rnd_1.png',
    'images/rnd_2.png',
    'images/rnd_4.png'
  ];

  int page = 1;
  bool _isLoading = false;
  bool hasReachMax = false;

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
    await MateriRepository().getData('$page').then((value) {
      setState(() {
        if (hasReachMax == true) {
          List<MateriModel> newList = value;
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
              child: GridView.builder(
                  controller: _scrollController,
                  itemCount: _list.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1,
                      childAspectRatio: 1,
                      crossAxisSpacing: 2),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailMateri(
                                      materiModel: _list[index],
                                      image: _images[index],
                                    )));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Colors.transparent),
                              child: Hero(
                                tag: _images[index],
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.asset(
                                    _images[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 200,
                              width: 200,
                              alignment: Alignment.center,
                              child: Text(
                                '${_list[index].title}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    fontSize: 14),
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
