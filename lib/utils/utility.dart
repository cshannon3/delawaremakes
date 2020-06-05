
import 'package:delaware_makes/shared_widgets/shared_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

import 'dart:developer' as developer;
import 'package:uuid/uuid.dart';

String generateNewID()=>Uuid().v4();
String generateIDTime()=>Uuid().v1();

String formatCountText(int count)=>
        count.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');

        
bool launch(String url) {
  return html.window.open(url, '') != null;
}
dynamic safeGet({@required String key, @required Map map,@required dynamic alt}){
  try{
    return map.containsKey(key)?map[key]
    :map.containsKey(key.toLowerCase())?map[key.toLowerCase()]:alt;
  }catch(e){
    return alt;
  }
}

dynamic checkPath(var map, List path){
  int i = 0;
  if(map is Map){
    while (map.containsKey(path[i])){
      map = map[path[i]];
      i++;
      if(i==path.length)return [true, map];
    }
    return [false, null];
  }else return [false, null];
}

dynamic ifIs(var tokens, var name) => 
    (tokens!=null && name!=null && tokens.containsKey(name)) ? tokens[name] : null;

bool noneEmpty({dynamic test}){
  if (test==null)return false;
  if (test==[]||test==""||test=={})return false;
  if(test is List){
    int i = 0;
    while (i< test.length){
      if(!noneEmpty(test:test[i])){
        return false;
      }
      i++;
    }
  }
  return true;
}

double fullWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
} 
double fullHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
} 

double flexW(double w){
  if(w==null)return 0;
  double maxW=450.0;//double minW=300.0;
  double m = (w>maxW)?((w-maxW)/2):5.0;
  return m;
}


 int getColumnNum(double width) =>
      (width <= 500) ? 1 : (width > 1200) ? 4: (width / 300).floor();

bool isMobile(double width)=>(width<=650);
Widget ifMobile({double width, List<Widget> items}){
  return isMobile(width)?Column(children: items,):Row(children: items,);
}
String base = "http://maps.google.com/mapfiles/kml/paddle";
Widget imageFromPath(String path)=>path.contains("http")?Image.network(path):Image.asset(path);



void cprint(dynamic data, {String errorIn, String event}) {
  if (errorIn != null) {
    print(
        '****************************** error ******************************');
    developer.log('[Error]', time: DateTime.now(), error:data, name:errorIn);
    print(
        '****************************** error ******************************');
  } else if (data != null) {
     developer.log(data, time: DateTime.now(), );
  }
  if (event != null) {
    // logEvent(event);
  }
}


String getUserName({String name, String id}) {
  String userName = '';
  name = name.split(' ')[0];
  id = id.substring(0, 2).toLowerCase();
  userName = '@$name$id';
  return userName;
}




bool validateEmail(String email) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  var status = regExp.hasMatch(email);
  return status;
}


List<Widget> tryAdd(List<Widget> items, var wid){
  if (wid is List<Widget>) items.addAll(wid);
  else if  (wid is Widget) items.add(wid);
  return items;

}
dynamic ifIsOne(var tokens, var names) {
  if (tokens==null || names==null || !(names is List))return null;
  var out;
  int index = 0;
  while (out==null && index<names.length){out=ifIs(tokens, names[index]);index+=1;}
   return out;

}

String capWord(String word) {
  if (!word.contains("_")) return word[0].toUpperCase() + word.substring(1);
  String out = "";
  word.split("_").forEach((w) => out += capWord(w));
  return out;
}

bool hasChildren(String key){
   var widgetInfo = key.contains("_") ? key.split("_") : [key];
   return (["stack", "column", "row", "listview"].contains(widgetInfo[0]));
 }

dynamic safeGetPath(var map, List path)=>checkPath(map, path)[1];
