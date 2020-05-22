
import 'package:delaware_makes/utils/utils.dart';

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
      "lat": null,
      "lng": null,
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

