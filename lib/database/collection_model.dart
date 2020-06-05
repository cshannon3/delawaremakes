
import 'database.dart';

class CollectionModel {
 final Map fields;
 final String collectionName;
 final String name;
 final String sheetName;
 Map<String, CustomModel> models;

CollectionModel.fromMap(Map<String, dynamic> data):
  this.fields=data["fields"],
  this.collectionName=data["collectionName"],
  this.name=data["name"],
  this.sheetName=data["sheetName"],
  this.models = {};

 CustomModel addModel(Map<String, dynamic> data){
    CustomModel cm= CustomModel(
     data:data,
     fields: fields,
     collectionName: collectionName
     );
     models.putIfAbsent(data["id"], () => cm);
     return cm;
 }
 List getLinks(String collectionName, String id){
   List out=[];
   models.forEach((key, value) {
     if(value.checkLink(collectionName, id))out.add(key);
   });
   return out;
 }


 List<CustomModel> getModelsWhere(Map filters) {
   //print(filters);
   return (filters==null)?models.values.toList():
   models.values.where((element) => element.checkMatch(filters)).toList();
 }
 CustomModel getByID(String id)=>models.containsKey(id)?models[id]:null;


}