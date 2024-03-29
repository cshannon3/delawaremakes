
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delaware_makes/state/state.dart';
import 'package:domore/database/new_data_repo.dart';

import 'package:get_it/get_it.dart';
GetIt locator = GetIt.instance;
 
void setupLocator() async {
  locator.registerSingleton(DataRepo(FirebaseFirestore.instance));
  locator.registerSingleton(DocsRepo());
  locator.registerSingleton(AppState());
  //locator.registerSingleton(FormManager());
} 
