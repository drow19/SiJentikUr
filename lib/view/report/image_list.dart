import 'package:flutter/material.dart';
import 'package:flutterjumantik/view/report/detail_photo.dart';

class BuildListImage extends StatefulWidget {
  final List list;

  BuildListImage({@required this.list});

  @override
  _BuildListImageState createState() => _BuildListImageState();
}

class _BuildListImageState extends State<BuildListImage> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 150,
        child: ListView.builder(
            itemCount: widget.list.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailPhoto(image: widget.list[index]),
                    ),
                  ).then((value) {
                    setState(() {
                      if (value == 'delete') {
                        widget.list.removeAt(index);
                      }
                    });
                  });
                },
                child: Hero(
                  tag: widget.list[index],
                  child: Container(
                    height: 100,
                    width: 110,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
                    child: Image.file(
                      widget.list[index],
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
