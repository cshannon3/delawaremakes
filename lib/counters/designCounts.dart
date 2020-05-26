
import 'package:delaware_makes/state/state.dart';
import 'package:delaware_makes/utils/utils.dart';
import 'package:domore/state/custom_model.dart';
import 'package:domore/state/new_data_repo.dart';
import 'package:flutter/material.dart';

class DesignModelCount{
    final String designID;
    String designName;
    int quantityRequested;
    int quantityClaimed;
    int quantityDelivered;
    int totalQuantity;
    
    DesignModelCount({
      @required this.designID, 
      this.designName,
      this.quantityRequested=0, 
      this.quantityClaimed=0, 
      this.quantityDelivered=0});

    init(){
      quantityRequested = 0;
      quantityClaimed=0;
      quantityDelivered=0;
      totalQuantity=0;
      var dataRepo= locator<DataRepo>();
      CustomModel des = dataRepo.getItemByID("designs", designID);
      designName = des.getVal("name", alt:"");

     List ck= des.getAssociatedVals(
        otherCollectionName: "claims", 
        fieldName: "quantity", 
        getOneToMany: dataRepo.getOneToMany, 
        idsToVals: dataRepo.idsToVals);
        print(ck);
        ck.forEach((quant) { 
          if(quant is String)quant=int.tryParse(quant)??0;
          try{ quantityClaimed+=quant;}catch(e){print("err");}
        });
        print(quantityClaimed);
        des.getAssociatedVals(
          otherCollectionName: "requests", 
          fieldName: "quantity", 
          getOneToMany: dataRepo.getOneToMany, 
          idsToVals: dataRepo.idsToVals)
          .forEach((quant) { 
            if(quant is String)quant=int.tryParse(quant)??0;
           try{ quantityRequested+=quant;}catch(e){}
          });
       // print(quantityRequested);

        des.getAssociatedVals(
        otherCollectionName: "resources", 
        fieldName: "quantity", 
        getOneToMany: dataRepo.getOneToMany, 
        idsToVals: dataRepo.idsToVals)
        .forEach((quant) { 
         // print(quant);
          if(quant is String)quant=int.tryParse(quant)??0;
          try{ quantityDelivered+=quant;}catch(e){}
        });
        print("QUANTITY DELIVERED");
      print(quantityDelivered);
      //safeGet(map: des, key:"name", alt:"");
     
    }
}


//  Map requests = safeGet(map: des, key:"requests", alt:{});
//       des.getVal("claims", associated:true, alt:[]).forEach((key, value) {
//         quantityRequested+=safeGet(map: value, key:"quantity", alt:0);
//       });
//       Map claims = safeGet(map: des, key:"claims", alt:{});
//       claims.forEach((key, value) {
//         quantityClaimed+=safeGet(map: value, key:"quantity", alt:0);
//       });
//       Map resources = safeGet(map: des, key:"resources", alt:{});
//       resources.forEach((key, value) {
//        totalQuantity+=safeGet(map: value, key:"quantity", alt:0);
//       });