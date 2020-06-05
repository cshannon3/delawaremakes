
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delaware_makes/utils/utils.dart';
import 'package:flutter/material.dart';
/*
Linked are explicit links 1-to-1 ex data has orgID
associated are dynamic links, need to search models for where this id is present

onetoone stores only the info that is added(ex org-name)
one to many stores the list of ids, by collection name,
both only store the ones that are added

get val can either be getting direct val or linked vals but doesn't look up links
in = > {fieldname:altVal}
out =>fieldName 


get vals gets a list of vals
*/


class CustomModel{
  final Map data;
  final Map fields;
  final String collectionName;
  Map oneToOneData={};
  Map oneToManyData={};

  CustomModel({
    @required this.data, 
    @required this.fields,
    @required this.collectionName});
  String get id =>data["id"];

 dynamic getVal(String key, {String collection, dynamic alt, bool associated=false}){
   // searches original data + linked
   if(key==null)return alt;
   if(associated)return safeGet(key: key, map: oneToManyData, alt: []);
   if(collection==null)return safeGet(key: key, map: data, alt: alt);
   return safeGetPath(oneToOneData,[collection, key]); // liked data => collectionName->fieldName
  // return alt;
  }
  /*map input == key, alt
map output = key, val*/
  Map getVals(Map fieldAltMap){
    Map out = {};
    fieldAltMap.forEach((fieldName, alt) {
      if(oneToOneData.containsKey(fieldName) && alt is Map){
        alt.forEach((linkedFieldName, linkedAlt) {
          out[fieldName][linkedFieldName]=getVal(linkedFieldName, collection: fieldName, alt: linkedAlt);
        });
      }
      else out[fieldName]= getVal(fieldName, alt:alt);
    });
    return out;
  }

// put in ["requests", "quantity"] -> [q1, q2, q3]
addAssociatedIDs({
    @required String otherCollectionName,
    @required Function(CustomModel self , String otherCollectionName) getOneToMany, 
}){
  if(!oneToManyData.containsKey(otherCollectionName)){
      oneToManyData[otherCollectionName]=getOneToMany(this, otherCollectionName);
     // print(oneToManyData[otherCollectionName]);
  }
}
  List getAssociatedVals({
    @required String otherCollectionName,
    @required String fieldName,
    @required Function(CustomModel self , String otherCollectionName) getOneToMany, 
    @required Function(CustomModel self,String otherCollectionName, String field) idsToVals,
    bool reset=false}){
    // first check one to many to see if already queried
    addAssociatedIDs(otherCollectionName: otherCollectionName, getOneToMany: getOneToMany);
    // Now I have a list of ids, want to swap id list w/ value list
    var vals =idsToVals(this, otherCollectionName, fieldName);
    return vals;

  }

  bool checkMatch(Map filters){
    bool good =true;
    filters.forEach((fieldName, filterVal) {
        dynamic val = good? getVal(fieldName):null;
        if(val==null)good=false;
       // else if(filterVal is List && !(val is List)) good = filterVal.contains(val);
        else good = (filterVal==val);
      });
    return good;
  }
bool checkLink(String collectionName, String id){
    return getVal(_getLinkedField(collectionName), alt: "")==id;
}


// field alt
// get org Name and address ex
bool addMultipleLinkedVals({
   @required Map linkedData,
   @required Function(String, String) getItemByID}){
 //ex addLinkedVals("orgID", {"name":"", "address":""}, DataRepo repo)
  bool allGood= true;
 linkedData.forEach((fieldName, linkedFieldVals) {
    bool good = addLinkedVals(
     fieldName: fieldName, 
     linkedFieldVals: linkedFieldVals, 
     getItemByID: getItemByID);
     allGood = good && allGood;

   });
    return allGood;
  }

bool addLinkedVals({
  @required String fieldName,
   @required Map linkedFieldVals,
   @required Function(String, String) getItemByID}){
 //ex addLinkedVals("orgID", {"name":"", "address":""}, DataRepo repo)
    // ex orgID
   // print("FFFFFF");
   // print(fieldName);print(linkedFieldVals);
    CustomModel m;
    var linkID = getVal(fieldName);
    String collectionName = _getLinkedCollection(fieldName);
  //  print(collectionName);
   // print(linkID);
    if(collectionName==null)return false;
    if(!oneToOneData.containsKey(collectionName)){
      oneToOneData[collectionName]={};
    }
    if(linkID!=null) m = getItemByID(collectionName, linkID);
   // print(m.data);
   // add the alts return "not found"
    if(linkID==null ||m==null){ 
      linkedFieldVals.forEach((key, alt) {oneToOneData[collectionName][key]=alt;});
     // print("NOT FOUND");
      return false;
    }
      // get vals
     // print("MMMM");
    //  print(m.data);
    m.getVals(linkedFieldVals).forEach((key, value) {
      oneToOneData[collectionName][key]=value;
    });
    return true;
  }

  String _getLinkedCollection(String fieldName){
    if(!fields.containsKey(fieldName))return null;
    try{
      if(fields[fieldName]["type"].contains("ForeignKey"))return fields[fieldName]["typeInfo"];
      return null;
    }catch(e){
      return null;
    }
  }
  String _getLinkedField(String collectionName){
   // print(collectionName);
    String hit;
    fields.forEach((key, value) {
       if(safeGet(key:"typeInfo", map: value, alt: "" )==collectionName){
         hit= key;
        // print(hit);
       }
    });
    return hit;
  }
Future<bool> createModel({
    @required Firestore db,
    }) async { 
   print("CREATE MODEL");
    print(data); print(collectionName);
      try{
      await db
          .collection(collectionName)
          .document(id)
          .setData(data)
          .catchError((onError) {
        print(onError);
      });
      print("DONE");
      return true ;
    }catch(e){return false;}
  }
  /*

DELETE

  */
  deleteItem({
    @required Firestore db,
  }) async {print("delete");
     try{ await db.collection(collectionName).document(id).delete();
    }catch(e){}
  }

/*
UPDATE
*/

updateModelValue({
    @required Firestore db,
    @required String fieldName,
  }) async {
        await db
            .collection(collectionName)
            .document(id)
            .updateData({fieldName: getVal(fieldName)}).then((result) {
          print("updated val");
        }).catchError((onError) {
          print("onError");
        });
  }
}

/*
links 


*/