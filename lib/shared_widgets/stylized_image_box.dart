import 'package:domore/extensions/hover_extension.dart';
import 'package:flutter/material.dart';

class StylizedImageBoxAsset extends StatelessWidget {
     final Widget topLeftWidget;
     final Widget topRightWidget;
     final Widget topCenterWidget;
     final Widget bottomWidget;
     final String url;
     final String bottomText;
     final Function onPressed;

     StylizedImageBoxAsset({
       Key key, 
       this.topLeftWidget, 
       this.topRightWidget, 
       this.topCenterWidget, 
       this.bottomWidget, 
       this.onPressed,
      @required this.url, 
       this.bottomText}) : super(key: key);


    Widget getBottomWidget()=>bottomWidget??Text( 
                          bottomText??"",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        );

     @override
     Widget build(BuildContext context) {
       return  Container(
          child: InkWell(
            onTap: onPressed,
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Center(child: Image.asset(url, fit: BoxFit.cover, width: 1000.0, alignment: Alignment.center,)),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: getBottomWidget()
                        ),
                      ),
                      Align(alignment:Alignment.topLeft, child: topLeftWidget??SizedBox(),),
                      Align(alignment:Alignment.topCenter, child: topCenterWidget??SizedBox(),),
                      Align(alignment:Alignment.topRight, child: topRightWidget??SizedBox(),),
                    ],
                  )),
            ),
          ),
        ).showCursorOnHover;
     }
   }
