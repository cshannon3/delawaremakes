
import 'package:flutter/material.dart';

class RoundedImageAsset extends StatelessWidget {
  final String url;

  const RoundedImageAsset({Key key, @required this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child:Image.asset(url, fit: BoxFit.cover, alignment: Alignment.center,) ,
              )
    );
  }
}