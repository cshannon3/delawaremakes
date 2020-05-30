
// import 'package:cloud_firestore/cloud_firestore.dart';
// //import 'package:delaware_makes/utils/constant.dart';
// import 'package:delaware_makes/utils/secrets.dart' as secrets;
// import 'package:delaware_makes/utils/utility.dart';
// import 'package:flutter/material.dart';

// import 'package:delaware_makes/utils/utils.dart';


// // Data Repo Grabs the Google Sheet of interest,
// // Gets the collections data from firebase
// // passes down the relavent worksheet to each Custom Collection
// //checks to see if needs to update collections data based on firebase or
// // if needs to show any, updates sheet Gets collections from firebase
// // todo avoid infinite recursion

// class DataRepo {
//   //final// = GManager(secrets.credentials);
//   DataRepo();
//   Map<String, dynamic> collections = {};
//   Map<String, bool> colCount = {};
//   Firestore _db;
//   bool hasDesigns = false;

//   Future<String> initialize() async {
    
//     print("start"); // Gets spreadsheet
//      _db = Firestore.instance; // Get collections
//     await loadMetadata();
//     return "";
//   }

//   bool collectionExists(String col) => collections.containsKey(col);
//   Map getModels(String collectionName) =>collectionExists(collectionName)?collections[collectionName]["models"]:{};
//   //Map getModel(String collectionName, String modelID)=>checkPath(var map, List path)

//   loadMetadata() async {
//     colCount = {};
//     Firestore.instance.collection("metadata").snapshots().listen((onData) {
//       onData.documents.forEach((dataItem) {
//         if (dataItem.data != null) {
//           Map<String, dynamic> map = dataItem.data;
//           collections[map["collectionName"]] = map;
//           collections[map["collectionName"]]["models"] = {}; //  print(collections[map["collectionName"]]);
//           _loadFromFirebase(map["collectionName"]); // colCount[c]=true;
//         }
//       });
//     });
//   }

//   loadCollectionsFromFirebase() async {
//     colCount = {};
//     collections.forEach((collectionName, collectionData) async {
//       await _loadFromFirebase(collectionName);
//     });
//   }

//   _loadFromFirebase(String c) async {
//     await Future.delayed(Duration(milliseconds: 20)); //  print(c);
//     Firestore.instance.collection(c).snapshots().listen((onData) {
//       onData.documents.forEach((dataItem) {
//         if (dataItem.data != null) {
//           collections[c]["models"][dataItem.data["id"]] = dataItem.data; // print(collections[c]);
//           colCount[c] = true;
//         }
//       });
//     });
//   }
// List getItemsWhere(String collectionName, {Map<String, dynamic> fieldFilters, bool getLinkedData=false, bool getLinkedID=false}) {
//   List models = getModels(collectionName).values.toList();
//   //if(fieldFilters==null)return models;
//   List res=[];
//   models.forEach((modelData) {
//        bool good = true;
//        if(fieldFilters!=null){
//         fieldFilters.forEach((fieldName, value) {
//           var val = safeGet(key: fieldName, map: modelData, alt: null);
//           if(val==null || val!=value){ good=false; }
//         });
//        }

//        if(good){
//          res.add((getLinkedData ||getLinkedID)
//               ?_addLinkedData(collectionName, modelData["id"], modelData, onlyIDs: getLinkedID, )
//               :modelData);
//        }
//   });
//   return res;
// }
//  Map getItemWhere(String collectionName,   Map<String, dynamic> fieldFilters){
//    List models =getModels(collectionName).values.toList();
//     return models.firstWhere((modelData){
//       bool good = true;
//       fieldFilters.forEach((fieldName, value) {
//         if(value!=null){
//           var val = safeGet(key: fieldName, map: modelData, alt: null);
//           if(val==null || val!=value)good=false;//return false;
//         }
//        });
//        return good;
//     }, orElse: ()=>{});
//  }

