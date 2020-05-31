

//     init(DataRepo dataRepo){
//       quantityRequested = 0;
//       quantityClaimed=0;
//       quantityDelivered=0;
//       CustomModel _request = dataRepo.getItemByID("requests", requestID);


//       _request.addAssociatedIDs(otherCollectionName: "resources", getOneToMany: dataRepo.getOneToMany);
//      // print("dRD");
//    //   print(request.oneToOneData[ "resources"].length);
//       _request.addMultipleLinkedVals(
//         linkedData: {
//           "designID":{"id":"", "name":"" },
//           "orgID":{"id":"", "name":"",  "address":"" },
//         },
//         getItemByID: dataRepo.getItemByID
//         );
// //print(request.getVal("name",collection:"orgs"));
//       quantityRequested=_request.getVal("quantity", alt:0);
//        isVerified = _request.getVal("isVerified", alt:false);
//        _request.getAssociatedVals(
//          otherCollectionName: "claims",
//          fieldName: "quantity", 
//          getOneToMany: dataRepo.getOneToMany,
//          idsToVals: dataRepo.idsToVals
//          ).forEach((quant) {
//            if(quant is String)quant=int.tryParse(quant)??0;
//            quantityClaimed+=quant;
//          });
//         // print(quantityClaimed);

//          _request.oneToManyData["claims"].forEach((claimID){
//            dataRepo.getItemByID("claims", claimID).getAssociatedVals(
//              otherCollectionName: "resources", 
//              fieldName: "quantity", 
//              getOneToMany:dataRepo.getOneToMany, idsToVals: dataRepo.idsToVals
           
//              ).forEach((rquant) {
//                if(rquant is String)rquant=int.tryParse(rquant)??0;
//               quantityDelivered+=rquant;
//              });
//          });
//       isDone = quantityDelivered>=quantityRequested;
//       isClaimed = quantityClaimed>=quantityRequested;
    
//     }
     // var dataRepo= locator<DataRepo>();
      //print(_request.oneToOneData);

         //print(quantityDelivered);




      // var dataRepo= locator<DataRepo>();
      // Map claimData= dataRepo.getItemByID("claims", claimID, addLinkIDs: true);
      // Map userData = dataRepo.getItemByID("users", safeGet(key:"userID", map:claimData, alt:{})); 
      // Map groupData =dataRepo.getItemByID("groups", safeGet(key:"groupID", map:claimData, alt:""));


    // final String orgName;
    // final String orgAddress;
    // String designName;
    // String designID;
  // Map data;
    // Map orgData;

  // makeClaim(){

    // }
    // Widget requestTile(){
    //   String designID =request.getVal("id", collection:"designs");
    //   String designName = request.getVal("name", collection:"designs");
    //   String orgName =request.getVal("name", collection:"orgs");
    //   String orgAddress = request.getVal("address", collection:"orgs");

    //   String url =   safeGet(key:  designID, map: icons, alt:placeHolderUrl);

    //   return Padding(
    //     padding: EdgeInsets.symmetric(vertical:10.0),
    //     child: ListTile(
    //     title:Row(
    //       children: [
    //        Tooltip(
    //          message: '$quantityRequested $designName Requested',
    //          child: Container(
    //               height: 40.0,
    //               width: 60.0,
    //              decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(5.0)),
    //                 clipBehavior: Clip.antiAlias,
    //                 child: Image.network(url),
    //             ),
    //        ),

    //         Expanded(child: Column(
    //           children: <Widget>[
    //              Text(orgName),
    //              Text(orgAddress, style: TextStyle(fontSize:12.0),),
    //           ],
    //         ),),
    //  Column(children: [
    //           isDone?DoneTicker(
    //             quantityDelivered: quantityDelivered,
    //           ):isClaimed?PendingTicker(
    //             quantityClaimed: quantityClaimed,
    //           ):ActiveTicker(
    //             quantityDelivered: quantityDelivered,
    //             quantityClaimed: quantityClaimed,
    //             quantityRequested: quantityRequested,
    //           ),
    //               Container(
    //              height: 40.0,
    //              child: Padding(
    //                padding: EdgeInsets.all(3.0),
    //                child: isClaimed?SizedBox():claimButton(),
    //              ),
    //            ),
    //             ],),
    //       ],
          
    //     ),
    //  subtitle:Column(children:   getClaimTiles(),)
    //     ),
    //   );
    // }



  //  
  //   Map resourceData ={};
  // //  String type, url;
  //   if(claimData["resources"].length !=0){
  //     isClaimDone = true;
  //     resourceData= dataRepo.getItemByID("resources", claimData["resources"][0]);
  //   }
  //   String userName = safeGet(key:"name", map:userData, alt:"User");
  //   if(userName=="User"){
  //     userName = safeGet(key:"userName", map:claimData, alt:"User");
  //   }
  //   String groupName = safeGet(key:"name", map:groupData, alt:"");




      //   Map claims = safeGet(map: data, key:"claims", alt:{});
      //   claims.forEach((key, value) {
      //   quantityClaimed+=safeGet(map: value, key:"quantity", alt:0);
      //   Map cdata = dataRepo.getItemByID("claims", key, addLinkMap: true);
      //   Map resources = safeGet(map: cdata, key:"resources", alt:{});
      //   resources.forEach((k, v) {
      //     quantityDelivered+=safeGet(map: v, key:"quantity", alt:0);
      //   });
      // });
     // Map design = dataRepo.getItemByID("designs", safeGet(map:data, key:"designID", alt:""));
     // orgData= dataRepo.getItemByID("orgs", safeGet(map: data, key:"orgID", alt:""));
     // designID=design["id"];
      //designName=  safeGet(map: design, key:"name", alt:"Design");
     // orgName=  safeGet(map: orgData, key:"name", alt:"Org");
     // orgAddress=  safeGet(map: orgData, key:"address", alt:"Org");
      
      //safeGet(map: data, key:"quantity", alt:0);

