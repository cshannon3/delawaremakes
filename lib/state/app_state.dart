import 'dart:convert';

import 'package:delaware_makes/counters/counters.dart';
import 'package:delaware_makes/integrations/slack/slack_src.dart';
import 'package:delaware_makes/state/db_interface.dart';
import 'package:delaware_makes/state/form_tabs.dart';
import 'package:delaware_makes/state/state.dart';
import 'package:delaware_makes/utils/constant.dart';
import 'package:delaware_makes/utils/secrets.dart';
import 'package:domore/domore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:delaware_makes/utils/utils.dart';
import 'package:http/http.dart' as http;

const int numCollections = 9;
class AppState extends ChangeNotifier {
  CustomModel currentUser, userProfileData;
  bool loggedIn = false;
  bool isReady = false;
  bool isFormActive = false;
  bool isLoginActive=false;
  DataRepo dataRepo;
  Size _size;
  FormModel currentFormModel;
  AuthState authState;
  String overlay = "";
  AppState();
  bool loading=false;

  List<DesignModelCount> designs;
  List<RequestModelCount> requests;
  Map<String, OrgModelCount> orgModels = {};

  
  CustomModel getProfileData() => userProfileData ?? null;

  init() {
    dataRepo = locator<DataRepo>();
  }
  setSize(Size newSize){
    _size = newSize;
  }
  bool isMobile()=>(_size!=null && _size.width<=650);
  bool hideAppBar()=>(_size!=null && isFormActive&& _size.height<=800.0);
  bool isFullViewForm()=>(_size!=null && isFormActive&& _size.height<=800.0);

  getAll({bool reinitialize = false}) async {
    if (reinitialize) {
      await dataRepo.loadCollectionsFromFirebase();
    }
    while (dataRepo.colCount.length < numCollections) {
      await Future.delayed(Duration(milliseconds: 10));
      if (debug) {
        print("getAll");
        print(dataRepo.colCount);
        print(dataRepo.collections.length);
        print("Wait");
      }
    }
    initDesigns();
    initRequests();
    isReady = true;

    notifyListeners();
  }


 initLogin(){isLoginActive=true; notifyListeners();}

  onSignIn(User firebaseUser, bool isSignUp){
      if(isSignUp){}
      else currentUser = dataRepo.getItemByID("users", firebaseUser.uid);

    isLoginActive=false;
    userProfileData = currentUser;
    if(currentUser!=null)loggedIn=true;
  
    notifyListeners();
  }

   onFormClose(){
      isLoginActive=false;
      notifyListeners();
  }

  bool isCurrentUser() {
    if (currentUser == null || userProfileData == null) return false;
    if (userProfileData.id != currentUser.id) return false;
    return true;
  }

  bool isUserAdmin() {
    if (currentUser == null) return false;
    return currentUser.getVal("isAdmin", alt: false);
  }

  bool setUserProfile(CustomModel user, {bool isCurrentUser = false}) {
    userProfileData = user;
    if (isCurrentUser) currentUser = userProfileData;
    return true;
  }

  logout() {
    currentUser = null;
    loggedIn = false;
  }



List<DesignModelCount> initDesigns(){
    designs = [];
    DBInterface i = DBInterface(dataRepo);
    designs.add(i.getDesignCount( "5f2009e0-55a8-4d4b-aa6a-a9becf5c9392"));
    designs.add(i.getDesignCount("fa900ce5-aae8-4a69-92c3-3605f1c9b494"));  
    return designs;
  }

initRequests(){
      DBInterface i = DBInterface(dataRepo);
      orgModels = {};
      requests = [];
      dataRepo.getModels("requests").forEach((requestID, model) {
        requests.add(i.getRequestModelCount(requestID));
        _addRequestToOrgModel(model.getVal("orgID"), requests.last);
      });
      requests.sort((a, b) => b.remaining().compareTo(a.remaining()));
}

_addRequestToOrgModel(String orgID, RequestModelCount newModel){
        if (orgID==null || orgID == "") return;

        if (!orgModels.containsKey(orgID)) {
            CustomModel orgData = dataRepo.getItemByID("orgs", orgID);
            if (orgData != null) orgModels[orgID] = OrgModelCount(orgData); }
          try {
            orgModels[orgID].addRequestQuantities(newModel);
          } catch (e) {}
}







