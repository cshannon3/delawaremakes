import 'package:flutter/material.dart';
import '../../extensions/hover_extension.dart';
class FormEntryField extends StatelessWidget {
    final String labelText;
    final String hint;
    final String emptyText;
    final double w;
    final Function(dynamic) onChange;
    
    final bool isNumber;
    final bool isPassword;
    final String initVal;
    final Function(String) validator;
    final int maxLines;

  const FormEntryField({Key key, 
  this.labelText, 
  this.hint, 
  this.emptyText, 
  this.w, 
  this.onChange, 
  this.validator, 
  this.maxLines=1, 
  this.isNumber=false, 
  this.isPassword=false, 
  this.initVal=""
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
    width:double.infinity,
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(30),
    ),
    child: TextFormField(
      initialValue: initVal,
      maxLines: maxLines,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: TextStyle(
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.normal,
        color: Colors.black
      ),

      onChanged: onChange,
      validator: validator?? (value) { if(value.isEmpty)return'Enter $labelText';return null;},
      
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          borderSide: BorderSide(color: Colors.blue),
        ),
        errorBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
          borderSide: BorderSide(color: Colors.red),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
    ),
  ).showCursorOnHover.moveUpOnHover;
  }
}

