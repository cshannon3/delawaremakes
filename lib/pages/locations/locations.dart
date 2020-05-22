
import 'package:delaware_makes/counters/designCounts.dart';
import 'package:delaware_makes/forms/form_manager.dart';
import 'package:delaware_makes/pages/locations/map_widget.dart';
import 'package:delaware_makes/service_locator.dart';
import 'package:delaware_makes/shared_widgets/shared_widgets.dart';
import 'package:delaware_makes/state/data_repo.dart';
import 'package:delaware_makes/utils/utility.dart';

import 'package:flutter/material.dart';
import 'package:universal_html/html.dart';
//https://dev.to/happyharis/flutter-web-google-maps-381a
//https://medium.com/funwithflutter/flutter-web-importing-html-and-javascript-flutter-1-9-c728ae9eaf2f
//https://pub.dev/packages/universal_html
//http://kml4earth.appspot.com/icons.html

Map icons={
    "fa900ce5-aae8-4a69-92c3-3605f1c9b494":"https://images.squarespace-cdn.com/content/v1/597f55aa20099e0ef5ad6f39/1588881166426-SIZUR1NVBLYOBD53YB3X/ke17ZwdGBToddI8pDm48kKAwwdAfKsTlKsCcElEApLR7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QPOohDIaIeljMHgDF5CVlOqpeNLcJ80NK65_fV7S1UY_1Meb8-Dj4GHImj6dpC0aR7O2ZKZedZTAz84fFYaQfMW9u6oXQZQicHHG1WEE6fg/Ear+Saver+Hydra+Single+%282000%29.png",
    "5f2009e0-55a8-4d4b-aa6a-a9becf5c9392":"https://lh3.googleusercontent.com/qny-IW0VZVfORmqJ4Uyc99nU3mVUW83947HgRizZsUdeVytRiW9oM_dBM31fxEaTwGsYNqeO2UBIxwp9z54GVv64=w640-h480-p"
};



class MapsPage2 extends StatefulWidget {

  const MapsPage2({Key key,}) : super(key: key);
  @override
  _MapsPage2State createState() => _MapsPage2State();
}

class _MapsPage2State extends State<MapsPage2> {
 String activeOrgID;
 bool isFaceShieldOn = true;
 bool isEarSaverOn = true;

  String selected = "List";
  FormManager formManager;
  List orgsData;
  DataRepo dataRepo;
  List<DesignModel> designs;
  List<RequestModel> requests;
  

