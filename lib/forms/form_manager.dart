import 'package:delaware_makes/forms/form_model.dart';
import 'package:delaware_makes/forms/temp_models.dart';
import 'package:delaware_makes/service_locator.dart';
import 'package:delaware_makes/state/data_repo.dart';
import 'package:delaware_makes/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:delaware_makes/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'form_overlay.dart';

class FormManager extends ChangeNotifier {
  int currentScreenNum = 0;
  bool isActive = false;
  String currentType = "";
  Map<String, dynamic> buffer = {};
  List<FormModel> activeFormScreens;
  bool isVer=false;
  FormManager();

  n(){notifyListeners();}

  FormModel get currentForm => (currentScreenNum != null &&
          activeFormScreens != null &&
          activeFormScreens.length > currentScreenNum)
      ? activeFormScreens[currentScreenNum]
      :null;
 Future<String> next() async {
    print("Next)");
      activeFormScreens.forEach((element) {
        element.formData["buffer"].forEach((k, v) {
          buffer[k] = v;
        });
      });
      print(buffer);
    if ((currentScreenNum+1) >= activeFormScreens.length) {

      activeFormScreens.forEach((element) {
        print(element.formData["buffer"]);
        element.formData["buffer"].forEach((k, v) {
          buffer[k] = v;
        });
      });
      await submit();
      isActive=false;
      notifyListeners();
      return "";
    }
    return "";
  }

  bool checkCode(){
    activeFormScreens.forEach((element) {
        element.formData["buffer"].forEach((k, v) {
          buffer[k] = v;
        });
      });
    //print("check code");
    //print(buffer);
    List groups = safeGet(key: "groupsData", map: buffer, alt: []);
    int i=0;
    String code = safeGet(key: "verification", map: buffer, alt: null);
    print(code);
    if(code ==null)return false;
    while (i <groups.length){
      if(code==groups[i]["verificationCode"]){
        print(groups[i]);
        return true;
      }
      i++;
    }
     return false;
  }


  initClaim({@required Map orgData, @required Map requestData, @required maxQuantity}) {
    var dataRepo = locator<DataRepo>();
    var groups = dataRepo.getItemsWhere("groups");
    var designData = dataRepo.getItemByID("designs",safeGet(key: "designID", map: requestData, alt: 0));
    isVer=true;
    buffer = {};
    buffer["id"] = generateNewID(); 
    buffer["orgData"] = orgData;
    buffer["maxQuantity"] = maxQuantity;
    buffer["designData"]=designData;
    buffer["requestData"] = requestData;
    buffer["groupsData"] = groups;
  }
  initUpdate({Map claimData}) {
      isVer=true;
       //print("Init Update");
      buffer = {}; print(claimData);
      var dataRepo = locator<DataRepo>();
    var groups = dataRepo.getItemsWhere("groups");
   // print(groups);
    //  data
      if (claimData != null) {
        buffer["claimID"] = claimData["id"];
        buffer["quantity"] = safeGet(key: "quantity", map: claimData, alt: 0);
        buffer["orgID"] = safeGet(key: "orgID", map: claimData, alt: "");
        buffer["designID"] = safeGet(key: "designID", map: claimData, alt: "");
        buffer["requestID"] = safeGet(key: "requestID", map: claimData, alt: "");
        buffer["groupsData"]=groups;
      }
    }



  setForm(String _currentType, {bool resetBuffer = true}) {

    if(resetBuffer)buffer = {};
    currentType = _currentType;
    currentScreenNum=0;
    var dataRepo = locator<DataRepo>();
    
    if (currentType == 'update') {
      activeFormScreens = [
        FormModel(formData: updateInfo(), showIconBar: false),
      ];
      isActive=true;
    }
    else if (currentType == 'claim') {
      activeFormScreens = [

      FormModel(formData: claimInfo(buffer)),
         FormModel(formData: claimVer(buffer)),
        FormModel(
            formData: nextSteps(steps: [
          "Connection ",
          "Delivery ",
          "Update "
        ])),
      ];
    isActive=true;
    notifyListeners();
    }
   else if (currentType == "request") {
      activeFormScreens = [
        FormModel(formData: userInfo()),
        FormModel(formData: orgInfo()),
        FormModel(
          validate: false,
          formData: requestInfo(dataRepo.getItemsWhere("designs", fieldFilters: {"isOffered": true}))),
        FormModel(formData: deliveryInfo()),
      ];
      isActive=true;
      notifyListeners();
    }
   else if (currentType == "requestMaterial") {
      activeFormScreens = [
        FormModel(formData: userInfo()),
        FormModel(formData: materialRequestInfo()),
        FormModel(
            formData: nextSteps(steps: [
          "Verification - We will verify your information and approve the requests.",
          "Contact - We will get in contact with you soon to figure out how to get these materials to you"
        ])),
      ];
      isActive=true;
     notifyListeners();
    }
  }



