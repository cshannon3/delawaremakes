import 'package:flutter/material.dart';

class FormDropDown extends StatelessWidget {
  final List options;
  final int selectedIndex;
  final Function(int) onChange;
  final String title;

  FormDropDown(
      {Key key,
      @required this.options,
      this.selectedIndex = 0,
      this.title = "",
      @required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: new Text(title),
      items: List.generate(
          options.length,
          (index) => DropdownMenuItem(
                child: new Text(options[index]),
                value: index,
              )),
      value: selectedIndex,
      onChanged: onChange,
      isExpanded: true,
    );
  }
}
