
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delaware_makes/database/database.dart';
import 'package:flutter/material.dart';

import 'custom_model.dart';

// Data Repo Grabs the Google Sheet of interest,
// Gets the collections data from firebase
// passes down the relavent worksheet to each Custom Collection
//checks to see if needs to update collections data based on firebase or
// if needs to show any, updates sheet Gets collections from firebase
// todo avoid infinite recursion


class DataRepo {
  //final// = GManager(secrets.credentials);
  final Firestore _db;
  DataRepo(this._db);
  Map<String, CollectionModel> collections = {};
  Map<String, bool> colCount = {};
  bool hasDesigns = false;
/*
Firebase Initializers
*/
  Future<String> initialize() async {
    print("start"); // Gets spreadsheet
    // _db = Firestore.instance; // Get collections
    await loadMetadata();
    return "";
  }

  loadMetadata() async {
    colCount = {};
    Firestore.instance.collection("metadata").snapshots().listen((onData) {
      onData.documents.forEach((dataItem) {
        if (dataItem.data != null) {
          Map<String,dynamic> map = dataItem.data;
          collections[map["collectionName"]] = CollectionModel.fromMap(map);
          _loadFromFirebase(map["collectionName"]); // colCount[c]=true;
        }
      });
    });
  }
  loadCollectionsFromFirebase() async {
    colCount = {};
    collections.forEach((collectionName, collectionData) async {
      await _loadFromFirebase(collectionName);
    });
  }

  _loadFromFirebase(String c) async {
     //  print(c);
    Firestore.instance.collection(c).snapshots().listen((onData) {
      onData.documents.forEach((dataItem) {
        if (dataItem.data != null) {
          collections[c].addModel(dataItem.data);  // print(collections[c]);
          
          colCount[c] = true;
        }
      });
    });
    await Future.delayed(Duration(milliseconds: 20));
  }

// Checks

  bool collectionExists(String col) => collections.containsKey(col);
  Map getFields(String col)=>collectionExists(col)?collections[col].fields:{};

  Map<String, CustomModel> getModels(String collectionName) =>
    collectionExists(collectionName)?collections[collectionName].models:{};
 
  List<CustomModel> getItemsWhere(String collectionName, {Map<String, dynamic> fieldFilters}) =>
    collectionExists(collectionName)?collections[collectionName].getModelsWhere(fieldFilters): [];

  CustomModel getItemByID(String collectionName,String modelID)=>
      (modelID==null || modelID=="")? null 
      : collectionExists(collectionName)? collections[collectionName].getByID(modelID):null;
    
    List getOneToMany(CustomModel customModel,String collectionName){
      if (!collectionExists(collectionName))return [];
      
    //  print(customModel.id);
      return collections[collectionName].getLinks(customModel.collectionName, customModel.id);
    }
    List idsToVals(CustomModel customModel, String collectionName, String fieldName){
      if (!collectionExists(collectionName))return [];
      List out=[];
      customModel.oneToManyData[collectionName].forEach((var id){
       // print(id);
        var val = collections[collectionName].getByID(id).getVal(fieldName);
        if(val!=null)out.add(val);
      });
      return out;
    }
/*
FIREBASE
*/
Future<CustomModel> getModelFromFirestore({
    @required String modelID,
    @required String collectionName,
  }) async {
    DocumentSnapshot document =
        await _db.collection(collectionName).document(modelID).get();
   return CustomModel(
      data:document.data,
      collectionName: collectionName,
      fields: collections[collectionName].fields
       );
  }


  Future<CustomModel> addModel({
    @required Map<String,dynamic> data,
    @required String collectionName,
    @required bool saveToFirebase
    }) async{

      if(!collectionExists(collectionName))return null;
      CustomModel newModel = collections[collectionName].addModel(data);
      if(newModel==null)return null;
      if(saveToFirebase) await newModel.createModel(db: _db);
      
      return newModel;
  }


  
  /* 
CREATE
*/
 
     /*
SHEETS
      */
}


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

// Map getLinkedInfo(String collectionName,String , String fieldName, Map linkedData){
//   Map res=linkedData??{};
//   List collection = checkPath(collections, [collectionName, "fields", fieldName, "typeInfo"]);
//   if(collection[1])return {};

//   collections[collectionName]["fields"]
//   .forEach((fieldName, fieldData){
//         var type= safeGet(key:"type", map:fieldData, alt: "");
//         var typeInfo = safeGet(key:"typeInfo", map:fieldData, alt:"" );
//         if(type=="ForeignKey" && modelData.containsKey(fieldName)){
//           res[fieldName]=checkPath(collections, [typeInfo, "models", modelData[fieldName]])[1]??{};
//         }
//   });
//   return res;
// }
  // models.forEach((modelData) {
  //      bool good = true;
  //      if(fieldFilters!=null){
  //       fieldFilters.forEach((fieldName, value) {
  //         var val = safeGet(key: fieldName, map: modelData, alt: null);
  //         if(val==null || val!=value){ good=false; }
  //       });
  //      }

  //      if(good){
  //        res.add((getLinkedData ||getLinkedID)
  //             ?_addLinkedData(collectionName, modelData["id"], modelData, onlyIDs: getLinkedID, )
  //             :modelData);
  //      }
  // });


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
// Converts list of ids into the data


//  Future createModel({@required Map<String, dynamic> modelData,
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

