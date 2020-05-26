
import 'package:delaware_makes/counters/request_model.dart';
import 'package:domore/state/custom_model.dart';

import 'package:google_maps/google_maps.dart'as gmaps;
Map icons={
    "fa900ce5-aae8-4a69-92c3-3605f1c9b494":"https://images.squarespace-cdn.com/content/v1/597f55aa20099e0ef5ad6f39/1588881166426-SIZUR1NVBLYOBD53YB3X/ke17ZwdGBToddI8pDm48kKAwwdAfKsTlKsCcElEApLR7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QPOohDIaIeljMHgDF5CVlOqpeNLcJ80NK65_fV7S1UY_1Meb8-Dj4GHImj6dpC0aR7O2ZKZedZTAz84fFYaQfMW9u6oXQZQicHHG1WEE6fg/Ear+Saver+Hydra+Single+%282000%29.png",
    "5f2009e0-55a8-4d4b-aa6a-a9becf5c9392":"https://lh3.googleusercontent.com/qny-IW0VZVfORmqJ4Uyc99nU3mVUW83947HgRizZsUdeVytRiW9oM_dBM31fxEaTwGsYNqeO2UBIxwp9z54GVv64=w640-h480-p"
};

class OrgModelCount{
    final CustomModel org;
    String orgName;
    String orgAddress;
    int quantityRequested=0;
    int quantityClaimed=0;
    int quantityDelivered=0;
    bool isDone =true;
    bool isClaimed= false;
   // List<RequestModel> requests=[];
    OrgModelCount(this.org);
    int remaining()=>quantityRequested-quantityDelivered;
    String getIcon()=>
      isDone? "https://maps.google.com/mapfiles/kml/paddle/grn-circle-lv.png"
      :"https://maps.google.com/mapfiles/kml/paddle/red-circle-lv.png";
    
  addRequestQuantities(RequestModelCount req){
        quantityClaimed+=req.quantityClaimed;
        quantityRequested+=req.quantityRequested;
        quantityDelivered+=req.quantityDelivered;
        if(!req.isDone)isDone=false;
    }
   addToMap(gmaps.GMap map){
     String url = getIcon();
            final infoWindow = gmaps.InfoWindow(gmaps.InfoWindowOptions()..content = makeContent());
            gmaps.Icon i = gmaps.Icon() 
                    ..url=url
                  ..scaledSize=gmaps.Size(15,15)
                  ..size=gmaps.Size(15,15);
            var lat= org.getVal("lat");
            if(lat is String)lat = double.tryParse(lat)??null;
            var lng= org.getVal("lng");
            if(lng is String)lng = double.tryParse(lng)??null;
            if(lat!=null && lng!=null){
            final marker1= gmaps.Marker(gmaps.MarkerOptions()
            ..position = gmaps.LatLng(lat,lng)
            ..map = map
          //  ..label = remaining()
            ..title = org.getVal("name")
            ..icon =i
            );
            marker1..onClick.listen((event) { 
              infoWindow.open(map, marker1);
            } );
            }
      }
   

   String makeContent(){
     String address, dropOffInstructions, url, name;
     address=org.getVal("address", alt: "");
     dropOffInstructions=org.getVal("dropOffInstructions", alt: "");
     url=org.getVal("url", alt: "");
     name=org.getVal("name", alt: "");
     Map urls = org.getVal("urls", alt: {});
    var contentString = '<div id="content">' +
      '<div id="siteNotice">' +
      '</div>' +
      '<h1 id="firstHeading" class="firstHeading">$name</h1>'+
        '<div id="bodyContent">'+
        '<p><b>Address:$address</b>.</p>';
    if(dropOffInstructions!=""){
       contentString+='<p><b>Drop Off Instructions:$dropOffInstructions</b>.</p>';
     }
     if(url!=""){
       contentString+='<img src="$url" alt="Smiley face" height="250" width="250">';
     }
     else if(urls!={}){
       urls.forEach((key, value) {
         contentString+='<p><b>$key</b>.</p>'
         '<img src="$value" alt="Smiley face" height="250" width="250">';
        });
     }

   contentString+=// '<p><b> Pickup Times:</b>.</p>' +
   // '<p><b> Contact Info:</b><a href="https://www.facebook.com/kathy.buterbaugh.7"> Kathy Buterbaugh </p>' +
    '</div>' +
    '</div>';
    return contentString;
  }
}







//labels[labelIndex++ % labels.length],
  // quantityRequested=safeGet(map: data, key:"quantity", alt:0);

      //   Map claims = safeGet(map: data, key:"claims", alt:{});
      //   claims.forEach((key, value) {
      //   quantityClaimed+=safeGet(map: value, key:"quantity", alt:0);
      //   Map cdata = dataRepo.getItemByID("claims", key, addLinkMap: true);
      //   Map resources = safeGet(map: cdata, key:"resources", alt:{});
      //   resources.forEach((k, v) {
      //     quantityDelivered+=safeGet(map: v, key:"quantity", alt:0);
      //   });
      // });
      // isDone = quantityDelivered>=quantityRequested;
      // isClaimed = quantityClaimed>=quantityRequested;