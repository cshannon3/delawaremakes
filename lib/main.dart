
import 'package:delaware_makes/routes.dart';
import 'package:delaware_makes/service_locator.dart';
import 'package:delaware_makes/state/app_state.dart';
import 'package:delaware_makes/state/data_repo.dart';
import 'package:delaware_makes/state/docs_repo.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';


 


void main() async {
  setupLocator();
    
    var dataRepo = locator<DataRepo>();
    var docsRepo = locator<DocsRepo>();
    await dataRepo.initialize(/*gmanager: gmanager*/);
    await docsRepo.initialize(/*gmanager: gmanager*/);   
    var appState = locator<AppState>();
    appState.init();
  runApp(AppComponent());
}

class AppComponent extends StatefulWidget {
  @override
  State createState() {
    return AppComponentState();
  }
}

class AppComponentState extends State<AppComponent> {
  AppComponentState() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }
  
  @override
  Widget build(BuildContext context) {
 
    return  MaterialApp(
      title: 'Delaware Makes',
      debugShowCheckedModeBanner: false,
           theme: ThemeData(
             fontFamily: 'HelveticaNeue',
         //  .copyWith( bodyText1: GoogleFonts.oswald(), ),
      ),
      color: Colors.grey,
      routes: Routes.route(),
      onGenerateRoute: Application.router.generator,
   );
  }
}