  Future<bool> submit() async {
    print("Submit");
    var dataRepo = locator<DataRepo>();
    String now = DateTime.now().toUtc().toString();
     buffer["createdAt"] = now;
     buffer["lastModified"] = now;
    Map<String, dynamic> map = buffer;
    if (currentType == "claim") {
      print("SUBMIT CLAIM");
      String newClaimID = generateNewID();
       List groups = safeGet(key: "groupsData", map: map, alt: []);
      int i=0;
      String code = safeGet(key: "verification", map: map, alt: null);
      Map group;
      while (i <groups.length && group==null){
        if(code==groups[i]["verificationCode"]){
          group =  groups[i];
        } i++;
      }
      if(group==null){ print("not found");
        
      }else{ print("found");
      Map<String, dynamic> claim = newClaim(map, newClaimID, now, group["id"]);
      await dataRepo.createModel(modelData: claim, collectionName: "claims");
      //dataRepo.addRowToSheet(collectionName: "claims", vals: claimToSheet(claim, dataRepo));
      }
    } 
    
    else if (currentType == "update") {
      String newResourceID = generateNewID();
      List groups = safeGet(key: "groupsData", map: buffer, alt: []);
      int i=0;
      String code = safeGet(key: "verification", map: buffer, alt: null);
      Map group;
      if(code ==null)return false;
      while (i <groups.length && group==null){
        if(code==groups[i]["verificationCode"]){
          group =  groups[i];
        }
        i++;
      }
      if(group==null){ print("not found");  }
      else{ print("found");
      Map<String, dynamic> resourceData = newResource(map, newResourceID, group["id"]);
          await dataRepo.createModel(
              modelData: resourceData, collectionName: "resources");  //  dataRepo.addRowToSheet(collectionName: "resources",vals: resourceToSheet(resourceData, dataRepo));
      }
    } 
    
    
  
    else if (currentType == "request") {
      print("SUBMIT Request");
      final Map reqs = map["requests"];
      Map<String, dynamic> reqOrg = {};
      String newOrgID = generateNewID();
      reqOrg = newOrg(map, newOrgID, now);

       await dataRepo.createModel(modelData: reqOrg, collectionName: "orgs");
        
      List reqData = [];
      reqs.forEach((designID, quantity) {
        int q = int.tryParse(quantity)??0;
        if (q != 0) {
          String newReqID = generateNewID();
          Map<String, dynamic> requestData = newRequest(reqOrg, designID, q, newReqID, now);
          reqData.add(requestData);
        }
      }); // CREATE REQUEST
      for (int i = 0; i < reqData.length; i++) {

        await dataRepo.createModel(
            modelData: reqData[i], collectionName: "requests");
      }
      String contactName = reqOrg["contactName"];
      String contactEmail = reqOrg["contactEmail"];
      String orgName = reqOrg["name"];

      var url = 'https://us-central1-million-more-makers.cloudfunctions.net/sendMail?dest=$contactEmail&contactName=$contactName&orgName=$orgName';
      var response = await http.post(url, body: {});
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      await Future.delayed(Duration(milliseconds: 10));

    } else if (currentType == "requestMaterial") {}
    activeFormScreens=[];
    currentScreenNum=0;
    return true;
    
  }

  Widget getOverlay(){
    if(!isActive)return SizedBox();
  else{  // hasOverlay=true;
    return  Container(
    height: double.infinity,
    width: double.infinity,
    child: Stack(
      children: <Widget>[
        InkWell(
          excludeFromSemantics: true,
          onTap: (){
              isActive=false;
              notifyListeners(); 
            },
          child: Container( height: double.infinity,
    width: double.infinity,
    color: Colors.grey.withOpacity(0.7),
    ),
        ),
        Center(child:FormOverlay()),
      ],
    ),
  );
  }
}
}

