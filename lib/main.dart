
import 'package:delaware_makes/routes.dart';
import 'package:delaware_makes/state/state.dart';
import 'package:delaware_makes/theme.dart';
import 'package:domore/state/new_data_repo.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
void main() async {
  setupLocator();
    var dataRepo = locator<DataRepo>();
    var docsRepo = locator<DocsRepo>();
    await dataRepo.initialize();
    await docsRepo.initialize();   
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
           theme: themeData,
      color: Colors.grey,
      routes: Routes.route(),
      onGenerateRoute: Application.router.generator,
   );
  }
}


/*gmanager: gmanager*//*gmanager: gmanager*/
