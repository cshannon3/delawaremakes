
import 'package:flutter/material.dart';

class FormTitle extends StatelessWidget {
  final String title;
  final bool underline;

  const FormTitle({Key key, this.title, this.underline=false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: double.infinity,
          child: Text(
            title,
            style: TextStyle(
                fontSize: 20.0,
                decoration:
                    underline ? TextDecoration.underline : TextDecoration.none),
            textAlign: TextAlign.center,
          )),
    );
  }
}


