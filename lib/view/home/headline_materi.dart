import 'package:flutter/material.dart';
import 'package:flutterjumantik/model/materi_model.dart';
import 'package:flutterjumantik/repository/materi_repository.dart';
import 'package:flutterjumantik/view/materi/detail_screen.dart';
import 'package:flutterjumantik/widget/shimmer.dart';

class HeadLineMateri extends StatefulWidget {
  @override
  _HeadLineMateriState createState() => _HeadLineMateriState();
}

class _HeadLineMateriState extends State<HeadLineMateri> {
  List<MateriModel> _list = new List<MateriModel>();
  List<String> _images = [
    'images/rnd_0.png',
    'images/rnd_1.png',
    'images/rnd_2.png',
    'images/rnd_4.png'
  ];

  bool _isLoading = false;

  getData() async {
    _isLoading = true;
    await MateriRepository().getData('1').then((value) {
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
        ? ShimmerLoading()
        : Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            height: 80,
            child: GridView.builder(
                itemCount: _list.length = 4,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 0,
                    childAspectRatio: 0.85,
                    mainAxisSpacing: 3),
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailMateri(
                                  materiModel: _list[index],
                                  image: _images[index])));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Container(
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
                            padding: EdgeInsets.fromLTRB(8, 14, 8, 0),
                            alignment: Alignment.centerLeft,
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
          );
  }
}