// Map getItemByID(String collectionName,String modelID, {bool addLinkIDs=false,  bool addLinkMap=false}){
//   if(modelID==null || modelID=="")return {};
//   Map res = checkPath(collections, [collectionName, "models", modelID])[1]??{};
//   if(!addLinkIDs && !addLinkMap)return res;
//   return _addLinkedData(collectionName, modelID, res, onlyIDs: addLinkIDs);
// }




// // Converts list of ids into the data
// Map _addLinkedData(String modelCollectionName,  String modelID, Map modelData,{ bool onlyIDs = false}){
//   Map res=modelData??{};
//   collections.forEach((collectionName, collectionData) {
//     if(collectionName!=modelCollectionName){
//       collectionData["fields"].forEach((fieldName, fieldData){
//       //  print(fieldName);
//         var type= safeGet(key:"type", map:fieldData, alt: "");
//         var typeInfo = safeGet(key:"typeInfo", map:fieldData, alt:"" );
//         if(type=="ForeignKey"  && typeInfo==modelCollectionName){
//         //  print(collectionName);print(fieldName);
//          onlyIDs? res[collectionName]=_linkedDataList(collectionName, fieldName, modelID, onlyIDs: onlyIDs)??[]:
//                   res[collectionName]=_linkedDataMap(collectionName, fieldName, modelID, )??{};
//         }
//       });
//     }
//   });
//   return res;
// }

// List _linkedDataList(String collectionName, String fieldName, String modelID, {bool onlyIDs = false}){
//   List res=[];
//   if(!collectionExists(collectionName))return [];
//   try{
//   collections[collectionName]["models"].forEach((id, data){
//     String fieldVal = safeGet(key:fieldName, map:data, alt: "");
//     if(fieldVal==modelID){
//       res.add(onlyIDs?id:data);
//     }
//   });
//   }catch(e){}//{print("error"); }
//   return res;
// }
// Map _linkedDataMap(String collectionName, String fieldName, String modelID, ){
//   Map res = {};
//   if(!collectionExists(collectionName))return {};
//   try{
//   collections[collectionName]["models"].forEach((id, data){
//     String fieldVal = safeGet(key:fieldName, map:data, alt: "");
//     if(fieldVal==modelID){
//       res[id]=data;
//     }
//   });
//   }catch(e){}//{print("error"); }
//   return res;
// }
// // Converts list of ids into the data
// // Map getLinkedInfo(String collectionName,String , String fieldName, Map linkedData){
// //   Map res=linkedData??{};
// //   List collection = checkPath(collections, [collectionName, "fields", fieldName, "typeInfo"]);
// //   if(collection[1])return {};

// //   collections[collectionName]["fields"]
// //   .forEach((fieldName, fieldData){
// //         var type= safeGet(key:"type", map:fieldData, alt: "");
// //         var typeInfo = safeGet(key:"typeInfo", map:fieldData, alt:"" );
// //         if(type=="ForeignKey" && modelData.containsKey(fieldName)){
// //           res[fieldName]=checkPath(collections, [typeInfo, "models", modelData[fieldName]])[1]??{};
// //         }
// //   });
// //   return res;
// // }

// /*
// FIREBASE
// */
// /* 
// GET
// */
// Future<Map<String, dynamic>> getModelFromFirestore({
//     @required String modelID,
//     @required String collectionName,
//   }) async {
//     DocumentSnapshot document =
//         await _db.collection(collectionName).document(modelID).get();
//     return document.data;
//   }
//   /* 
// CREATE
// */
//   Future createModel({@required Map<String, dynamic> modelData,
//       @required String collectionName}) async { //if (checkPath(collections, [collectionName, "models"])[1]){
//    print("CREATE MODEL");
//     print(modelData);
//     print(collectionName);
//       try{
//       collections[collectionName]["models"][modelData["id"]]=modelData;
//       await _db
//           .collection(collectionName)
//           .document(modelData["id"])
//           .setData(modelData)
//           .catchError((onError) {
//         print(onError);
//       });
//       print("DONE");
//       return;
//     }catch(e){return;}
//   }
//   /*

// DELETE

