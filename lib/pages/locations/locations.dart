
import 'package:delaware_makes/counters/counters.dart';
import 'package:delaware_makes/pages/locations/components/map_widget.dart';
import 'package:delaware_makes/shared_widgets/shared_widgets.dart';
import 'package:delaware_makes/state/state.dart';
import 'package:delaware_makes/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart';

import 'components/request_tile.dart';
//https://dev.to/happyharis/flutter-web-google-maps-381a
//https://medium.com/funwithflutter/flutter-web-importing-html-and-javascript-flutter-1-9-c728ae9eaf2f
//https://pub.dev/packages/universal_html
//http://kml4earth.appspot.com/icons.html

class MapsPage2 extends StatefulWidget {
  const MapsPage2({
    Key key,
  }) : super(key: key);
  @override
  _MapsPage2State createState() => _MapsPage2State();
}

class _MapsPage2State extends State<MapsPage2> {
  String activeOrgID;
  bool isFaceShieldOn = true;
  bool isEarSaverOn = true;

  String selected = "List";

  @override
  Widget build(BuildContext context) {
    AppState appState = locator<AppState>();
     List dropOffData =  appState.dataRepo.getItemsWhere("dropoffs");
    List pickUpData =  appState.dataRepo.getItemsWhere("pickups");
    // List orgsData =appState.dataRepo.getItemsWhere("orgs", fieldFilters: {"isVerified": true});
    return isMobile(MediaQuery.of(context).size.width)
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                mainMyTabs(selected: selected, items: {
                  "List": () {setState(() {selected = "List"; }); },
                  "Map": () { setState(() {selected = "Map";});}
                }),
                selected == "List"
                    ? optionsBar(appState, dropOffData, pickUpData)
                    : mapWidget(appState,dropOffData, pickUpData)
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              children: [
                mapWidget( appState,dropOffData, pickUpData),
                optionsBar( appState,dropOffData, pickUpData)
              ],
            ),
          );
  }

  Widget optionsBar(AppState appState, List dropOffData, List pickUpData) {
    List<RequestModelCount> remaining = appState.requests
        .where((requestModel) =>
            requestModel.remaining() > 0 &&
            requestModel.isVerified)
        .toList();
    remaining
        .sort((a, b) => b.quantityRequested.compareTo(a.quantityRequested));
    List<RequestModelCount> closed = appState.requests
        .where((requestModel) =>
            requestModel.remaining() <= 0 &&
            requestModel.isVerified)
        .toList();
    closed.sort((a, b) => b.quantityRequested.compareTo(a.quantityRequested));

    return Expanded(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(children: [
              Center(
                child: Text("Open Requests",
                    style: //)
                        TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            decoration: TextDecoration.underline)),
              ),
              // filterBar(),
              ...remaining.map(
                  (requestModel) => RequestTile(
                    requestModel: requestModel,
                    request: appState.dataRepo.getItemByID("requests",requestModel.requestID),
                    
                    )),
              Center(
                child: Text("Completed",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        decoration: TextDecoration.underline)),
              ),
              ...appState.requests
                  .where((element) => element.remaining() <= 0)
                  .map((requestModel) => RequestTile(
                        requestModel: requestModel,
                         request: appState.dataRepo.getItemByID("requests",requestModel.requestID),
                      ))
            ])));
  }

  Widget mapWidget(AppState appState,List dropOffData, List pickUpData) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          counts(appState),
          Container(
            height: 500.0,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(60.0)),
            clipBehavior: Clip.antiAlias,
            child: GoogleMap(
              orgModels: appState.orgModels,
              dropOffData: dropOffData,
              pickupData: pickUpData,
            ),
          ),
        ],
      ),
    );
  }

  Widget counts(AppState appState,) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: appState.designs
            .map((e) => DesignCountsWidget(designModelCount: e,))
            .toList(),
      );
}





class DesignCountsWidget extends StatelessWidget {
  final DesignModelCount designModelCount;

