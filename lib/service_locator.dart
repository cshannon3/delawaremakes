
import 'package:delaware_makes/forms/form_manager.dart';
import 'package:delaware_makes/state/state.dart';

import 'package:get_it/get_it.dart';
GetIt locator = GetIt.instance;
 
void setupLocator() async {
  locator.registerSingleton(DataRepo());
  locator.registerSingleton(DocsRepo());
  locator.registerSingleton(AppState());
  locator.registerSingleton(FormManager());
} 
