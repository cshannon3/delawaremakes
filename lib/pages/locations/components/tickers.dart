


import 'package:flutter/material.dart';

class PendingTicker extends StatelessWidget {
  final int quantityClaimed;
  final TextStyle textStyle;

  const PendingTicker({Key key, 
  this.quantityClaimed, 
  @required this.textStyle
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Ticker(
      textStyle: textStyle,
      toolTip: '$quantityClaimed claimed but not yet delivered',
      text: "$quantityClaimed",
      borderColor: Colors.yellow[500],

    );
  }
}
class ActiveTicker extends StatelessWidget {
  final int quantityRequested;
  final int quantityClaimed;
  final int quantityDelivered;
  final TextStyle doneTextStyle;
  final TextStyle unclaimedTextStyle;

  const ActiveTicker({Key key, 
    @required this.quantityRequested, 
    @required this.quantityClaimed, 
    @required this.quantityDelivered, 
    @required this.doneTextStyle,
    @required this.unclaimedTextStyle
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Padding(
          padding: EdgeInsets.all(3.0),
          child:Tooltip(
            message: '${quantityRequested-quantityClaimed} unclaimed and $quantityDelivered delivered',
            child: Row(
              children: [
                Ticker(
                  textStyle: unclaimedTextStyle,
                  text: "${quantityRequested-quantityClaimed}",
                  borderColor: Colors.red,
                ),
                SizedBox(width:5.0),
                 Ticker(
                   textStyle: doneTextStyle,
                  text: "$quantityDelivered",
                  borderColor: Colors.green,
                ),
              ],
            ),
          ),
        );
  }
}

class DoneTicker extends StatelessWidget {
  final int quantityDelivered;
   final TextStyle textStyle;
  const DoneTicker({Key key, 
  this.quantityDelivered, 
  @required this.textStyle
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Ticker(
      textStyle: textStyle,
      borderColor: Colors.green,
      text: quantityDelivered.toString(),
      toolTip: '$quantityDelivered delivered'
    );
  }
}



class Ticker extends StatelessWidget {
  final Color borderColor;
  final String text;
 final  String toolTip;
 final double width;
 //final double fontSize;
 final TextStyle textStyle;
   Ticker({Key key, 
   this.borderColor,
    this.text, 
    this.toolTip, 
    this.width=40.0, 
    @required this.textStyle
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: EdgeInsets.all(3.0),
          child: toolTip==null?innerWidget():
          Tooltip(
            message: toolTip,
            child: innerWidget()
          ));}



    Widget innerWidget()=>Container(
              decoration: BoxDecoration(
                border:Border.all(
                  color:borderColor,
                  width:2
                ), borderRadius: BorderRadius.circular(20)
              ),
              height: width, width:width,
              child:
                Center(child: Text(text,
                style:textStyle)
             //    TextStyle(fontSize:fontSize),)
                ),
            );
}