
import 'package:delaware_makes/pages/home/components/intro.dart';
import 'package:delaware_makes/pages/home/components/maker_section.dart';
import 'package:delaware_makes/pages/home/components/request_section.dart';
import 'package:delaware_makes/utils/utils.dart';
import 'package:flutter/material.dart';


class HomePageMain extends StatelessWidget {

HomePageMain({
  Key key, 
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
  bool mobile = isMobile(MediaQuery.of(context).size.width);
 Map<String, dynamic> children= {
        "intro":   ()=> IntroBlock(isMobile: mobile,),
          "box1":   ()=>   SizedBox(height:50),
           
        "request":   ()=>       Padding(
              padding: EdgeInsets.symmetric(horizontal:mobile?5.0:30.0),
              child: RequestSection(isMobile: mobile,),
            ),
                "box2":   ()=>   SizedBox(height:30),
            "maker":   ()=>     Padding(
              padding: EdgeInsets.symmetric(horizontal:mobile?5.0:30.0),
              child: MakerSection(isMobile: mobile,),
            ),
            
           "box3":   ()=>      SizedBox(height:100),
        "contact":   ()=>   Container(
          color:Colors.black,
          height: 150.0,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("If you have any questions, please contact us at:", style: TextStyle( color:Colors.white, fontSize: 16.0)),
                SizedBox(height:10),
                Text("delawaremakes@gmail.com", style: TextStyle( color:Colors.white, fontSize: 16.0))
            ],),
          )
        )
 };




    return   Container(
        height: double.infinity,
        width: double.infinity,
        child: ListView.builder(
           itemCount: children.keys.length,
          itemBuilder: (BuildContext ctxt, int index) {
          return children[children.keys.toList()[index]]();
    }
          )
      
      );
  }
}

      // Widget title(String titleText)=>makeSliverHeader(
      //           Container( height: double.infinity,width: double.infinity,
      //              child:titleText==""?null: formTitle(titleText, underline:true),
      //           ),minH: 50.0, maxH: 50.0);

          // DesignsPage(),
          //  Container( height: 50.0,
          //  width: double.infinity,
          //       child: formTitle("", underline:true),),
       // Gallery(w:s.width),