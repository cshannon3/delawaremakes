/*
This is an additional class to help handle and keep track of data associations
*/


import 'package:delaware_makes/counters/counters.dart';
import 'package:domore/domore.dart';

class DBInterface{
  final DataRepo dataRepo;

  DBInterface(this.dataRepo);

  DesignModelCount getDesignCount(String designID){
      int quantityRequested = 0;
      int quantityClaimed=0;
      int quantityDelivered=0;
     

      CustomModel des = dataRepo.getItemByID("designs", designID);
     String designName =des.getVal("name");
     List ck= des.getAssociatedVals(
        otherCollectionName: "claims", 
        fieldName: "quantity", 
        getOneToMany: dataRepo.getOneToMany, 
        idsToVals: dataRepo.idsToVals);
        ck.forEach((quant) { 
          if(quant is String)quant=int.tryParse(quant)??0;
          try{ quantityClaimed+=quant;}catch(e){print("err");}
        });
        des.getAssociatedVals(
          otherCollectionName: "requests", 
          fieldName: "quantity", 
          getOneToMany: dataRepo.getOneToMany, 
          idsToVals: dataRepo.idsToVals)
          .forEach((quant) { 
            if(quant is String)quant=int.tryParse(quant)??0;
           try{ quantityRequested+=quant;}catch(e){}
          });
        des.getAssociatedVals(
        otherCollectionName: "resources", 
        fieldName: "quantity", 
        getOneToMany: dataRepo.getOneToMany, 
        idsToVals: dataRepo.idsToVals)
        .forEach((quant) { 
          if(quant is String)quant=int.tryParse(quant)??0;
          try{ quantityDelivered+=quant;}catch(e){}
        });
        return DesignModelCount(
          designID: designID, 
          designName: designName,
          quantityClaimed: quantityClaimed,
          quantityDelivered: quantityDelivered,
          quantityRequested: quantityRequested);
    }
  


    RequestModelCount getRequestModelCount(String requestID){
      int quantityRequested = 0;
      int quantityClaimed=0;
      int quantityDelivered=0;
      CustomModel _request = dataRepo.getItemByID("requests", requestID);

      _request.addAssociatedIDs(otherCollectionName: "resources", getOneToMany: dataRepo.getOneToMany);
      _request.addMultipleLinkedVals(
        linkedData: {
          "designID":{"id":"", "name":"" },
          "orgID":{"id":"", "name":"",  "address":"" },
        },
        getItemByID: dataRepo.getItemByID
        );
      quantityRequested=_request.getVal("quantity", alt:0);
        bool isVerified = _request.getVal("isVerified", alt:false);
       _request.getAssociatedVals(
         otherCollectionName: "claims",
         fieldName: "quantity", 
         getOneToMany: dataRepo.getOneToMany,
         idsToVals: dataRepo.idsToVals
         ).forEach((quant) {
           if(quant is String)quant=int.tryParse(quant)??0;
           quantityClaimed+=quant;
         });
         _request.oneToManyData["claims"].forEach((claimID){
           dataRepo.getItemByID("claims", claimID).getAssociatedVals(
             otherCollectionName: "resources", 
             fieldName: "quantity", 
             getOneToMany:dataRepo.getOneToMany, idsToVals: dataRepo.idsToVals
           
             ).forEach((rquant) {
               if(rquant is String)rquant=int.tryParse(rquant)??0;
              quantityDelivered+=rquant;
             });
         });
     
      return RequestModelCount(
        requestID: requestID,
        isClaimed: quantityClaimed>=quantityRequested,
        isDone: quantityDelivered>=quantityRequested,
        isVerified: isVerified,
        quantityRequested: quantityRequested,
        quantityClaimed: quantityClaimed,
        quantityDelivered: quantityDelivered,
      );
    }


}