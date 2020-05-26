import 'package:delaware_makes/routes.dart';//import 'package:delaware_makes/shared_widgets/shared_widgets.dart';
import 'package:delaware_makes/shared_widgets/button_widgets.dart';
import 'package:delaware_makes/state/state.dart';
import 'package:delaware_makes/utils/utils.dart';
import 'package:domore/forms/form_overlay.dart';
import 'package:domore/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  final Widget screen;
  final String currentRoute;

  RootPage({Key key, this.screen, this.currentRoute}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  //AppState appState; 
  bool isFormActive=false;
  @override
  void initState() {

    var appState = locator<AppState>();
    if (!appState.isReady) {
      appState.getAll(); 
      
    }

   appState.addListener(() {

     
    setState(() {
      isFormActive=appState.isFormActive;
    });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var appState = locator<AppState>();
    return Scaffold(
      appBar:// (appState.hideAppBar())? null:
      appbar(context, widget.currentRoute, Theme.of(context).textTheme.subtitle1),
      body: (appState.loading || !appState.isReady ) ? Center(child: CircularProgressIndicator())
          : appState.isFormActive ? 
          Container(
    height: double.infinity,
    width: double.infinity,
    child: FormOverlay(
                  formModel:appState.currentFormModel,
                 isFullView: appState.isFullViewForm(),
                  child:widget.screen,
                  uploadImageFile: null,
                  onDone: (isCompleted)  {
                   //print("Done");
                   if(isCompleted) appState.submitForm();
                   else appState.dismissForm();
                   setState(() {
                     
                   });
                  },
    )): appState.isLoginActive?
    LoginPage(
      firebaseAuth: FirebaseAuth.instance,
       onSignIn: appState.onSignIn
      ):

    widget.screen
         
          
       
    );
  }

  Widget bodyPadding(Widget screen, Size s) {
  double centerWidth = (s.width < 1140.0) ? s.width - 40.0 : 1100.0;
  return Container(
      child: Center(
        child: Container(
            width: centerWidth, height: double.infinity, child: screen),
      ));
}
  List<Widget> actionList(BuildContext context) {
    var appState = locator<AppState>();
    return appState.loggedIn
        ? [
            FlatButton(
              hoverColor:Colors.white.withOpacity(0.3),
                onPressed: () {
                  if ("/profile" != widget.currentRoute)
                  tappedMenuButton(context, "/profile");
                },
                child: Text(appState.currentUser.getVal("name", alt:"")
                        .toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 16.0)))
          ]
        : [   MenuButton(name: "LOGIN", onPressed:() { 
            appState.initLogin();
             //  tappedMenuButton(context, "/login"); //platformInfo.setOverlay("login");//TODO
              }),
          ];
  }

  menuButtonClicked(BuildContext context, String route) {  if (route != widget.currentRoute)tappedMenuButton(context, route); }
  
  appbar(BuildContext context, String currentRoute,TextStyle  textStyle) => AppBar(
        backgroundColor: Colors.black,
        leading:SizedBox(),
         title: Row(
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
             Text("Delaware Makes",
                 style: textStyle
                 ),
                 
           ],
         ),
        actions: actionList(context),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.white),
            child: Container(
              height: 48.0,
              child: Row(
                children: <Widget>[
                  MenuButton(name: "Home", onPressed: ()=>menuButtonClicked(context, "/")),
                  MenuButton(name: "Open Requests", onPressed: ()=>menuButtonClicked(context, "/map")),
                  MenuButton(name: "About Us", onPressed: ()=>menuButtonClicked(context, "/aboutus")),
                  MenuButton(name: "Resources", onPressed: ()=>menuButtonClicked(context, "/designs")),
                  Expanded(
                    child: Container(),
                  ),
                 
                ],
              ),
            ),
          ),
        ),
      );

}


    //var appState = locator<AppState>();

    //Size s =  MediaQuery.of(context).size;
   // bool mobile = false;
  //  isMobile(s.width);
   // bool isFormFull =  appState.isFormActive &&mobile;
    // s.height<800.0;
   //TextStyle mobileHeader = Theme.of(context).textTheme.subtitle1;
    //TextStyle desktopHeader = Theme.of(context).textTheme.headline2;
  //  Widge wid = widget.screen;
   // print(appState.isFormActive);
              // Container(
              //   height:200.0,
              //   width:200.0,
              //   color:Colors.grey
              // )   // Stack(
          //   children: <Widget>[ //bodyPadding(widget.screen, s),
          //     //formManager.getOverlay()
          //     wid,
          //     appState.isFormActive? 
               
          //         :SizedBox()
          //   ],
          // ),
        // if (appState.isReady) {
        //   setState(() {});} 
        // if(isFormActive!=appState.isFormActive)
        //   setState(() { 
        //     isFormActive=appState.isFormActive;
        //   }); 