import 'package:flutter/material.dart';
class FormDescription extends StatelessWidget {
  final String title;
  final double w;
  final bool underline;
  final bool small;
  final String tooltip;
  
  const FormDescription({Key key, @required this.title, this.w, this.underline=false ,this.small=false, this.tooltip}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:15.0),
      child: Container(
        width: double.infinity,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: small ? 14.0 : 16.0, color: Colors.grey[600]),
                ),
              ),
              tooltip==null?SizedBox():Tooltip(
                margin: EdgeInsets.symmetric(horizontal:50.0),
                message: tooltip, child:
              Icon(Icons.info_outline, color: Colors.grey[500],))
            ],
          ),
        ),
    );
  }
}

