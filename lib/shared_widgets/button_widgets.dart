
import 'package:flutter/material.dart';
import 'package:domore/domore.dart';

 Widget mainMyTabs({String selected, double width, Map<String, Function()> items}){
      List<Widget> tabWidgets = [];
      items.forEach((key, value) {
        tabWidgets.add(makeTabButton(text:key,active:key==selected, onPressed:value));
      });
     return Row( // include on pressed
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: tabWidgets
            
            ) ;
    }
  Widget makeTabButton({String text,bool active, Function() onPressed})=>Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 40.0,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: active?Colors.grey[200]:Colors.grey[100],
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0),bottomRight: Radius.circular(15.0) ),
                        border: Border.all(
                            color: active?Colors.black:Colors.white,
                            width:active?2.0 : 0.0)),
                    child: InkWell(
                        onTap: onPressed,
                        child: Center(child: Text(text, style: TextStyle(color:active?Colors.black:Colors.grey),))),
                  ),
                ),
              );

// class MenuButton extends StatelessWidget {
//     final String name;
//   final Function() onPressed;

//   const MenuButton({Key key,@required this.name,@required this.onPressed}) : super(key: key);
//   @override
//     Widget build(BuildContext context) {
//     return Container(
//       height:40,
//       child: FlatButton(
//                       onPressed: onPressed,
//                       textColor: Colors.white,
//                       child: Text(name,style:  TextStyle(color: Colors.white, fontSize: 16.0)),
//       ).showCursorOnHover.moveUpOnHover,
//     );
//   }
// }

class CallToActionContainer extends StatelessWidget {
  final String topText;
  final String buttonText; 
  final double textSize;
  final Function() onPressed;
  final double topPadding;
  final double bottomPadding;

  const CallToActionContainer({Key key, this.topText, this.buttonText, this.onPressed, this.topPadding=10.0, this.bottomPadding=10.0, this.textSize=16}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: topPadding, bottom: bottomPadding),
      child: Column(
          children:[    
           Padding(
            padding: EdgeInsets.only(top:8.0),
            child: Center(child: Container(child:Text(topText, style: TextStyle(fontSize: 16.0),))),
          ),
          SizedBox(height: 10,),
          Center(child: 
          Container
          (height: 40.0, child:
          CallToActionButton(
            fontSize: textSize,
            name:buttonText,
          onPressed:onPressed??(){} ))),
   ]),
    );
  }
}
class CallToActionButton extends StatelessWidget {
  final String name;
  final Function() onPressed;
   final double fontSize;
  final double h;

  const CallToActionButton({Key key, @required this.name, this.onPressed, this.fontSize, this.h}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
                    height: 40.0,
                    minWidth: 80.0,
                    onPressed: onPressed,
                    color: Colors.orangeAccent,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0)),
                    child: Text(name,
                        style:  TextStyle(color: Colors.white, fontSize: fontSize??25.0)),
             //     ),
    ).showCursorOnHover.moveUpOnHover;
  }
}

// class MainUIButton extends StatelessWidget {
//   final Function() onPressed;
//   final String text;

//   const MainUIButton({Key key, @required this.onPressed, @required this.text}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return   MaterialButton(
//             hoverColor: Colors.white,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//             color: Colors.grey[200],
//             onPressed: onPressed,
//             child: Text(text)).showCursorOnHover.moveUpOnHover;
//   }
// }

// enum CommonIcons{
//   CLOSE,
//   INFO,
//   LINK,
//   VERIFY,
//   GOTO
// }


// Widget iconButton({
//   @required CommonIcons icon,  
//   String toolTip,
//   Color color,
//   @required Function() onPressed
//   }) {
//   IconData iconData=Icons.question_answer;
//   switch (icon) {
//     case CommonIcons.CLOSE:
//         iconData= Icons.clear;
//       break;
//     case CommonIcons.INFO:
//         iconData= Icons.info_outline;
//       break;
//      case CommonIcons.LINK:
//           iconData= Icons.link;
//       break;
//     case CommonIcons.GOTO:
//           iconData= Icons.input;
//       break;
//     case CommonIcons.VERIFY:
//           iconData= Icons.verified_user;
//       break;
//     default:
//      break;
//   }
//   return (toolTip!=null)?Tooltip(message: toolTip, child:IconButton(icon: Icon(iconData), color: color, onPressed: onPressed).showCursorOnHover.moveUpOnHover)
//   :IconButton(icon: Icon(iconData), color: color, onPressed: onPressed).showCursorOnHover.moveUpOnHover;
  
// }





// Widget closeIcon({@required Function() onPressed}) => Align(
//       alignment: Alignment.topRight,
//       child: IconButton(
//           icon: Icon(Icons.close), color: Colors.red, onPressed: onPressed).showCursorOnHover.moveUpOnHover,
//     );



// Widget googleSignInWidget(
//         {@required Function() onTap, double h = 50.0, double w = 120}) =>
//     Padding(
//       padding: EdgeInsets.only(right: 10.0),
//       child: InkWell(
//         onTap: onTap,
//         child: Container(
//           width: w,
//           height: h,
//           child: Image.network(
//               'https://www.wethebuilders.com/assets/google-signin-91dc17d460e647bc21b07825041e93c6.png'),
//         ),
//       ),
//     );


//  Widget loggedIn({Function() onPress, String displayName=""}) => InkWell(
//         onTap:  onPress,
//         child: Container(
//             width: 120.0,
//             height: 50.0,
//             child: Center(
//                 child: Text(
//               displayName,
//               style: TextStyle(color: Colors.white),
//             ))),
//       );

//   Widget notLoggedIn({Function() onPress}) => InkWell(
//         onTap: onPress,
//         child: Container(
//             width: 120.0,
//             height: 50.0,
//             child: Center(
//                 child: Text(
//               "Login",
//               style: TextStyle(color: Colors.white),
//             ))),
//       );

