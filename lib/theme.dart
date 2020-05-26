
import 'package:flutter/material.dart';



final ThemeData themeData= ThemeData(
  
    // Define the default brightness and colors.
    accentColor: Colors.cyan[600],
    backgroundColor: Colors.white,
    buttonColor: Colors.orange,
    cardColor: Colors.white,
    //canvasColor: ,
    //cursorColor: ,
    //disabledColor: ,
    //dividerColor: ,
    //errorColor: ,
    //focusColor: ,
    //highlightColor: ,
    //hintColor: ,
    //hoverColor: ,
    
    primaryColor: Colors.lightBlue[800],
    primaryColorDark: Colors.black,
    primaryColorLight: Colors.grey,
    //splashColor: ,
    secondaryHeaderColor: Colors.grey[300],
    
  
    // Define the default font family.
   // fontFamily: 'Georgia',ThemeData(
     fontFamily: 'HelveticaNeue',
      //),
    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 60.0,color: Colors.black),
      headline2: TextStyle( color:Colors.white, fontSize:30.0),
      headline3: TextStyle( color:Colors.white, fontSize:25.0),
      
      headline5: TextStyle( color:Colors.white, fontSize: 20.0,fontWeight: FontWeight.bold),
      headline6:TextStyle( color:Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
      subtitle1: TextStyle( color:Colors.white, fontSize:20.0),
      subtitle2: TextStyle( color:Colors.white, fontSize:16.0),
      bodyText1: TextStyle(fontSize: 12.0,),
      
      bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      

    ),
  );

// final fsVLg= TextStyle( fontSize: 45.0);
// final fsLg= TextStyle( fontSize: 25.0);
// final fsMed= TextStyle( fontSize: 20.0);
// final fsSm= TextStyle( fontSize: 16.0);
// final fsXSm= TextStyle( fontSize: 12.0);


final projTitle=TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          decoration: TextDecoration.underline,
                        );
final projDes=TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        );
final projBut=TextStyle(color: Colors.blue,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold
                         
                        );
                      
final Color menuButton = Colors.white.withOpacity(0.1);


final BoxDecoration mainBackground = BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(195, 20, 50, 1.0),
                Color.fromRGBO(36, 11, 54, 1.0)
              ]),
        );
  