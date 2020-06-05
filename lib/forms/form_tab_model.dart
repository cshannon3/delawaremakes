

import 'package:delaware_makes/utils/utils.dart';
import 'package:flutter/material.dart';

class FormTabModel{
  double h;
  bool isCompleted=false;
  bool showIconBar =true;
  bool validate=true;
  IconData icon=Icons.people;
  String tip="";
  Widget screen;
  Map<String, dynamic> formData={};
  final Function(Map) formDataCallback;
  Function(bool) onCompleted;
  var formKey;//= GlobalKey<FormState>();
  //this.formData, this.h, this.tip,this.icon, this.showIconBar=true, this.validate=false
  FormTabModel({this.formDataCallback,});
  init(Map<String, dynamic> b)=>formData=formDataCallback(b);
  
  setKey(String key, dynamic val){
    if(!formData.containsKey("buffer"))formData["buffer"]={};
    formData["buffer"][key]=val;
    }
  dynamic getVal(String key)=>safeGetPath(formData, ["buffer", key]);
}
