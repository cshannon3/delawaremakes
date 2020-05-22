

import 'package:delaware_makes/forms/components/form_entry_field.dart';
import 'package:delaware_makes/shared_widgets/stylized_image_box.dart';
import 'package:delaware_makes/utils/utils.dart';
import 'package:flutter/material.dart';

class StylizedImageFormInput extends StatelessWidget {
  final String name;
  final String url;
  final dynamic initVal;
  final Function(dynamic) onChange;
  StylizedImageFormInput({
    Key key, 
    this.name, 
    this.url,
    this.initVal,
    this.onChange
    }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return   Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                   Center(
                  child: Container(height: 150.0,width: 150.0,
                    child: StylizedImageBox(url: url??placeHolderUrl)),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Text(name??""),
                  Container(
                      width: 100,
                      child: FormEntryField(
                        labelText: name,
                        onChange: onChange, 
                        initVal:initVal,
                        )
                    )
                  ]),
              ],
            );
  }
}