//   */
//   deleteItem({
//     @required String modelID,
//     @required String collectionName,
//   }) async {
//      print("delete");
//      try{

//         collections[collectionName]["models"].remove(modelID);
//         await _db.collection(collectionName).document(modelID).delete();
//     }catch(e){}
//   }

// /*
// UPDATE
// */
// updateModelValue({
//     @required String modelID,
//     @required String collectionName,
//     @required String fieldName,
//     @required dynamic newVal,
//   }) async {
//    //if (checkPath(collections, [collectionName, "models", modelID])[1]){
//      try{
//         collections[collectionName]["models"][modelID][fieldName]=newVal;    
//    // User ... Claim .... users .... claimsList// Get doc
//         await _db
//             .collection(collectionName)
//             .document(modelID)
//             .updateData({fieldName: newVal}).then((result) {
//           print("updated val");
//         }).catchError((onError) {
//           print("onError");
//         });
//      }catch(e){}
//      // }
//   }


//      /*
// SHEETS
//       */
// }






//    // CustomModel newOrg = CustomModel(
//       //   data:reqOrg, 
//       //   fields: dataRepo.getFields("orgs"), 
//       //   collectionName: "orgs"
//       // );
      
//      // await dataRepo.createModel(modelData: reqOrg, collectionName: "orgs");
        

// Map<String, dynamic> newOrg(Map map, String id, String now) {
//      Map<String, dynamic> out= 
//      { "id": id,
//       "isVerified": false,
//       "contactName": safeGet(key: "name", map: map, alt: ""),
//       "contactEmail": safeGet(key: "email", map: map, alt: ""),
//       "name": safeGet(key: "orgName", map: map, alt: ""),
//       "address": safeGet(key: "address", map: map, alt: ""),
//       "phone": safeGet(key: "phone", map: map, alt: ""),
//       "type": safeGet(key: "type", map: map, alt: ""),
//       "website": safeGet(key: "website", map: map, alt: ""),
//       "lat": safeGet(key: "lat", map: map, alt: null),
//       "lng": safeGet(key: "lng", map: map, alt: null),
//       "deliveryInstructions":  safeGet(key: "deliveryInstructions", map: map, alt: ""),
//       "createdAt": now,
//       "lastModified": now,
//     };
//     return out;
//     }
// Map<String, dynamic> newRequest(Map<String, dynamic> orgData, String designID,
//         int quantity, String id, String now) {
//    Map<String, dynamic> out=  {
//       "id": id,
//       "orgID": safeGet(key: "id", map: orgData, alt: ""),
//       "designID": designID,
//       "userID": safeGet(key: "userID", map: orgData, alt: ""),
//       "isVerified": false,
//       "contactName": safeGet(key: "contactName", map: orgData, alt: ""),
//       "contactEmail": safeGet(key: "contactEmail", map: orgData, alt: ""),
//       "email": safeGet(key: "email", map: orgData, alt: ""),
//       "deliveryInstructions":
//           safeGet(key: "deliveryInstructions", map: orgData, alt: ""),
//       "createdAt": now,
//       "lastModified": now,
//       "requestSource": "website",
//       "quantityRequested": quantity,
//       "isDone": false,
//     };
//     return out;
//         }
// Map<String, dynamic> newResource(Map map, String id, String groupID) => {
//       "id": generateNewID(),
//       "designID": safeGet(key: "designID", map: map, alt: ""),
//       "claimID": safeGet(key: "claimID", map: map, alt: ""),
//       "orgID": safeGet(key: "orgID", map: map, alt: ""),
//       "requestID": safeGet(key: "requestID", map: map, alt: ""),
//       "userID": safeGet(key: "userID", map: map, alt: ""),
//       "groupID":groupID,
//       "userName":safeGet(key: "name", map: map, alt: ""),
//       "createdAt": map["createdAt"],
//       "lastModified": map["lastModified"],
//       "type": "Update",
//       "quantity": (map["quantity"] is String)
//           ? int.tryParse(map["quantity"]) ?? 0
//           : map["quantity"],
//       "name": safeGet(key: "name", map: map, alt: ""),
//       "url": safeGet(key: "url", map: map, alt: ""),
//       "description": safeGet(key: "description", map: map, alt: ""),
//       "isVerified": true,
//     };

