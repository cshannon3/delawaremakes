
import 'package:delaware_makes/service_locator.dart';
import 'package:delaware_makes/state/auth_state.dart';
import 'package:delaware_makes/state/data_repo.dart';
import 'package:delaware_makes/state/docs_repo.dart';
import 'package:delaware_makes/utils/constant.dart';
import 'package:delaware_makes/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:delaware_makes/utils/utils.dart';

const int numCollections = 9;
class AppState extends ChangeNotifier {
  Map currentUser, userProfileData;
  bool loggedIn = false;
  bool isReady = false;
  Map<String, dynamic> buffer;
  DataRepo dataRepo;
  DocsRepo docsRepo;
  AuthState authState;
  String overlay = "";
  AppState();

  Map getProfileData() => userProfileData ?? {};
 
  init(){
    
    authState = AuthState();
    docsRepo = locator<DocsRepo>();
    dataRepo = locator<DataRepo>();
  } 
  getAll({bool reinitialize = false}) async {
    if (reinitialize) { await dataRepo.loadCollectionsFromFirebase();}
    while (dataRepo.colCount.length < numCollections) {
      await Future.delayed(Duration(milliseconds: 10));
      if (debug) { print("getAll");  print(dataRepo.colCount); print(dataRepo.collections.length); print("Wait"); }
  }
    isReady = true;
    notifyListeners();
  }

bool isCurrentUser(){
  if(currentUser==null || userProfileData==null)return false;
  if(userProfileData["id"]!=currentUser["id"])return false;
  return true;
}

bool isUserAdmin(){
  if(currentUser==null)return false;
  return safeGet(key: "isAdmin", map: currentUser, alt: false);
}
bool setUserProfile(Map user, {bool isCurrentUser=false}){
  userProfileData = dataRepo.getItemByID("users", user["id"], addLinkMap: true);
  if(isCurrentUser) currentUser= userProfileData;
  return true;
}

/*
SIGN IN
*/
Future<String> signIn(String email, String password,{GlobalKey<ScaffoldState> scaffoldKey}) async {
  String userID =await authState.signIn(email, password, scaffoldKey: scaffoldKey);
  loggedIn = true;
  currentUser = dataRepo.getItemByID("users", userID);
  setUserProfile(currentUser, isCurrentUser:true);
  return "";
}

/*
SIGN UP
*/
  initSignUp() {
    buffer = {
      "email": "",
      "name": "",
      "displayName": "",
      "isVerified": false,
    };
  }

  Future<String> signUp(
      {GlobalKey<ScaffoldState> scaffoldKey, @required String password}) async {
    buffer["displayName"] = buffer["name"];
    String uid = await authState.signUp(buffer["email"],
        scaffoldKey: scaffoldKey, password: password);
    if (uid != null) {
      buffer["id"] = uid;
      await dataRepo.createModel(modelData: buffer, collectionName: "users");
    }
    currentUser = buffer;
    loggedIn = true;
    setUserProfile(currentUser, isCurrentUser:true);
    return "";
  }

  logout() {
    currentUser=null;
    loggedIn=false;}
}


         






// List materialToSheet(Map<String, dynamic> map, DataRepo dataRepo)=>//async{ // await  dataRepo.addRowToSheet(collectionName:"orgs", vals: 
//             [
//             safeGet(key: "contactName", map: map, alt: ""),
//             safeGet(key: "contactEmail", map: map, alt: ""), 
//             safeGet(key: "isVerified", map: map, alt: false)?"true":"false",
//             safeGet(key: "quantity", map: map, alt: 0),
//             safeGet(key: "info", map: map, alt: "-"),
//             safeGet(key: "createdAt", map: map, alt: "-"),
//             ];


// List orgToSheet(Map<String, dynamic> map, DataRepo dataRepo)=>//async{ // await  dataRepo.addRowToSheet(collectionName:"orgs", vals: 
//             [
//             safeGet(key: "id", map: map, alt: ""), 
//             safeGet(key: "name", map: map, alt: ""),
//             safeGet(key: "isVerified", map: map, alt: false)?"true":"false",
//             safeGet(key: "requests", map: map, alt: []).length,
//             safeGet(key: "type", map: map, alt: "-"),
//             safeGet(key: "contactEmail", map:map, alt: "-"),
//             safeGet(key: "contactName", map:map, alt: "-"),
//             safeGet(key: "address", map:map, alt: "-"),
//             safeGet(key: "deliveryInstructions", map:map, alt: "-"),
//             safeGet(key: "createdAt", map: map, alt: "-"),
//             ];

// List requestToSheet(Map<String, dynamic> map, DataRepo dataRepo){
//  return     [ 
//             safeGet(key: "id", map: map, alt: "-"), 
//             safeGet(key: "isVerified", map: map, alt: false)?"true":"false",
//             safeGet(key: "contactName", map: map, alt: "-"),
//             safeGet(key: "name", map: map, alt: "-"), 
//             safeGet(key: "name", map: dataRepo.getItemByID("designs", map["designID"]), alt: "-"),
//             safeGet(key: "quantity", map: map, alt:0),
//             safeGet(key: "requestSource", map: map, alt: "-"),
//             safeGet(key: "isDone", map: map, alt: false)?"true":"false",
//             safeGet(key: "createdAt", map: map, alt: "-"),
//             ];}

// List resourceToSheet(Map<String, dynamic> map, DataRepo dataRepo)=>//async{//  await  dataRepo.addRowToSheet(collectionName:"resources", vals:
//           [ 
//             safeGet(key: "id", map: map, alt: ""), 
//             safeGet(key: "url", map: map, alt: ""),
//             safeGet(key: "isVerified", map: map, alt: false)?"true":"false",
//             safeGet(key: "name", map: map, alt: ""),
//             safeGet(key: "name", map:dataRepo.getItemByID("orgs", safeGet(key: "orgID", map: map, alt: "")), alt: ""),
//             safeGet(key: "name", map:  dataRepo.getItemByID("designs",safeGet(key: "designID", map: map, alt: "")), alt: ""),
//             safeGet(key: "quantity", map: map, alt: 0),
//             safeGet(key: "displayName", map: dataRepo.getItemByID("users",safeGet(key: "userID", map: map, alt: "")), alt: ""),
//             safeGet(key: "createdAt", map: map, alt: ""),
//           ];
// List claimToSheet(Map<String, dynamic> map, DataRepo dataRepo)=>//async{ // await  dataRepo.addRowToSheet(collectionName:"requests", vals:
//             [ 
//             safeGet(key: "id", map: map, alt: ""), 
//             safeGet(key: "isVerified", map: map, alt: false)?"true":"false",
//             safeGet(key: "name", map:dataRepo.getItemByID("orgs", safeGet(key: "orgID", map: map, alt: "")), alt: ""),
//             safeGet(key: "name", map: dataRepo.getItemByID("designs", map["designID"]), alt: ""),
//             safeGet(key: "displayName", map: dataRepo.getItemByID("users",safeGet(key: "userID", map: map, alt: "")), alt: ""),
//             safeGet(key: "quantity", map: map, alt: 0),
//             safeGet(key: "isDone", map: map, alt: false)?"true":"false",
//             safeGet(key: "createdAt", map: map, alt: ""),
//           ];
