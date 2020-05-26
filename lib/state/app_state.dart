import 'dart:convert';

import 'package:delaware_makes/counters/request_model.dart';
import 'package:delaware_makes/state/state.dart';
import 'package:delaware_makes/utils/constant.dart';
import 'package:delaware_makes/utils/secrets.dart';
import 'package:domore/forms/form.dart';
import 'package:domore/login/auth_state.dart';
import 'package:domore/state/custom_model.dart';
import 'package:domore/state/new_data_repo.dart';
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

  CustomModel getProfileData() => userProfileData ?? null;

  init() {
    dataRepo = locator<DataRepo>();
  }
  setSize(Size newSize){
   //.. if(_size==null){_size = newSize;notifyListeners();}
   // else 
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
    isReady = true;
    dataRepo.collections.forEach((key, value) {
      print(value.models.length);
    });
    notifyListeners();
  }

 initLogin(){
   isLoginActive=true;
   notifyListeners();
 }
  onSignIn(FirebaseUser firebaseUser, bool isSignUp){
      if(isSignUp){}
    else currentUser = dataRepo.getItemByID("users", firebaseUser.uid);

    isLoginActive=false;
    userProfileData = currentUser;
    if(currentUser!=null)loggedIn=true;
    
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


  initRequest() {
    isFormActive=true;
     notifyListeners();
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
  initUpdate() {

  }
  initClaim(RequestModelCount requestModelCount) {
    print("INIT CLAIM");
    //var groups = dataRepo.getItemsWhere("groups");
    isFormActive=true;
    String designID =requestModelCount.request.getVal("id", collection:"designs");
    Map<String, dynamic> buffer={
      "orgName":requestModelCount.request.getVal("name", collection:"orgs"),
      "orgAddress" : requestModelCount.request.getVal("address", collection:"orgs"),
      "designName":requestModelCount.request.getVal("name", collection:"designs"),
      "url":safeGet(key:  designID, map: icons, alt:placeHolderUrl),
     // "groupsData":groups,
      "max":requestModelCount.remaining(),
    };
    print(buffer);
    currentFormModel = FormModel(
      name:"claim",
      buffer:buffer, //onSubmit: (data){},
      tabs: [
      FormTabModel(formDataCallback: claimInfo),
      FormTabModel(formDataCallback: claimVer),
      FormTabModel(
        formDataCallback:(buf)=> nextSteps(steps: [
          "Connection ",
          "Delivery ",
          "Update "
        ])),
      ], 
    );
    notifyListeners();
  }
  
  dismissForm()  {
    print("Dismiss FORM");
    isFormActive=false;
    currentFormModel= null;
    notifyListeners();
  }

  submitForm() async {
    print("SUBMITFORM");
    loading=true;
    isFormActive=false;
    if(currentFormModel.name=="request")await _submitRequestForm();
    else if(currentFormModel.name=="update")await _submitUpdateForm();
    else if(currentFormModel.name=="claim")await _submitClaimForm();
    currentFormModel= null;
    loading=false;
    notifyListeners();
  }
  _submitUpdateForm() async{

  }
  _submitClaimForm() async{

  }

  Future<bool> _submitRequestForm() async{
          print("SUBMIT Request");
      final Map reqs =safeGet(key: "requests", map: currentFormModel.buffer, alt: {});
     String now = DateTime.now().toUtc().toString();
    
      Map<String, dynamic> reqOrg = currentFormModel.toMap(
        checkItems:{
        "address":"address",
        "contactName":"name",
        "contactEmail":"email",
        "name":"orgName",
        "type": "orgType",
        "deliveryInstructions":"deliveryInstructions",
      },additionalItems: {
        "phone":  "",
        "website": "",
        "lat":  null,
        "lng": null,
        "createdAt": now,
        "lastModified": now,
        "id":generateNewID(),
        "isVerified":false
      }
      );

      // String newOrgID = generateNewID();
      String addr = reqOrg["address"];
     // safeGet(key: "address", map: currentFormModel.buffer, alt: null);
      if(addr!=null){
        addr = addr.replaceAll(" ", "+").replaceAll("/", "").replaceAll("#", "");
        var placeUrl = "https://maps.googleapis.com/maps/api/geocode/json?address=$addr&key=$googleAPIKey";
        var placeResponse = await http.post(placeUrl, body: {});
        try{
          Map loc = json.decode(placeResponse.body);
          Map loca = loc["results"][0]["geometry"]["location"];
          reqOrg["lat"]= loca["lat"];
          reqOrg["lng"]= loca["lng"];
        }catch(e){
          print(addr);
          print("error");
        }
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
              "id":generateNewID(),
              "orgID":orgModel.id,
              "quantity": quantity,
              "designID": designID,
              "createdAt": now,
              "lastModified": now,
              "requestSource": "website",
              "isVerified": false,
        };
        
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
    
     String contactName = reqOrg["contactName"];
      String contactEmail = reqOrg["contactEmail"];
      String orgName = orgModel.getVal("name");
      String code = orgModel.id.substring(0,5);
    
     
      var url = 'https://us-central1-million-more-makers.cloudfunctions.net/sendMailFB?dest=$contactEmail&contactName=$contactName&orgName=$orgName&code=$code';
  //   print(url);
        var response = await  http.post(url, body: {});
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      await Future.delayed(Duration(milliseconds: 5));
      return true;
  }
}




const List org = [
  ""
  "Hospital",
  "Senior Living",
  "Home Care",
  "Government",
  "Social Services",
  "Community Center/Housing",
  "Rehab",
  "Physicians/Doctor's Office",
  "Other"
];

Map<String, dynamic> userInfo(Map buffer)=>{
    "id":"userInfo",
    "isValidated":false,
    "formKey": "",
    "icon":Icons.person_outline,
    "h":500.0,
    "tooltip":"User Info",
     "buffer":{
        "name":"",
        "email":"",
    },
    "items":[
            {"type":"title", "text":"Contact Info", "b":20},
            {"type":"description", "text":"Name:"},
            {"type":"formEntryField", "text":"Name","b":20,"key":"name", "validator":"empty"},
            {"type":"description", "text":"Email:"},
            {"type":"formEntryField", "text":"Email", "b":20,"key":"email","validator":"email"},
             {"type":"expanded", },
            {"type":"submitButton", "text":"Next"},
    ]
    };

Map<String, dynamic> orgInfo(Map buffer)=>{
      "id":"orgInfo",
      "isValidated":false,
      "formKey":  "",
      "icon":Icons.pin_drop,
      "h":550.0,
      "tooltip":"Organization Info",
      "buffer":{
        "orgName":"",
        "address":"",
        "orgType":"Hospital"
      },
      "items":[
            {"type":"title", "text":"Organization Info"},
            {"type":"description", "text":"Organization Name:"},
            {"type":"formEntryField", "text":"Organization Name","b":20,"key":"orgName","validator":"empty"},
            {"type":"description", "text":"Organization Address:"},
            {"type":"formEntryField", "text":"Organization Address","b":20,"key":"address","validator":"empty"},
            {"type":"description", "text":"Organization Type:"},
            {"type":"dropdown", "text":"Select From List", "b":20, "items":org, "key":"orgType", },
            {"type":"expanded", },
            {"type":"submitButton", "text":"Next",},
    ]
   };

Map<String, dynamic> requestInfo(Map buffer){
  Map requests={};
  List items = [{"type":"title", "text":"Request Info"}];
  buffer["designs"].forEach((designModel) {
    CustomModel des= designModel;
    items.add({
      "type":"imageInputForm", 
      "text":des.getVal("name", alt:""),
     // safeGet(key: "name", map: des.designData, alt: ""),
      "url":des.getVal("url", alt:""),
    //  safeGet(key: "url", map: designData, alt: ""),
      "b":20,
      "key":des.id
     // designData["id"]
      });
      requests[des.id]="0";
  });
  items.add({"type":"submitButton", "text":"Next",});
  return {
      "id":"reqInfo",
      "isValidated":false,
      "formKey": "",
      "icon":Icons.local_mall,
      "tooltip":"Requests",
      "h":500.0,
      "items":items,
      "buffer":{
        "requests":requests
      }
   };
}
Map<String, dynamic> deliveryInfo(Map buffer)=>{
      "id":"deliveryInfo",
      "isValidated":false,
      "icon":Icons.verified_user,
      "formKey": "",
      "h":500.0,
      "tooltip":"Delivery Instructions",
      "buffer":{
        "deliveryInstructions":"",
      },
      "items":[
          {"type":"title", "text":"Delivery Info"},
          {"type":"description", "text":"Delivery Instructions:", },
          {"type":"formEntryField", "text":"Delivery Instructions","key": "deliveryInstructions","maxLines":6, "tooltip": "Please enter any information the groups would need to deliver items to you"},
           {"type":"expanded", },
          {"type":"submitButton", "text":"Submit"},
        ]
   };

Map<String, dynamic> loginInfo(Map buffer)=>{
    "isValidated":false,
    "icon":Icons.person_outline,
    "tooltip":"User Info",
         "buffer":{
        "verification":"",
        "quantity":"",
    },
    "items":[
            {"type":"title", "text":"Sign In"},
            {"type":"description", "text":"Email:"},
            {"type":"formEntryField", "text":"Email", "key":"email",},
            {"type":"description", "text":"Password:"},
            {"type":"formEntryField", "text":"Password","key":"password"},
            {"type":"submitButton", "text":"Submit"},
        ]
    };

Map<String, dynamic> claimInfo(Map buffer){
  print(buffer);
 return  {
    "id":"claimInfo",
    "icon":Icons.info_outline,
    "h":600.0,
    "tooltip":"Claim Info",
     "buffer":{
    },
    "items":[
            {"type":"title", "text":"Claim Overview", "b":20},
            {"type":"description", "text":"Organization: ${buffer["orgName"]}"},
            {"type":"description", "text":"Design: ${buffer["designName"]}"},
            {"type":"image", "url":"${buffer["url"]}"},
            {"type":"description", "text":"Quantity Remaining:${buffer["max"]} "},
            {"type":"expanded", },
            {"type":"submitButton", "b":20, "text":"Next"},
    ]
    };
}
Map<String, dynamic> claimVer(Map buffer)=>{
    "id":"claimVer",
    "icon":Icons.person_outline,
    "h":550.0,
    "tooltip":"Claim Info",
     "buffer":{
        "name":"",
        "verification":"",
        "quantity":"",
    },
    "items":[
            {"type":"title", "text":"Claim Information", "b":20},
            {"type":"description", "text":"Name:"},
            {"type":"formEntryField", "text":"Name","b":20,"key":"name"},
            {"type":"description", "text":"Quantity Claiming:"},
            {"type":"formEntryField", "text":"quantity", "b":20,"key":"quantity"},
            {"type":"description", "text":"Verification Code:", "tooltip":" If you don’t have a verification code, request one by emailing delawaremakes@gmail.com"},
            {"type":"formEntryField", "text":"Verification Code","b":20,"key":"verification", "validator":"verification"},
            {"type":"expanded", },
            {"type":"submitButton", "b":20, "text":"Submit"},
    ]
    };
Map<String, dynamic> claimReview(Map buffer)=>{
    "id":"claimVer",
    "icon":Icons.person_outline,
    "h":550.0,
    "tooltip":"Claim Info",
     "buffer":{
    },
    "items":[
            {"type":"title", "text":"Claim Review", "b":20},
            {"type":"description", "text":"Name:"},
            {"type":"formEntryField", "text":"Name","b":20,"key":"name"},
            {"type":"description", "text":"Quantity Claiming:"},
            {"type":"formEntryField", "text":"quantity", "b":20,"key":"quantity"},
            {"type":"description", "text":"Verification Code:", "tooltip":" If you don’t have a verification code, request one by emailing delawaremakes@gmail.com"},
            {"type":"formEntryField", "text":"Verification Code","b":20,"key":"verification", "validator":"verification"},
            {"type":"expanded", },
            {"type":"submitButton", "b":20, "text":"Done"},
    ]
    };
Map<String, dynamic> updateInfo(Map buffer)=>{
    "id":"updateInfo",
    "isValidated":false,
    "icon":Icons.person_outline,
    "h":700.0,
    "tooltip":"Update Info",
     "buffer":{
        "verification":"",
        "name":"",
        "url":"",
        "isActive":false
    },
    "items":[
            {"type":"title", "text":"Update", "b":20},
            {"type":"description", "text":"Name:"},
            {"type":"formEntryField", "text":"Name","key":"name"},
            {"type":"description", "text":"Verification Code:", "tooltip":" If you don’t have a verification code, request one by emailing delawaremakes@gmail.com"},
            {"type":"formEntryField", "text":"Verification Code","b":20,"key":"verification","validator":"verification"},
            {"type":"imageUpload", "text":"Upload", "b":20,"key":"url"},
            {"type":"expanded", },
            {"type":"submitButton", "b":20, "text":"Submit"},
      ]
    };
Map<String, dynamic> materialRequestInfo()=>{
    "id":"materialInfo",
    "isValidated":false,
    "icon":Icons.info_outline,
    "h":500.0,
    "tooltip":"Request Info",
     "buffer":{
        "info":"",
        "quantity":"",
    },
    "items":[
            {"type":"title", "text":"Claim Information", "b":20},
            {"type":"description", "text":"Who are you making the shields for:", "tooltip":"Please enter any information the groups would need to deliver items to you"},
            {"type":"formEntryField", "text":"End User Information","b":20,"key":"info", "maxlines":3},
            {"type":"description", "text":"Approximately How Many are Needed?"},
            {"type":"formEntryField", "text":"quantity", "b":20,"key":"quantity", "validator":"int"},
            {"type":"submitButton", "text":"Next"},
    ]
    };


Map<String, dynamic> nextSteps({@required List<String> steps}){
   List items = [{"type":"title", "text":"Request Info"}];
   for (int i =0; i<steps.length; i++){
     items.add({"type":"description", "text":"$i. ${steps[i]}"});
   }
    items.add({"type":"expanded", });
   items.add({"type":"submitButton", "b":20.0,"text":"Next"});
   return {
    "type":"info",
    "buffer":{
       
    },
    "items":items
    };
}




   // CustomModel newOrg = CustomModel(
      //   data:reqOrg, 
      //   fields: dataRepo.getFields("orgs"), 
      //   collectionName: "orgs"
      // );
      
     // await dataRepo.createModel(modelData: reqOrg, collectionName: "orgs");
        

Map<String, dynamic> newOrg(Map map, String id, String now) {
     Map<String, dynamic> out= 
     { "id": id,
      "isVerified": false,
      "contactName": safeGet(key: "name", map: map, alt: ""),
      "contactEmail": safeGet(key: "email", map: map, alt: ""),
      "name": safeGet(key: "orgName", map: map, alt: ""),
      "address": safeGet(key: "address", map: map, alt: ""),
      "phone": safeGet(key: "phone", map: map, alt: ""),
      "type": safeGet(key: "type", map: map, alt: ""),
      "website": safeGet(key: "website", map: map, alt: ""),
      "lat": safeGet(key: "lat", map: map, alt: null),
      "lng": safeGet(key: "lng", map: map, alt: null),
      "deliveryInstructions":  safeGet(key: "deliveryInstructions", map: map, alt: ""),
      "createdAt": now,
      "lastModified": now,
    };
    return out;
    }
Map<String, dynamic> newRequest(Map<String, dynamic> orgData, String designID,
        int quantity, String id, String now) {
   Map<String, dynamic> out=  {
      "id": id,
      "orgID": safeGet(key: "id", map: orgData, alt: ""),
      "designID": designID,
      "userID": safeGet(key: "userID", map: orgData, alt: ""),
      "isVerified": false,
      "contactName": safeGet(key: "contactName", map: orgData, alt: ""),
      "contactEmail": safeGet(key: "contactEmail", map: orgData, alt: ""),
      "email": safeGet(key: "email", map: orgData, alt: ""),
      "deliveryInstructions":
          safeGet(key: "deliveryInstructions", map: orgData, alt: ""),
      "createdAt": now,
      "lastModified": now,
      "requestSource": "website",
      "quantityRequested": quantity,
      "isDone": false,
    };
    return out;
        }
Map<String, dynamic> newResource(Map map, String id, String groupID) => {
      "id": generateNewID(),
      "designID": safeGet(key: "designID", map: map, alt: ""),
      "claimID": safeGet(key: "claimID", map: map, alt: ""),
      "orgID": safeGet(key: "orgID", map: map, alt: ""),
      "requestID": safeGet(key: "requestID", map: map, alt: ""),
      "userID": safeGet(key: "userID", map: map, alt: ""),
      "groupID":groupID,
      "userName":safeGet(key: "name", map: map, alt: ""),
      "createdAt": map["createdAt"],
      "lastModified": map["lastModified"],
      "type": "Update",
      "quantity": (map["quantity"] is String)
          ? int.tryParse(map["quantity"]) ?? 0
          : map["quantity"],
      "name": safeGet(key: "name", map: map, alt: ""),
      "url": safeGet(key: "url", map: map, alt: ""),
      "description": safeGet(key: "description", map: map, alt: ""),
      "isVerified": true,
    };

Map<String, dynamic> newClaim(Map map, String id, String now, String groupID) => {
      "id": id,
      "orgID": map["orgData"]["id"],
      "requestID": map["requestData"]["id"],
      "designID": map["requestData"]["designID"],
      "userID": map["id"],
      "groupID": groupID,
      "userName":safeGet(key: "name", map: map, alt: ""),
      "createdAt":now,
      "lastModified": now,
      "isVerified": false,
      "quantity": (map["quantity"] is String)
          ? int.tryParse(map["quantity"]) ?? 0
          : map["quantity"],
    };
//  formModels: {
//         "request":FormModel(tabs:[
//           FormTabModel(formDataCallback:userInfo),
//           FormTabModel(formDataCallback: orgInfo),
//           FormTabModel(formDataCallback: requestInfo),
//           FormTabModel(formDataCallback: deliveryInfo),
//         ],
//         onSubmit: (buffer){

//         }),
//         "update":FormModel(tabs: [
//           FormTabModel(formDataCallback: updateInfo,),
//         ],
//         onSubmit: (buffer){

//         }),
//         "claim":FormModel(tabs: [
//           FormTabModel(formDataCallback: claimInfo),
//           FormTabModel(formDataCallback: claimVer),
//           FormTabModel(formDataCallback: (buf)=>nextSteps(steps: [
//           "Connection ",
//           "Delivery ",
//           "Update "
//         ])),
//       ],
//         onSubmit: (buffer){

//         }),
        
//       },

          // var dataRepo = locator<DataRepo>();
         // var groups = dataRepo.getItemsWhere("groups");
        // var designData = dataRepo.getItemByID("designs",safeGet(key: "designID", map: data, alt: 0));
       // RequestModel getRequestModel(String id){
      //   RequestModel
     // }
    //  authState = AuthState();
   // docsRepo = locator<DocsRepo>();
  //formManager = FormManager()
 //FormManager formManager;
// var formManager = locator<FormManager>();

    //dataRepo.getItemByID("users", modelID)
    //dataRepo.getItemByID("users", user["id"], addLinkMap: true);
// Map buffer = {
//   "id":generateNewID(),
//   "orgData":orgData,
//   "maxQuantity":quantityRequested-quantityClaimed,
//   "designData":designData,
//   "requestData":data,
//   "groupsData":groups
// };
//   formManager.initClaim(orgData: orgData, requestData: data, maxQuantity: quantityRequested-quantityClaimed);
// formManager.setForm("claim", );

/*
SIGN IN
*/
// Future<String> signIn(String email, String password,{GlobalKey<ScaffoldState> scaffoldKey}) async {
//   String userID =await authState.signIn(email, password, scaffoldKey: scaffoldKey);
//   loggedIn = true;
//   currentUser = dataRepo.getItemByID("users", userID);
//   setUserProfile(currentUser, isCurrentUser:true);
//   return "";
// }

/*
SIGN UP
*/
// initSignUp() {
//   buffer = {
//     "email": "",
//     "name": "",
//     "displayName": "",
//     "isVerified": false,
//   };
// }

// Future<String> signUp(
//     {GlobalKey<ScaffoldState> scaffoldKey, @required String password}) async {
//   buffer["displayName"] = buffer["name"];
//   String uid = await authState.signUp(buffer["email"],
//       scaffoldKey: scaffoldKey, password: password);
//   if (uid != null) {
//     buffer["id"] = uid;
//     await dataRepo.createModel(modelData: buffer, collectionName: "users");
//   }
//   currentUser = buffer;
//   loggedIn = true;
//   setUserProfile(currentUser, isCurrentUser:true);
//   return "";
// }

// List materialToSheet(Map<String, dynamic> map, DataRepo dataRepo)=>//async{ // await  dataRepo.addRowToSheet(collectionName:"orgs", vals:
//             [
//             safeGet(key: "contactName", map: map, alt: ""),
//             safeGet(key: "contactEmail", map: map, alt: ""),
//             safeGet(key: "isVerified", map: map, alt: false)?"true":"false",
//             safeGet(key: "quantity", map: map, alt: 0),
//             safeGet(key: "info", map: map, alt: "-"),
//             safeGet(key: "createdAt", map: map, alt: "-"),
//             ];

// List orgToSheet(Map<String, dynamic> map, DataRepo dataRepo)=>//async{ // await  dataRepo.addRowToSheet(collectionName:"orgs", vals:
//             [
//             safeGet(key: "id", map: map, alt: ""),
//             safeGet(key: "name", map: map, alt: ""),
//             safeGet(key: "isVerified", map: map, alt: false)?"true":"false",
//             safeGet(key: "requests", map: map, alt: []).length,
//             safeGet(key: "type", map: map, alt: "-"),
//             safeGet(key: "contactEmail", map:map, alt: "-"),
//             safeGet(key: "contactName", map:map, alt: "-"),
//             safeGet(key: "address", map:map, alt: "-"),
//             safeGet(key: "deliveryInstructions", map:map, alt: "-"),
//             safeGet(key: "createdAt", map: map, alt: "-"),
//             ];

// List requestToSheet(Map<String, dynamic> map, DataRepo dataRepo){
//  return     [
//             safeGet(key: "id", map: map, alt: "-"),
//             safeGet(key: "isVerified", map: map, alt: false)?"true":"false",
//             safeGet(key: "contactName", map: map, alt: "-"),
//             safeGet(key: "name", map: map, alt: "-"),
//             safeGet(key: "name", map: dataRepo.getItemByID("designs", map["designID"]), alt: "-"),
//             safeGet(key: "quantity", map: map, alt:0),
//             safeGet(key: "requestSource", map: map, alt: "-"),
//             safeGet(key: "isDone", map: map, alt: false)?"true":"false",
//             safeGet(key: "createdAt", map: map, alt: "-"),
//             ];}

// List resourceToSheet(Map<String, dynamic> map, DataRepo dataRepo)=>//async{//  await  dataRepo.addRowToSheet(collectionName:"resources", vals:
//           [
//             safeGet(key: "id", map: map, alt: ""),
//             safeGet(key: "url", map: map, alt: ""),
//             safeGet(key: "isVerified", map: map, alt: false)?"true":"false",
//             safeGet(key: "name", map: map, alt: ""),
//             safeGet(key: "name", map:dataRepo.getItemByID("orgs", safeGet(key: "orgID", map: map, alt: "")), alt: ""),
//             safeGet(key: "name", map:  dataRepo.getItemByID("designs",safeGet(key: "designID", map: map, alt: "")), alt: ""),
//             safeGet(key: "quantity", map: map, alt: 0),
//             safeGet(key: "displayName", map: dataRepo.getItemByID("users",safeGet(key: "userID", map: map, alt: "")), alt: ""),
//             safeGet(key: "createdAt", map: map, alt: ""),
//           ];
// List claimToSheet(Map<String, dynamic> map, DataRepo dataRepo)=>//async{ // await  dataRepo.addRowToSheet(collectionName:"requests", vals:
//             [
//             safeGet(key: "id", map: map, alt: ""),
//             safeGet(key: "isVerified", map: map, alt: false)?"true":"false",
//             safeGet(key: "name", map:dataRepo.getItemByID("orgs", safeGet(key: "orgID", map: map, alt: "")), alt: ""),
//             safeGet(key: "name", map: dataRepo.getItemByID("designs", map["designID"]), alt: ""),
//             safeGet(key: "displayName", map: dataRepo.getItemByID("users",safeGet(key: "userID", map: map, alt: "")), alt: ""),
//             safeGet(key: "quantity", map: map, alt: 0),
//             safeGet(key: "isDone", map: map, alt: false)?"true":"false",
//             safeGet(key: "createdAt", map: map, alt: ""),
//           ];