 @override
  void initState() {
    dataRepo = locator<DataRepo>();
    formManager = locator<FormManager>();
    designs = [
      DesignModel(designID: "5f2009e0-55a8-4d4b-aa6a-a9becf5c9392", designName: "Face Shields"),
      DesignModel(designID: "fa900ce5-aae8-4a69-92c3-3605f1c9b494", designName: "Ear Savers"),
    ];
    designs.forEach((element) {
      element.init();
    });
    requests=[];
    dataRepo.getModels("requests").forEach((key, value) {
      RequestModel r = RequestModel(key);
      r.init();
      requests.add(r);
    });
    requests.sort((a,b)=>b.remaining().compareTo(a.remaining()));
    orgsData=dataRepo.getItemsWhere("orgs", getLinkedData:true, fieldFilters: {"isVerified":true});


    formManager.addListener((){
      setState(() {
         designs = [
      DesignModel(designID: "5f2009e0-55a8-4d4b-aa6a-a9becf5c9392", designName: "Face Shields"),
      DesignModel(designID: "fa900ce5-aae8-4a69-92c3-3605f1c9b494", designName: "Ear Savers"),
    ];
    designs.forEach((element) {
      element.init();
    });
         requests=[];
        dataRepo.getModels("requests").forEach((key, value) {
      RequestModel r = RequestModel(key);
      r.init();
      requests.add(r);
    });
    requests.sort((a,b)=>b.remaining().compareTo(a.remaining()));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List dropOffData =dataRepo.getItemsWhere("dropoffs");
    List pickUpData = dataRepo.getItemsWhere("pickups");
    
    
    return
         isMobile(MediaQuery.of(context).size.width) ? 
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  mainMyTabs(
                    selected: selected,
                    items: {
                      "List":(){setState(() {
                        selected="List";
                      });},
                      "Map":(){setState(() {
                        selected="Map";
                      });}}
                  ),
                  selected=="List"?optionsBar(orgsData, dropOffData, pickUpData):mapWidget(orgsData, dropOffData, pickUpData)
                ],
              ),
            ) :

              Padding(
                padding: const EdgeInsets.symmetric(horizontal:30.0),
                child: Row(children: [
                mapWidget(orgsData, dropOffData, pickUpData),
                optionsBar(orgsData, dropOffData, pickUpData)
                 ],),
              );
  }
Widget optionsBar(List orgsData,List dropOffData,List pickUpData){
  List<RequestModel> remaining = requests.where((element) => element.remaining()>0).toList();
    remaining.sort((a,b)=> b.quantityRequested.compareTo(a.quantityRequested));
    List<RequestModel> closed = requests.where((element) => element.remaining()<=0).toList();
    closed.sort((a,b)=> b.quantityRequested.compareTo(a.quantityRequested));

  return Expanded(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(children: [
            Center(
              child: Text("Open Requests",
                      style: TextStyle(
                          color: Colors.black,fontSize: 25.0,
                          decoration: TextDecoration.underline)),
            ),
        // filterBar(),
         ...remaining.map((e) => e.requestTile()),
        Center(
              child: Text("Completed",
                      style: TextStyle(
                          color: Colors.black,fontSize: 25.0,
                          decoration: TextDecoration.underline)),
            ),
             ...requests.where((element) => element.remaining()<=0).map((e) => e.requestTile()),
          ]
)));}


Widget mapWidget(List orgsData,List dropOffData,List pickUpData) =>Expanded(child: 
  Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: designs.map((e) => 
      Container(
        child: Column(children: [
          Text(e.designName,style: TextStyle(fontSize:25.0, ),),
             SizedBox(height: 5.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
       Column(
                  children: [
                    Text(e.totalQuantity.toString(), style: TextStyle(color:Colors.green, fontSize:20.0),),
                    Text("Total"),
                    Text("Made"),
                  ],
                ),
              SizedBox(width: 30.0,),
                Column(
            children: [
              Text("${e.quantityRequested-e.quantityClaimed}", style: TextStyle(color:Colors.red, fontSize:20.0),),
              Text("Open"),
              Text("Requests"),
            ],
          ), ],),],),) ).toList(),),

      Container(
                height: 500.0,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(60.0)),
                clipBehavior: Clip.antiAlias,
                child:
                     GoogleMap(orgsData: orgsData,dropOffData: dropOffData, pickupData: pickUpData,),
                  ),
    ],
  ),
          
     
      );

  Widget filterBar()=>Padding(
    padding: EdgeInsets.only(top:10.0, bottom:10.0,),
    child: Container(
         decoration: BoxDecoration(
                    border: Border.all(color:Colors.grey, width:2.0),
                    borderRadius: BorderRadius.circular(50.0)),
      child: Padding(
        padding: EdgeInsets.only(bottom:8.0),
        child: Row(children: [
           SizedBox(width: 20.0,),
          Column(
            children: [
              Checkbox(
                value: isEarSaverOn,
                onChanged: (value) {
                   isFaceShieldOn= value;
                  setState(() {});},
                activeColor: Colors.green,
              ),
              Text("Open"),
            ],
          ),
           SizedBox(width: 30.0,),
           Column(
            children: [
              Checkbox(
                value: isEarSaverOn,
                onChanged: (value) {
                   isFaceShieldOn= value;
                  setState(() {});},
                activeColor: Colors.green,
              ),
              Text("Completed"),
            ],
          ),
 Expanded(child: Container()),
           Column(
            children: [
              Checkbox(
                value: isEarSaverOn,
                onChanged: (value) {
                   isEarSaverOn = value;
                  setState(() {
                  }); }, activeColor: Colors.green,
              ),Text("Ear Savers"),
            ],
          ),
           SizedBox(width: 30.0,),
        Column(
            children: [
              Checkbox(
                value: isEarSaverOn,
                onChanged: (value) {
                   isFaceShieldOn= value;
                  setState(() {});},
                activeColor: Colors.green,
              ),
              Text("Face Shields"),
            ],
          ),
           SizedBox(width: 20.0,),
        ]),
      ),
    ),
  );
}


