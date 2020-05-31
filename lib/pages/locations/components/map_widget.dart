
import 'package:delaware_makes/counters/counters.dart';
import 'package:flutter/material.dart';
import 'package:google_maps/google_maps.dart'as gmaps;
import 'dart:ui' as ui;

import 'package:universal_html/html.dart';

enum PlaceType{
  ORG,
  DROPOFF,
  PICKUP
}

class GoogleMap extends StatelessWidget {
   final Map<String,OrgModelCount> orgModels;
   final List pickupData;
   final List dropOffData;

  GoogleMap({Key key, @required this.orgModels,@required this.dropOffData,@required this.pickupData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   // print(orgModels.length);
    String htmlId = "7";
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(htmlId, (int viewId) {
      final mapOptions = gmaps.MapOptions()
        ..zoom = 8.2
        ..center = gmaps.LatLng(39.3394351,-75.6);

      final elem = DivElement()
        ..id = htmlId
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.border = 'none';

      final map = gmaps.GMap(elem, mapOptions);
      orgModels.forEach((key, model) {
      //  print(model.data);
        model.addToMap(map);
      });
      return elem;
    });
    return HtmlElementView(viewType: htmlId);
  }
}



    //  addItems(map, list: orgsData,placeType: PlaceType.ORG);
    //  addItems(map, list: pickupData,placeType: PlaceType.PICKUP );
     // addItems(map, list: dropOffData,placeType: PlaceType.DROPOFF );

//   addItems(gmaps.GMap map,{ List list, PlaceType placeType}){
//         if(list==null)return;
//         list.forEach((place) {
//             final infoWindow = gmaps.InfoWindow(gmaps.InfoWindowOptions()..content = makeContent(place));
//             gmaps.Icon i = gmaps.Icon()  //  ..url=place.icon??"http://maps.google.com/mapfiles/kml/paddle/grn-circle-lv.png"
//                     ..url=icons[placeType]
//                   ..scaledSize=gmaps.Size(15,15)
//                   ..size=gmaps.Size(15,15);

//             var lat= safeGet(key:"lat", map:place, alt:null );
//             if(lat is String)lat = double.tryParse(lat)??null;
//             var lng= safeGet(key:"lng", map:place, alt:null);
//             if(lng is String)lng = double.tryParse(lng)??null;
//             if(lat!=null && lng!=null){
//             final marker1= gmaps.Marker(gmaps.MarkerOptions()
//             ..position = gmaps.LatLng(lat,lng)
//             ..map = map
//             ..title = safeGet(key:"name", map:place, alt:"") 
//             ..icon =i
//             );
//             marker1..onClick.listen((event) { 
//               infoWindow.open(map, marker1);
//             } );
//             }
//       });
// }

//   final Map<PlaceType, String> icons ={
//   PlaceType.ORG:"http://maps.google.com/mapfiles/kml/paddle/grn-circle-lv.png",
//   PlaceType.DROPOFF:"http://maps.google.com/mapfiles/kml/paddle/wht-stars-lv.png",
//   PlaceType.PICKUP:"http://maps.google.com/mapfiles/kml/paddle/ylw-circle-lv.png",
//   //http://maps.google.com/mapfiles/kml/paddle/red-circle-lv.png
// };

// String makeContent(Map map){
//   var contentString = '<div id="content">' +
//     '<div id="siteNotice">' +
//     '</div>' +
//      '<h1 id="firstHeading" class="firstHeading">${safeGet(key:"name", map:map, alt:"")}</h1>'+
//       '<div id="bodyContent">'+
//        '<p><b>Address:${safeGet(key:"address", map:map, alt:"")}</b>.</p>';
//     if(map.containsKey("dropOffInstructions")){
//        contentString+='<p><b>Drop Off Instructions:${map["dropOffInstructions"]}</b>.</p>';
//      }
//      if(map.containsKey("url") && map["url"]!=""){
//        contentString+='<img src="${map["url"]}" alt="Smiley face" height="250" width="250">';
//      }
//      else if(map.containsKey("urls") && map["urls"]!={}){
//        map["urls"].forEach((key, value) {
//          contentString+='<p><b>$key</b>.</p>'
//          '<img src="$value" alt="Smiley face" height="250" width="250">';
//         });
//      }

//    contentString+=// '<p><b> Pickup Times:</b>.</p>' +
//    // '<p><b> Contact Info:</b><a href="https://www.facebook.com/kathy.buterbaugh.7"> Kathy Buterbaugh </p>' +
//     '</div>' +
//     '</div>';
//     return contentString;
//   }
// still todo
//  description
// fix icons, decription
//http://kml4earth.appspot.com/icons.html

    //var appState = locator<AppState>();
   // List orgsData = appState.orgs.where((org) => org["isActive"]).toList()??[];
    //var dataRepo = locator<DataRepo>();



  //final Function(CustomModel place) clickPlace;
 // final List orgsData;
  //final List<CustomModel> hubs;

      //int k =0;
    // place.requests.forEach((element) { 
    //   if(element.designID!="sewnmask"){
    //   contentString+='<p><b>${element.designID} :${element.quantityRecieved}/${element.quantityRequested}</b>.</p>';
    //   }
    //  // k+=1;
    // });