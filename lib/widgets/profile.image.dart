import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileImg extends StatelessWidget {
  String url;
  double ratio;

  ProfileImg({this.url, this.ratio});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * ratio,
      height: MediaQuery.of(context).size.width * ratio,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: CachedNetworkImageProvider(url), fit: BoxFit.cover),
          shape: BoxShape.circle,
          border: new Border.all(color: Colors.grey)),
    );
  }
}
