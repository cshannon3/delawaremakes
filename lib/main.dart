
import 'package:delaware_makes/routes.dart';
import 'package:delaware_makes/state/state.dart';
import 'package:delaware_makes/theme.dart';
import 'package:domore/database/new_data_repo.dart';
import 'package:fluro/fluro.dart' as fluro;

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
    final router = fluro.Router();
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

//https://scontent.fphl2-3.fna.fbcdn.net/v/t1.0-9/101411700_10222861618593165_3841964815979380736_n.jpg?_nc_cat=109&_nc_sid=8bfeb9&_nc_ohc=qjxASdpe500AX_OlDZ1&_nc_ht=scontent.fphl2-3.fna&oh=adf6b147ce20609a42d5c317257d0858&oe=5EF7BDB2
//https://scontent.fphl2-1.fna.fbcdn.net/v/t1.0-9/100791939_10222861619633191_779552975294038016_n.jpg?_nc_cat=107&_nc_sid=8bfeb9&_nc_ohc=WYVn5ggac4MAX_E937L&_nc_ht=scontent.fphl2-1.fna&oh=5b4db08497dfd584e1cacba624416f39&oe=5EFA5E5F