  DesignCountsWidget({Key key,@required this.designModelCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
                  child: Column(
                    children: [
                      Text(
                        designModelCount.designName,
                        style: TextStyle(fontSize: 25.0,),
                      ),
                      SizedBox(height: 5.0, ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                designModelCount.quantityDelivered.toString(),
                                style: TextStyle(
                                    color: Colors.green, fontSize: 20.0),
                              ),
                              Text("Total"),
                              Text("Made"),
                            ],
                          ),
                          SizedBox(width: 30.0,),
                          Column(
                            children: [
                              Text(
                                "${designModelCount.quantityRequested - designModelCount.quantityClaimed}",
                                style: TextStyle(
                                    color: Colors.red, fontSize: 20.0),
                              ),
                              Text("Open",),
                              Text("Requests",),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
  }
}



//AppState appState;
  //DataRepo dataRepo;
  // List<DesignModelCount> designs;
  // List<RequestModelCount> requests;
  // Map<String, OrgModelCount> orgModels = {};
  //bool loaded = false;


  // @override
  // void initState() {
  //   super.initState();
  //   dataRepo = locator<DataRepo>();
  //   appState = locator<AppState>();
  //   initDesigns();
  //   initRequests();
  //   //  print(orgModels.length);
  //   requests.sort((a, b) => b.remaining().compareTo(a.remaining()));
  //   appState.addListener(() {
  //     initDesigns();
  //     initRequests();
  //     setState(() {});
  //   });
  // }

//   initDesigns(){
//       designs = [
//       DesignModelCount(
//           designID: "5f2009e0-55a8-4d4b-aa6a-a9becf5c9392",
//           designName: "Face Shields"),
//       DesignModelCount(
//           designID: "fa900ce5-aae8-4a69-92c3-3605f1c9b494",
//           designName: "Ear Savers"),
//     ];
//     designs.forEach((element) {
//       element.init();
//     });
//   }

// initRequests(){
//       orgModels = {};
//       requests = [];
//       dataRepo.getModels("requests").forEach((requestID, model) {
//         RequestModelCount r = RequestModelCount(model);
//         r.init();
//         requests.add(r);
//         if (model.data.containsKey("orgID")) {
//           String orgID = model.data["orgID"];
//           if (!orgModels.containsKey(orgID)) {
//             CustomModel orgData = dataRepo.getItemByID("orgs", orgID);
//             if (orgData != null) orgModels[orgID] = OrgModelCount(orgData);
//           }
//           try {
//             orgModels[orgID].addRequestQuantities(r);
//           } catch (e) {}
//         }
//       });
//       requests.sort((a, b) => b.remaining().compareTo(a.remaining()));
// }
    // orgModels = {};
    // requests = [];
    // dataRepo.getModels("requests").forEach((requestID, model) {
    //   RequestModelCount r = RequestModelCount(model);
    //   r.init();
    //   requests.add(r);
    //   if (model.data.containsKey("orgID")) {
    //     String orgID = model.data["orgID"];
    //     if (!orgModels.containsKey(orgID)) {
    //       CustomModel orgData = dataRepo.getItemByID("orgs", orgID);
    //       if (orgData != null) orgModels[orgID] = OrgModelCount(orgData);
    //     }
    //     try {
    //       orgModels[orgID].addRequestQuantities(r);
    //     } catch (e) {}
    //   }
    // });
// Widget filterBar() => Padding(
//       padding: EdgeInsets.only(
//         top: 10.0,
//         bottom: 10.0,
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey, width: 2.0),
//             borderRadius: BorderRadius.circular(50.0)),
//         child: Padding(
//           padding: EdgeInsets.only(bottom: 8.0),
//           child: Row(children: [
//             SizedBox(
//               width: 20.0,
//             ),
//             Column(
//               children: [
//                 Checkbox(
//                   value: isEarSaverOn,
//                   onChanged: (value) {
//                     isFaceShieldOn = value;
//                     setState(() {});
//                   },
//                   activeColor: Colors.green,
//                 ),
//                 Text("Open"),
//               ],
//             ),
//             SizedBox(
//               width: 30.0,
//             ),
//             Column(
//               children: [
//                 Checkbox(
//                   value: isEarSaverOn,
//                   onChanged: (value) {
//                     isFaceShieldOn = value;
//                     setState(() {});
//                   },
//                   activeColor: Colors.green,
//                 ),
//                 Text("Completed"),
//               ],
//             ),
//             Expanded(child: Container()),
//             Column(
//               children: [
//                 Checkbox(
//                   value: isEarSaverOn,
//                   onChanged: (value) {
//                     isEarSaverOn = value;
//                     setState(() {});
//                   },
//                   activeColor: Colors.green,
//                 ),
//                 Text("Ear Savers"),
//               ],
//             ),
//             SizedBox(
//               width: 30.0,
//             ),
//             Column(
//               children: [
//                 Checkbox(
//                   value: isEarSaverOn,
//                   onChanged: (value) {
//                     isFaceShieldOn = value;
//                     setState(() {});
//                   },
//                   activeColor: Colors.green,
//                 ),
//                 Text("Face Shields"),
//               ],
//             ),
//             SizedBox(
//               width: 20.0,
//             ),
//           ]),
//         ),
//       ),
//     );
// var orgs=dataRepo.getModels("orgs");
// orgs.forEach((org) {
//   OrgModel orgModel= OrgModel(org["id"]);
//   List reqs = orgModel.init();
// });


// Container(
//                   child: Column(
//                     children: [
//                       Text(
//                         e.designName,
//                         style: TextStyle(
//                           fontSize: 25.0,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 5.0,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Column(
//                             children: [
//                               Text(
//                                 e.quantityDelivered.toString(),
//                                 style: TextStyle(
//                                     color: Colors.green, fontSize: 20.0),
//                               ),
//                               Text("Total"),
//                               Text("Made"),
//                             ],
//                           ),
//                           SizedBox(
//                             width: 30.0,
//                           ),
//                           Column(
//                             children: [
//                               Text(
//                                 "${e.quantityRequested - e.quantityClaimed}",
//                                 style: TextStyle(
//                                     color: Colors.red, fontSize: 20.0),
//                               ),
//                               Text(
//                                 "Open",
//                               ),
//                               Text(
//                                 "Requests",
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 )