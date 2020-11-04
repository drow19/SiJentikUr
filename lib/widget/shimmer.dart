import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: ListView.builder(
          itemCount: 4,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              height: 80,
              width: 80,
              color: Colors.white,
              margin: EdgeInsets.symmetric(horizontal: 8),
            );
          },
        ),
      ),
    );
  }
}

class ShimmerLoadingVertical  extends StatelessWidget {
  final int count;
  ShimmerLoadingVertical({@required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
      child: ListView.builder(
          itemCount: count,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index){
            return Container(
              margin: EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      mainAxisAlignment:
                      MainAxisAlignment
                          .spaceEvenly,
                      children: [
                        Container(
                          width:200,
                          height: 20,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Container(
                          width: 150,
                          height: 20,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Container(
                          width: 100,
                          height: 20,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          }),),
    );
  }
}