  Future<bool> submitForm(bool isDone) async {
    print("SUBMITFORM");
    bool isSuccessful=false;
    loading=true;
     notifyListeners();
    
    if(currentFormModel.name=="request")isSuccessful= await _submitRequestForm();
    else if(currentFormModel.name=="update")isSuccessful= await _submitUpdateForm();
    else if(currentFormModel.name=="claim")isSuccessful= await _submitClaimForm();
    if(isDone){
      currentFormModel= null;
      isFormActive=false;
    }
  
    initDesigns();
    initRequests();
    loading=false;
    notifyListeners();
    return isSuccessful;
  }

  dismissForm()  {
    print("Dismiss FORM");
    isFormActive=false;
    currentFormModel= null;
    notifyListeners();
  }


/*


Request

 */


  initRequest() {
    isFormActive=true;
     //notifyListeners();
    Map<String, dynamic> buffer={
      "designs":[
        dataRepo.getItemByID("designs", "fa900ce5-aae8-4a69-92c3-3605f1c9b494"),
        dataRepo.getItemByID("designs", "5f2009e0-55a8-4d4b-aa6a-a9becf5c9392"),
      ]
    };
    currentFormModel = FormModel(
      name:"request",
      buffer:buffer, //onSubmit: (data){},
      tabs: [
          FormTabModel(formDataCallback:userInfo),
          FormTabModel(formDataCallback: orgInfo),
          FormTabModel(formDataCallback:requestInfo),
          FormTabModel(formDataCallback: deliveryInfo),
      ], 
    );
    notifyListeners();
  }

