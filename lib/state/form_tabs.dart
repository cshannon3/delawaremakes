import 'package:domore/domore.dart';
import 'package:flutter/material.dart';

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
            {"type":"submitButton", "text":"Next"},
    ]
   };

Map<String, dynamic> requestInfo(Map buffer){
  Map requests={};
  List items = [{"type":"title", "text":"Request Info"}];
  buffer["designs"].forEach((designModel) {
    CustomModel des= designModel;
    items.add({
      "type":"imageInputForm", 
      "text":des.getVal("name", alt:""),// safeGet(key: "name", map: des.designData, alt: ""),
      "url":des.getVal("url", alt:""), //  safeGet(key: "url", map: designData, alt: ""),
      "b":20,
      "key":des.id// designData["id"]
      });
      requests[des.id]="0";
  });
  items.add({"type":"submitButton", "text":"Next",});
  return {
      "id":"reqInfo",       "isValidated":false,     "formKey": "",       "icon":Icons.local_mall,
      "tooltip":"Requests", "h":500.0,               "items":items,
      "buffer":{"requests":requests}
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
          {"type":"description", "text":"Delivery Instructions:", "tooltip":"Please enter any information the groups would need to deliver items to you"},
          {"type":"formEntryField", "text":"Delivery Instructions","key": "deliveryInstructions","maxLines":6, "tooltip": "Please enter any information the groups would need to deliver items to you"},
           {"type":"expanded", },
          {"type":"submitButton", "text":"Submit","submit":true},
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
  //print(buffer);
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
            {"type":"formEntryField", "text":"Verification Code","b":20,"key":"verificationCode", "validator":"verification"},
            //{"type":"expanded", },
            {"type":"submitButton", "b":20, "text":"Submit", "submit":true},
    ]
    };
Map<String, dynamic> claimReview(Map buffer)=>{
    "id":"claimReview",
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
            {"type":"formEntryField", "text":"Verification Code","b":20,"key":"verificationCode", "validator":"verification"},
          //  {"type":"expanded", },
            {"type":"submitButton", "b":20, "text":"Done", "submit":true},
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
            {"type":"description", "text":"Verification Code:", "tooltip":" If you don’t have a verification code, request one by emailing delawaremakes@gmail.com"},
            {"type":"formEntryField", "text":"Verification Code","b":20,"key":"verificationCode","validator":"verification"},
            {"type":"imageUpload", "text":"Upload", "b":20,"key":"url"},
            {"type":"submitButton", "b":20, "text":"Submit", "submit":true},
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
            {"type":"description", "text":"Who are you making the shields for:", },
            {"type":"formEntryField", "text":"End User Information","b":20,"key":"info", "maxlines":3},
            {"type":"description", "text":"Approximately How Many are Needed?"},
            {"type":"formEntryField", "text":"quantity", "b":20,"key":"quantity", "validator":"int"},
            {"type":"submitButton", "text":"Next"},
    ]
    };

Map<String, dynamic> claimDeliveryInfo(Map buffer)=>{
    "id":"claimDelivery",
    "h":550.0,
    "tooltip":"Delivery",
     "buffer":{
    },
    "items":[
            {"type":"title", "text":"Claim Review", "b":20},
            {"type":"submitButton", "b":20, "text":"Done"},
    ]
    };
Map<String, dynamic> nextSteps({@required List<String> steps, @required String title}){
   List items = [{"type":"title", "text":title}];
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


