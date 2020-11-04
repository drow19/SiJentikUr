import 'package:flutter/material.dart';
import 'package:flutterjumantik/model/materi_model.dart';
import 'package:flutterjumantik/src/resource.dart';

class DetailMateri extends StatelessWidget {
  final MateriModel materiModel;
  final String image;

  DetailMateri({@required this.materiModel, @required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainGreen,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: image,
                    child: Container(
                      height: 80,
                      width: 80,
                      child: Image.asset(image),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      '${materiModel.title}',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '${materiModel.date}',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '${materiModel.desc}',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15.0,
                    color: Colors.black,
                    height: 1.3),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