  Future<bool> _submitRequestForm() async{
          print("SUBMIT Request");
          Slack slack = new Slack("https://hooks.slack.com/services/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");
         
      final Map reqs =safeGet(key: "requests", map: currentFormModel.buffer, alt: {});
     String now = DateTime.now().toUtc().toString();
    
    // adds the items from the form to the org map, additionally adds any other items, that would not be added through the form
      Map<String, dynamic> reqOrg = currentFormModel.toMap(
        checkItems:{
        "address":"address",       "contactName":"name",          "contactEmail":"email",
        "name":"orgName",          "type": "orgType",             "deliveryInstructions":"deliveryInstructions",
      },additionalItems: {
        "phone":  "",           "website": "",
        "lat":  null,           "lng": null,
        "createdAt": now,       "lastModified": now,
        "id":generateNewID(),   "isVerified":false
      });
      // String newOrgID = generateNewID();
      String addr = reqOrg["address"]; // safeGet(key: "address", map: currentFormModel.buffer, alt: null);
      AuthState authState = AuthState(FirebaseAuth.instance);
      String code = reqOrg["id"].substring(0,5);
      String userID = await authState.signUp(reqOrg["contactEmail"], password: code);
      await dataRepo.addModel(
        data: {
          "id":userID,
          "name":reqOrg["contactName"],
          "email":reqOrg["contactEmail"],
          "isVerified":true,

        },
        collectionName: "users",
        saveToFirebase: true
      );

      if(addr!=null){
        addr = addr.replaceAll(" ", "+").replaceAll("/", "").replaceAll("#", "");
        var placeUrl = "https://maps.googleapis.com/maps/api/geocode/json?address=$addr&key=$googleAPIKey";
        var placeResponse = await http.post(Uri.parse(placeUrl), body: {});
        try{
          Map loc = json.decode(placeResponse.body);
          print(loc);
          Map loca = loc["results"][0]["geometry"]["location"];
          print(loca);
          reqOrg["lat"]= loca["lat"];
          reqOrg["lng"]= loca["lng"];
        }catch(e){ print(addr); print("error"); }
      }
      CustomModel orgModel = await dataRepo.addModel(
        data: reqOrg,
        collectionName: "orgs",
        saveToFirebase: true
      );
   
      List reqsData = [];
      reqs.forEach((designID, quantity) {

        int q = int.tryParse(quantity)??0;
        if (q != 0) {  //String newReqID = generateNewID();
          Map<String, dynamic> reqData = {
              "id":generateNewID(),      "orgID":orgModel.id,
              "quantity": (quantity is String)?int.tryParse(quantity)??0:quantity,
              "designID": designID,     "createdAt": now,
              "lastModified": now,      "requestSource": "website",
              "isVerified": false,
        };
        CustomModel d= dataRepo.getItemByID("designs", designID);
        String cd = d.getVal("name");
        print('New request from ${reqOrg["contactName"]}(${reqOrg["contactEmail"]}) at ${reqOrg["name"]}(${reqOrg["address"]}) for ${reqData["quantity"]} ${cd}s');
          Message message = new Message('New request from ${reqOrg["contactName"]}(${reqOrg["contactName"]}) at ${reqOrg["name"]}(${reqOrg["address"]}) for ${reqData["quantity"]} ${cd}s',username:'bar-user');      
          slack.send(message);
        
          reqsData.add(reqData);
        }
      }); // CREATE REQUEST
      for (int i = 0; i < reqsData.length; i++) {
        await dataRepo.addModel(
        data: reqsData[i],
        collectionName: "requests",
        saveToFirebase: true
      );
      }
      

      // String contactName = reqOrg["contactName"];
      // String contactEmail = reqOrg["contactEmail"];
      // String orgName = orgModel.getVal("name");
      // String code = orgModel.id.substring(0,5);
      // var url = 'https://us-central1-million-more-makers.cloudfunctions.net/sendMailFB?dest=$contactEmail&contactName=$contactName&orgName=$orgName&code=$code';
    
      //  print(url);
      // var response = await  http.post(url, body: {});
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
  
      await Future.delayed(Duration(milliseconds: 5));
      return true;
  }


/*

Claim

*/
initClaim(String requestID, int max) {
    print("INIT CLAIM");
    CustomModel request = dataRepo.getItemByID("requests", requestID);
    // request.addAssociatedIDs(otherCollectionName: "resources", getOneToMany: dataRepo.getOneToMany);
    isFormActive=true;
    String designID =request.getVal("id", collection:"designs");
    Map<String, dynamic> buffer={
      "orgName":request.getVal("name", collection:"orgs"),
      "orgAddress" : request.getVal("address", collection:"orgs"),
      "deliveryInstructions" : request.getVal("deliveryInstructions", collection:"orgs"),
      "designName":request.getVal("name", collection:"designs"),
      "orgID": request.getVal("id", collection:"orgs"),
      "requestID": request.id,
      "designID": request.getVal("id", collection:"designs"),
      "url":safeGet(key:  designID, map: icons, alt:placeHolderUrl),
      "isVerified": true, // "groupsData":groups,
      "max":max,
      //requestModelCount.remaining()
    };
  //  print(buffer);
    currentFormModel = FormModel(
      name:"claim",
      buffer:buffer, //onSubmit: (data){},
      tabs: [
      FormTabModel(formDataCallback: claimInfo),
      FormTabModel(formDataCallback: claimVer),
      FormTabModel(
        formDataCallback:(buf)=> nextSteps(
          title: "Next Steps",
          steps: [
          "Connection ",
          "Delivery ",
          "Update "
        ])),
      ], 
    );
    notifyListeners();
  }
  Future<bool> _submitClaimForm() async{
      print("SUBMIT CLAIM");
      List<CustomModel> groups = dataRepo.getModels("groups").values.toList();
      int i=0;
      String code = currentFormModel.buffer["verificationCode"];
      // print(dataRepo.getModels("claims").length);
      CustomModel group;
       while (i <groups.length && group==null){
        String c=groups[i].getVal("verificationCode");
        if(code==c){
          group =  groups[i];
        } i++;
      }
      if(group==null){ print("not found");
        return false;
      }else{ print("found");
           String now = DateTime.now().toUtc().toString();
    
      Map<String, dynamic> reqCl = currentFormModel.toMap(
        checkItems:{
        "orgID":"orgID",        "requestID":"requestID",        "designID":"designID",
        "quantity":"quantity",  "userName":"name"
      },additionalItems: {
        "createdAt": now,        "lastModified": now,
        "id":generateNewID(),    "isVerified":true,        "groupID":group.id
      });
      try{
        reqCl["quantity"]=int.tryParse(reqCl["quantity"])??0;
        print(reqCl["quantity"]);
      }catch(e){}

     CustomModel m= await dataRepo.addModel(
        data: reqCl, 
        collectionName:"claims", 
        saveToFirebase: true
        );
        dataRepo.collections["claims"].models[m.id]=m;
        //print(dataRepo.collections["claims"].models.length);
      return true;
     
      }
   
  }

/*

Update
*/



initUpdate(CustomModel request, CustomModel claimModel) {
     print("INIT Update");
    //var groups = dataRepo.getItemsWhere("groups");
    isFormActive=true;
   
    String designID =request.getVal("id", collection:"designs");
    Map<String, dynamic> buffer={
      "orgID": request.getVal("id", collection:"orgs"),
      "requestID": request.id,
      "designID": request.getVal("id", collection:"designs"),
      "quantity":claimModel.getVal("quantity"),
      "claimID":claimModel.id,
      "url":safeGet(key:  designID, map: icons, alt:placeHolderUrl),
      "isVerified": true,
    };
    
    currentFormModel = FormModel(
      name:"update",
      buffer:buffer, //onSubmit: (data){},
      tabs: [
          FormTabModel(formDataCallback:updateInfo,),
      ]
    );
    notifyListeners();
  }