//Widget updateButton(Map claimData)=> MaterialButton(
  //                     height: 30,
  //                     minWidth: 50.0,
  //                     onPressed: (){
  //                         var formManager = locator<FormManager>();
  //                     //  formManager.initUpdate(claimData:claimData);
  //                     //   buffer = {}; print(claimData);
  //                         var dataRepo = locator<DataRepo>();
  //                         var groups = dataRepo.getItemsWhere("groups");
  //                       // print(groups); //  data
  //                         Map buffer={
  //                           "claimID": claimData["id"],
  //                           "quantity":safeGet(key: "quantity", map: claimData, alt: 0),
  //                           "orgID":safeGet(key: "orgID", map: orgData, alt: ""),
  //                           "designID":safeGet(key: "designID", map: claimData, alt: ""),
  //                           "requestID":safeGet(key: "requestID", map: claimData, alt: ""),
  //                           "groupsData":groups
  //                       };
  //                       formManager.setForm("update", buffer: buffer);
  //                       formManager.n();
  //                     },
  //                     color: Colors.orangeAccent,
  //                     textColor: Colors.white,
  //                     shape: RoundedRectangleBorder(
  //                         borderRadius: new BorderRadius.circular(18.0)),
  //                     child: Text("Update",
  //                         style:  TextStyle(color: Colors.white, fontSize: 12.0)),
  //           );

    // Widget activeTicker()=>   Padding(
    //       padding: EdgeInsets.all(3.0),
    //       child:Tooltip(
    //         message: '${quantityRequested-quantityClaimed} unclaimed and $quantityDelivered delivered',
    //         child: Row(
    //           children: [
    //             Container(
    //               decoration: BoxDecoration(
    //                 border:Border.all(
    //                   color:Colors.red,
    //                   width:2
    //                 ), borderRadius: BorderRadius.circular(5)
    //               ),
    //               height: 30.0, width:40.0,
    //               child: 
    //                 Center(child: Text("${quantityRequested-quantityClaimed}",style: TextStyle(fontSize:16.0),))
    //             ),
    //             SizedBox(width:5.0),
    //              Container(
    //           decoration: BoxDecoration(
    //             border:Border.all(
    //               color:Colors.green,
    //               width:2
    //             ), borderRadius: BorderRadius.circular(20)
    //           ),
    //           height: 40.0, width:40.0,
    //           child:
    //             Center(child: Text("$quantityDelivered",style: TextStyle(fontSize:16.0),)),
    //         ),
    //           ],
    //         ),
    //       ),
    //     );


        // Widget doneTicker()=>   Padding(
        //   padding: EdgeInsets.all(3.0),
        //   child: Tooltip(
        //     message: '$quantityDelivered delivered',
        //     child: Container(
        //       decoration: BoxDecoration(
        //         border:Border.all(
        //           color:Colors.green,
        //           width:2
        //         ), borderRadius: BorderRadius.circular(20)
        //       ),
        //       height: 40.0, width:40.0,
        //       child:
        //         Center(child: Text("$quantityDelivered",style: TextStyle(fontSize:16.0),)),
        //     ),
        //   ),
        // );
       
        //   Widget pendingTicker()=>   Padding(
        //   padding: EdgeInsets.all(3.0),
        //   child: Tooltip(
        //     message: '$quantityClaimed claimed but not yet delivered',
        //     child: Container(
        //       decoration: BoxDecoration(
        //         border:Border.all(
        //           color:Colors.yellow[500],
        //           width:2
        //         ), borderRadius: BorderRadius.circular(20)
        //       ),
        //       height: 40.0, width:40.0,
        //       child: Center(child: Text("$quantityClaimed",style: TextStyle(fontSize:16.0),)),
        //     ),
        //   ),
        // );