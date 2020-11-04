import 'package:flutter/material.dart';

class DetailPhoto extends StatelessWidget {
  final image;

  DetailPhoto({@required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(
              Icons.file_download,
              color: Colors.white,
            ),
            onPressed: null,
          ),
          IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context, 'delete')),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Hero(tag: image, child: Image.file(image)),
          ],
        ),
      ),
    );
  }
}