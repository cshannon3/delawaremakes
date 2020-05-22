


import 'package:delaware_makes/service_locator.dart';
import 'package:delaware_makes/state/data_repo.dart';
import 'package:delaware_makes/utils/utils.dart';
import 'package:flutter/material.dart';

class DesignModel{
    final String designID;
    String designName;
    int quantityRequested;
    int quantityClaimed;
    int quantityDelivered;
    int totalQuantity;
    
    DesignModel({
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
      Map des = dataRepo.getItemByID("designs", designID, addLinkMap: true);
      designName = safeGet(map: des, key:"name", alt:"");
      Map requests = safeGet(map: des, key:"requests", alt:{});
      requests.forEach((key, value) {
        quantityRequested+=safeGet(map: value, key:"quantity", alt:0);
      });
      Map claims = safeGet(map: des, key:"claims", alt:{});
      claims.forEach((key, value) {
        quantityClaimed+=safeGet(map: value, key:"quantity", alt:0);
      });
      Map resources = safeGet(map: des, key:"resources", alt:{});
      resources.forEach((key, value) {
       totalQuantity+=safeGet(map: value, key:"quantity", alt:0);
      });
      // print(designName);
      // print(quantityRequested);
      // print(quantityClaimed);
      // print(totalQuantity);
    }
}
