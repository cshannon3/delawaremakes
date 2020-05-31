
// import 'package:delaware_makes/state/state.dart';
// import 'package:delaware_makes/utils/utils.dart';
// import 'package:domore/state/custom_model.dart';
// import 'package:domore/state/new_data_repo.dart';
// import 'package:flutter/material.dart';

// class GroupModelCount{
//     final String groupID;
//     String groupName;
//     String designName;
//     int earSaversDelivered;
//     int faceShieldsDelivered;
    
//     GroupModelCount({
//       @required this.groupID, 
//       this.designName,
//       this.earSaversDelivered=0, 
//       this.faceShieldsDelivered=0, });

//     init(){
//       earSaversDelivered = 0;
//       faceShieldsDelivered=0;
//       var dataRepo= locator<DataRepo>();
//       CustomModel group = dataRepo.getItemByID("groups", groupID);
//       group.addAssociatedIDs(otherCollectionName: "designs", getOneToMany: dataRepo.getOneToMany);
      
//       CustomModel des = dataRepo.getItemByID("designs", designID);
//       designName = des.getVal("name", alt:"");

//      List ck= des.getAssociatedVals(
//         otherCollectionName: "claims", 
//         fieldName: "quantity", 
//         getOneToMany: dataRepo.getOneToMany, 
//         idsToVals: dataRepo.idsToVals);
//         print(ck);
//         ck.forEach((quant) { 
//           if(quant is String)quant=int.tryParse(quant)??0;
//           try{ quantityClaimed+=quant;}catch(e){print("err");}
//         });
//         print(quantityClaimed);
//         des.getAssociatedVals(
//           otherCollectionName: "requests", 
//           fieldName: "quantity", 
//           getOneToMany: dataRepo.getOneToMany, 
//           idsToVals: dataRepo.idsToVals)
//           .forEach((quant) { 
//             if(quant is String)quant=int.tryParse(quant)??0;
//            try{ quantityRequested+=quant;}catch(e){}
//           });
//        // print(quantityRequested);

//         des.getAssociatedVals(
//         otherCollectionName: "resources", 
//         fieldName: "quantity", 
//         getOneToMany: dataRepo.getOneToMany, 
//         idsToVals: dataRepo.idsToVals)
//         .forEach((quant) { 
//          // print(quant);
//           if(quant is String)quant=int.tryParse(quant)??0;
//           try{ quantityDelivered+=quant;}catch(e){}
//         });
//         print("QUANTITY DELIVERED");
//       print(quantityDelivered);
//       //safeGet(map: des, key:"name", alt:"");
     
//     }
// }