// Map<String, dynamic> newClaim(Map map, String id, String now, String groupID) => {
//       "id": id,
//       "orgID": map["orgData"]["id"],
//       "requestID": map["requestData"]["id"],
//       "designID": map["requestData"]["designID"],
//       "userID": map["id"],
//       "groupID": groupID,
//       "userName":safeGet(key: "name", map: map, alt: ""),
//       "createdAt":now,
//       "lastModified": now,
//       "isVerified": false,
//       "quantity": (map["quantity"] is String)
//           ? int.tryParse(map["quantity"]) ?? 0
//           : map["quantity"],
//     };
//  formModels: {
//         "request":FormModel(tabs:[
//           FormTabModel(formDataCallback:userInfo),
//           FormTabModel(formDataCallback: orgInfo),
//           FormTabModel(formDataCallback: requestInfo),
//           FormTabModel(formDataCallback: deliveryInfo),
//         ],
//         onSubmit: (buffer){

//         }),
//         "update":FormModel(tabs: [
//           FormTabModel(formDataCallback: updateInfo,),
//         ],
//         onSubmit: (buffer){

//         }),
//         "claim":FormModel(tabs: [
//           FormTabModel(formDataCallback: claimInfo),
//           FormTabModel(formDataCallback: claimVer),
//           FormTabModel(formDataCallback: (buf)=>nextSteps(steps: [
//           "Connection ",
//           "Delivery ",
//           "Update "
//         ])),
//       ],
//         onSubmit: (buffer){

//         }),
        
//       },

          // var dataRepo = locator<DataRepo>();
         // var groups = dataRepo.getItemsWhere("groups");
        // var designData = dataRepo.getItemByID("designs",safeGet(key: "designID", map: data, alt: 0));
       // RequestModel getRequestModel(String id){
      //   RequestModel
     // }
    //  authState = AuthState();
   // docsRepo = locator<DocsRepo>();
  //formManager = FormManager()
 //FormManager formManager;
// var formManager = locator<FormManager>();

    //dataRepo.getItemByID("users", modelID)
    //dataRepo.getItemByID("users", user["id"], addLinkMap: true);
// Map buffer = {
//   "id":generateNewID(),
//   "orgData":orgData,
//   "maxQuantity":quantityRequested-quantityClaimed,
//   "designData":designData,
//   "requestData":data,
//   "groupsData":groups
// };
//   formManager.initClaim(orgData: orgData, requestData: data, maxQuantity: quantityRequested-quantityClaimed);
// formManager.setForm("claim", );

/*
SIGN IN
*/
// Future<String> signIn(String email, String password,{GlobalKey<ScaffoldState> scaffoldKey}) async {
//   String userID =await authState.signIn(email, password, scaffoldKey: scaffoldKey);
//   loggedIn = true;
//   currentUser = dataRepo.getItemByID("users", userID);
//   setUserProfile(currentUser, isCurrentUser:true);
//   return "";
// }

/*
SIGN UP
*/
// initSignUp() {
//   buffer = {
//     "email": "",
//     "name": "",
//     "displayName": "",
//     "isVerified": false,
//   };
// }

// Future<String> signUp(
//     {GlobalKey<ScaffoldState> scaffoldKey, @required String password}) async {
//   buffer["displayName"] = buffer["name"];
//   String uid = await authState.signUp(buffer["email"],
//       scaffoldKey: scaffoldKey, password: password);
//   if (uid != null) {
//     buffer["id"] = uid;
//     await dataRepo.createModel(modelData: buffer, collectionName: "users");
//   }
//   currentUser = buffer;
//   loggedIn = true;
//   setUserProfile(currentUser, isCurrentUser:true);
//   return "";
// }

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
  //  dataRepo.collections.forEach((key, value) {
     // print(value.models.length);
   // });