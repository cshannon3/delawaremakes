
import 'package:delaware_makes/pages/pages.dart';
import 'package:delaware_makes/pages/resources/resources_page.dart';
import 'package:delaware_makes/root_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart' as fluro;


  void tappedMenuButton(BuildContext context, String key) {
    fluro.TransitionType transitionType = fluro.TransitionType.fadeIn;
    Application.router
        .navigateTo(context, key, transition: transitionType)
        .then((result) {});
  }

class Application {
  static fluro.Router router;
}
class Routes {
  static String root = "/";
  static String profile = "/profile";
  static String aboutUs= "/aboutus";
 // static String admin= "/admin";
  static String designs= "/designs";
  static String id= "users/:id";
  static String locations = "/map";
  static String resources = "/resources";
  static String datastruct = "/datastruct";
  static String kanban = "/kanban";


  static dynamic route(){
      return {
          '/': (BuildContext context) =>   RootPage(screen:HomePageMain(), currentRoute: "/",),
      };
  }

  static void configureRoutes(fluro.Router router) {
    router.notFoundHandler = fluro.Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");

    });
    router.define(root, handler: rootHandler);
    router.define(profile, handler: profileHandler);
    router.define(designs, handler: designsHandler);
    router.define(id, handler: usersHandler);
    router.define(aboutUs, handler: aboutUsHandler);
    router.define(resources, handler: resourcesHandler);
    router.define(locations, handler: locRouterHandler);
    router.define(kanban, handler: kanbanHandler);
  }
}
var locRouterHandler = fluro.Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RootPage(screen:MapsPage2(),currentRoute:"/map");
});

var rootHandler = fluro.Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RootPage(screen:HomePageMain(),currentRoute:"/");
});

var profileHandler = fluro.Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RootPage(screen:ProfilePage(),currentRoute:"/profile");
});
var designsHandler = fluro.Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RootPage(screen:DesignsPage(),currentRoute:"/designs");
});
var resourcesHandler = fluro.Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RootPage(screen:ResourcesPage(),currentRoute:"/resources");
});
var aboutUsHandler = fluro.Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RootPage(screen:AboutUsPage(),currentRoute:"/aboutus");
});

var kanbanHandler = fluro.Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RootPage(screen:KanBan(),currentRoute:"/kanban");
});


var usersHandler = fluro.Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return RootPage(screen:ProfilePage(),currentRoute:"/profile");
});




   // router.define(signIn, handler: signInHandler);
   // router.define(signUp, handler: signUpHandler);


   // router.define(admin, handler: adminHandler);
   // router.define(login, handler: loginHandler);
// var loginHandler = Handler(
//     handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//   return RootPage(screen:WelcomePage(),currentRoute:"/login");
// });
// var signInHandler = Handler(
//     handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//   return RootPage(screen:SignIn(),currentRoute:"/signIn");
// });
// var signUpHandler = Handler(
//     handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//   return RootPage(screen:Signup(),currentRoute:"/signUp");
// });


// var adminHandler = Handler(
//     handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//   return RootPage(screen:AdminPage(),currentRoute:"/admin");
//     });

  //static String login = "/login";
 // static String signIn = "/signIn";
  //static String signUp = "/signUp";