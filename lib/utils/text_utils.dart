

import 'package:delaware_makes/utils/dynamic_parser.dart';
import 'package:delaware_makes/utils/utility.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

Widget toListText(String t){
  List<Widget> lines=[];
  t.split("++").forEach((element) {
    lines.add(toRichText(element));
    lines.add(SizedBox(height:30.0));
  });
  return ListView(
    children: lines,
  );
}
Widget toColumnText(String t){
  List<Widget> lines=[];
  t.split("++").forEach((element) {
    lines.add(toRichText(element));
    lines.add(SizedBox(height:30.0));
  });
  return Column(
    children: lines,
  );
}

RichText toRichText(String tx) {
  return RichText(
    overflow: TextOverflow.clip,
    textAlign: TextAlign.center,
    text: TextSpan(children: toTextSpan(tx)));
}


List<TextSpan> toTextSpan(String tx) {
  var vars = {
    // "text": text,
    "token": "#", // "#"
    "isBold": FontWeight.normal,
    "isHighlighted": false,
    "isItalic": FontStyle.normal,
    "fontSize": 16.0,
    "color": Colors.black,
    "fontWeight": FontWeight.normal,
    "fontFamily": null,
    "fontType": FontStyle.normal
  };
  List<String> links = [];
  bool hasLink = false;

  List<TextSpan> textWidgets = [];
  List v = ["100", "200", "300", "400", "500", "600", "700", "800", "900"];
  tx.split(vars["token"]).forEach((textSeg) {
    if (textSeg == "bold")
      vars["fontWeight"] = FontWeight.bold;
    else if (textSeg == "/bold")
      vars["fontWeight"] = FontWeight.normal;
    else if (textSeg == "normal")
      vars["fontWeight"] = FontWeight.normal;
    else if (textSeg.contains("fw") && v.contains(textSeg.substring(2)))
      vars["fontWeight"] = FontWeight.values[v.indexOf(textSeg.substring(2))];
    else if (textSeg == "italic")
      vars["fontType"] = FontStyle.italic;
    else if (textSeg == "/italic")
      vars["fontType"] = FontStyle.normal;
    else if (textSeg.contains("color"))
      vars["color"] =
          colorFromString(textSeg.substring("color".length)) ?? Colors.black;
    else if (textSeg.contains("/color"))
      vars["color"] = Colors
          .black; // else if(textSeg.contains("highlight")) vars["isHighlighted"]= !isHighlighted;
    else if (textSeg.contains("size"))
      vars["fontSize"] =
          double.tryParse(textSeg.substring("size".length)) ?? 12.0;
    else if (textSeg.contains("/size"))
      vars["fontSize"] = 16.0;
    else if (textSeg.contains("/link"))
      hasLink = false;
    else if (textSeg.contains("link")) {
      hasLink = true;
      links.add(textSeg.substring("link".length));
    } else {
      //
      final int o = links.length - 1;
      if (hasLink) {
        textWidgets.add(TextSpan(
            text: textSeg,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launch(links[o]);
              },
            style:TextStyle(
              fontSize: vars["fontSize"],
              fontWeight: vars["fontWeight"],
              color: Colors.blue,
              decoration: TextDecoration.underline, 
        )));
      } else {
        textWidgets.add(TextSpan(
            text: textSeg,
            style:TextStyle(
                fontSize: vars["fontSize"],
                fontWeight: vars["fontWeight"],
                color: vars["color"])));
      }
    }
  });
  return textWidgets;
}
