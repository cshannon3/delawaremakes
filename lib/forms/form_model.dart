
import 'package:delaware_makes/forms/form.dart';
import 'package:delaware_makes/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';



class FormModel{
  final String name;
  final List<FormTabModel> tabs;
 // final Function(Map) onSubmit;
  int currentScreenNum=0;
  Map<String,dynamic> buffer = {};
  FormModel( {
    @required this.name,
    @required this.tabs, 
   // @required this.onSubmit, 
    this.buffer});
  List<FormTabModel> getTabs() => tabs??[];

  init(){ // if(tabs==null)tabs=[];
   currentScreenNum =0;
    tabs.forEach((tab) {
      tab.init(buffer); // print(tab.formData);
    });
  }

    FormTabModel get currentForm => (currentScreenNum != null &&
          tabs != null &&
          tabs.length > currentScreenNum)
      ? tabs[currentScreenNum]
      :null;

   Future<bool> next() async {
   // print("Next)");
    bool done=false;
      tabs.forEach((element) {
        element.formData["buffer"].forEach((k, v) {
          buffer[k] = v;
        });
      });
     // print(buffer);
    if ((currentScreenNum+1) >= tabs.length) {
      tabs.forEach((element) { // print(element.formData["buffer"]);
        element.formData["buffer"].forEach((k, v) {
          buffer[k] = v;
        });
      }); // currentScreenNum=0;
      currentScreenNum+=1;// await onSubmit(buffer);
      done=true;
      return done;
    }else{
      currentScreenNum+=1;
      tabs[currentScreenNum].init(buffer);
    }
    return done;
  }

  Map<String, dynamic> toMap({
   @required Map checkItems, 
    Map additionalItems
    }){
    Map<String, dynamic> out={};
    // key/path
    checkItems.forEach((key, value) {
      if(value is List){out[key]= safeGetPath(buffer, value);}
      else{out[key]= safeGet(key:value, map: buffer, alt:null);}
    });
    if(additionalItems==null)return out;
    additionalItems.forEach((key, value) {
      out[key]= value;
    });
    return out;
  }

}