  Future<bool> _submitUpdateForm() async{
   
      String now = DateTime.now().toUtc().toString();
     List<CustomModel> groups = dataRepo.getModels("groups").values.toList();
      int i=0;
      String code = currentFormModel.buffer["verificationCode"];//   print(code);
      CustomModel group;
      if(code ==null)return false;
      while (i <groups.length && group==null){
        String c=groups[i].getVal("verificationCode"); //  print(c);
        if(code==c){
          group =  groups[i];
        } i++;
      }
      if(group==null){ print("not found");  }
      else{ print("found");
     // Map<String, dynamic> resourceData = newResource(map, newResourceID, group["id"]);
      Map<String, dynamic> reqOrg = currentFormModel.toMap(
        checkItems:{
        "designID": "designID",   "claimID":"claimID",  "orgID":"orgID",
        "requestID":"requestID",  "userID": "userID",
        "userName":"name",     "url":"url", "quantity":"quantity"
      },additionalItems: {
        "type": "Update",   "createdAt": now,
        "lastModified": now, "id":generateNewID(),
        "isVerified":true });

      CustomModel m=await dataRepo.addModel(
        data: reqOrg, 
        collectionName:"resources", 
        saveToFirebase: true
        );
       
        dataRepo.collections["resources"].models[m.id]=m;
       
      }

      return true;
  }

}

 //dataRepo.getItemByID("claims", reqOrg["claimID"]).addAssociatedIDs(otherCollectionName: "resources", getOneToMany: dataRepo.getOneToMany);
        // dataRepo.getItemByID("requests", reqOrg["claimID"]).addAssociatedIDs(otherCollectionName: "resources", getOneToMany: dataRepo.getOneToMany);
     //  dataRepo.addRowToSheet(collectionName: "resources",vals: resourceToSheet(resourceData, dataRepo));
     // dataRepo.collections["resources"].models[m.id]
 //m.addAssociatedIDs(otherCollectionName: null, getOneToMany: null)

// dataRepo = locator<DataRepo>();
   // var groups = dataRepo.getItemsWhere("groups");
   // var designData = dataRepo.getItemByID("designs", claimModel.getVal("designID"));

   // createModel(modelData: claim, collectionName: "claims");
      //dataRepo.addRowToSheet(collectionName: "claims", vals: claimToSheet(claim, dataRepo));