class RequestModel{
    final String requestID;
    String orgName;
    String orgAddress;
    String designName;
    String designID;
    int quantityRequested;
    int quantityClaimed;
    int quantityDelivered;
    Map data;
    Map orgData;
    bool isDone =false;
    bool isClaimed= false;
    List claims=[];
    List resources = [];
    RequestModel(this.requestID,);
    int remaining()=>quantityRequested-quantityDelivered;
    init(){
      quantityRequested = 0;
      quantityClaimed=0;
      quantityDelivered=0;
      var dataRepo= locator<DataRepo>();
      data = dataRepo.getItemByID("requests", requestID, addLinkMap: true);
      Map design = dataRepo.getItemByID("designs", safeGet(map:data, key:"designID", alt:""));
      designID=design["id"];
      designName=  safeGet(map: design, key:"name", alt:"Design");
      orgData= dataRepo.getItemByID("orgs", safeGet(map: data, key:"orgID", alt:""));

      orgName=  safeGet(map: orgData, key:"name", alt:"Org");
      orgAddress=  safeGet(map: orgData, key:"address", alt:"Org");
      quantityRequested=safeGet(map: data, key:"quantity", alt:0);

        Map claims = safeGet(map: data, key:"claims", alt:{});
        claims.forEach((key, value) {
        quantityClaimed+=safeGet(map: value, key:"quantity", alt:0);
        Map cdata = dataRepo.getItemByID("claims", key, addLinkMap: true);
        Map resources = safeGet(map: cdata, key:"resources", alt:{});
        resources.forEach((k, v) {
          quantityDelivered+=safeGet(map: v, key:"quantity", alt:0);
        });
      });
      isDone = quantityDelivered>=quantityRequested;
      isClaimed = quantityClaimed>=quantityRequested;
    }
    makeClaim(){
      var formManager = locator<FormManager>();
      formManager.initClaim(orgData: orgData, requestData: data, maxQuantity: quantityRequested-quantityClaimed);
      formManager.setForm("claim", resetBuffer: false);
    }
    Widget requestTile(){
      return Padding(
        padding: EdgeInsets.symmetric(vertical:10.0),
        child: ListTile(
        title:Row(
          children: [
           Tooltip(
             message: '$quantityRequested $designName Requested',
             child: Container(
                  height: 40.0,
                  width: 60.0,
                 decoration: BoxDecoration(
                        //color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5.0)),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(icons[designID]),
                ),
           ),

            Expanded(child: Column(
              children: <Widget>[
                 Text(orgName),
                 Text(orgAddress, style: TextStyle(fontSize:12.0),),
              ],
            ),),
     Column(children: [
              isDone?doneTicker():isClaimed?pendingTicker():activeTicker(),
                  Container(
                 height: 40.0,
                 child: Padding(
                   padding: EdgeInsets.all(3.0),
                   child: isClaimed?SizedBox():claimButton(),
                 ),
               ),
                ],),
          ],
          
        ),
     subtitle:Column(children:   getClaimTiles(),)

   
        ),
      );
    }

  List<Widget> getClaimTiles(){
    List<Widget> out =[];
   Map claimDataList= safeGet(key:"claims", map:data, alt:{});
    claimDataList.forEach((claimID, data) {
      out.add(claimTile(claimID));
    });
    return out;
    }
    Widget claimTile(String claimID){
      var dataRepo= locator<DataRepo>();
      Map claimData= dataRepo.getItemByID("claims", claimID, addLinkIDs: true);
      Map userData = dataRepo.getItemByID("users", safeGet(key:"userID", map:claimData, alt:{})); 
      Map groupData =dataRepo.getItemByID("groups", safeGet(key:"groupID", map:claimData, alt:""));
          bool isClaimDone = false;
    Map resourceData ={};
    String type, url;
    if(claimData["resources"].length !=0){
      isClaimDone = true;
      resourceData= dataRepo.getItemByID("resources", claimData["resources"][0]);
     // print(resourceData);
      type= safeGet(key: "type", map: resourceData, alt: "");
      url= safeGet(key: "url", map: resourceData, alt: "");
    }
    String userName = safeGet(key:"name", map:userData, alt:"User");
    if(userName=="User"){
      userName = safeGet(key:"userName", map:claimData, alt:"User");
    }
    String groupName = safeGet(key:"name", map:groupData, alt:"");
    return Container(
      child:Padding(
        padding: EdgeInsets.only(left:50.0),
        child: 
            Row(
              children: <Widget>[
                Container(
                  height: 30.0, width:30.0,
                  child:
                    Center(child: Text("${safeGet(key:"quantity", map:claimData, alt:0)}",style: TextStyle(fontSize:14.0, color: Colors.green),)),
                ),
                    Text("$userName", style: TextStyle(fontSize:12.0),),
                    Text("($groupName)", style: TextStyle(fontSize:10.0),),
                     Expanded(child: Container(),),
                     isClaimDone?SizedBox():Padding(
             padding: EdgeInsets.all(5.0),
             child:updateButton(claimData)
           ),
              ],
              
            ),
      ),
     // trailing: 
      );
    }
         Widget claimButton()=> MaterialButton(
                      height: 30,
                      minWidth: 50.0,
                      onPressed: makeClaim,
                      color: Colors.orangeAccent,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0)),
                      child: Text("Claim",
                          style:  TextStyle(color: Colors.white, fontSize: 12.0)),
            );
   Widget updateButton(Map claimData)=> MaterialButton(
                      height: 30,
                      minWidth: 50.0,
                      onPressed: (){
                        var formManager = locator<FormManager>();
                        formManager.initUpdate(claimData:claimData);
                        formManager.setForm("update", resetBuffer: false);
                        formManager.n();
                      },
                      color: Colors.orangeAccent,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0)),
                      child: Text("Update",
                          style:  TextStyle(color: Colors.white, fontSize: 12.0)),
            );
    Widget activeTicker()=>   Padding(
          padding: EdgeInsets.all(3.0),
          child:Tooltip(
            message: '${quantityRequested-quantityClaimed} unclaimed and $quantityDelivered delivered',
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border:Border.all(
                      color:Colors.red,
                      width:2
                    ), borderRadius: BorderRadius.circular(5)
                  ),
                  height: 30.0, width:40.0,
                  child: 
                    Center(child: Text("${quantityRequested-quantityClaimed}",style: TextStyle(fontSize:16.0),))
                ),
                SizedBox(width:5.0),
                 Container(
              decoration: BoxDecoration(
                border:Border.all(
                  color:Colors.green,
                  width:2
                ), borderRadius: BorderRadius.circular(20)
              ),
              height: 40.0, width:40.0,
              child:
                Center(child: Text("$quantityDelivered",style: TextStyle(fontSize:16.0),)),
            ),
              ],
            ),
          ),
        );
        Widget pendingTicker()=>   Padding(
          padding: EdgeInsets.all(3.0),
          child: Tooltip(
            message: '$quantityClaimed claimed but not yet delivered',
            child: Container(
              decoration: BoxDecoration(
                border:Border.all(
                  color:Colors.yellow[500],
                  width:2
                ), borderRadius: BorderRadius.circular(20)
              ),
              height: 40.0, width:40.0,
              child: Center(child: Text("$quantityClaimed",style: TextStyle(fontSize:16.0),)),
            ),
          ),
        );
        Widget doneTicker()=>   Padding(
          padding: EdgeInsets.all(3.0),
          child: Tooltip(
            message: '$quantityDelivered delivered',
            child: Container(
              decoration: BoxDecoration(
                border:Border.all(
                  color:Colors.green,
                  width:2
                ), borderRadius: BorderRadius.circular(20)
              ),
              height: 40.0, width:40.0,
              child:
                Center(child: Text("$quantityDelivered",style: TextStyle(fontSize:16.0),)),
            ),
          ),
        );
}




