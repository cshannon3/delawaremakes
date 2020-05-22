
import 'package:carousel_slider/carousel_slider.dart';
import 'package:delaware_makes/forms/form_manager.dart';
import 'package:delaware_makes/routes.dart';
import 'package:delaware_makes/service_locator.dart';
import 'package:delaware_makes/shared_widgets/shared_widgets.dart';
import 'package:delaware_makes/state/app_state.dart';
import 'package:delaware_makes/utils/utility.dart';
import 'package:flutter/material.dart';
//, this.profileId
class ProfilePage extends StatelessWidget {
  
  ProfilePage({Key key, }) : super(key: key);

  List<Widget> updateTiles(List updates) {
    List<Widget> tiles = [];
    updates.forEach((element) {
      tiles.add(Container(
        height: 100.0,
        width: 100.0,
        child: Image.network(element["url"]),
      ));
    });
    return tiles;
  }

  Widget userInfoWidget(double w, BuildContext context) {
    var appState = locator<AppState>();
    return (w < 600)
        ? Column(children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: Image.network(safeGet(
                      key: "url",
                      map: appState.getProfileData(),
                      alt:"https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/nature-quotes-1557340276.jpg?crop=1.00xw:0.757xh;0,0.0958xh&resize=768:*"))
                  .image,
            ),
            SizedBox(height: 20,),
            Text(
              safeGet(key: "name", map:appState.getProfileData(), alt: ""),
              textScaleFactor: 4,
            ),
            SizedBox(height: 20,),
            Text(safeGet(key: "bio", map: appState.getProfileData(), alt: ""),
              textScaleFactor: 2,
              textAlign: TextAlign.center, ),
            SizedBox( height: 40,),
          ])
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 100,
                backgroundImage: Image.network(safeGet(
                        key: "url",
                        map: appState.getProfileData(),
                        alt:
                            "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/nature-quotes-1557340276.jpg?crop=1.00xw:0.757xh;0,0.0958xh&resize=768:*"))
                    .image,
              ),
              SizedBox(width: 20,),
              Column(children: [
                SizedBox(height: 20,),
                Text(
                  safeGet(key: "displayName", map: appState.getProfileData(), alt: ""),
                  textScaleFactor: 4,
                ),
                SizedBox(height: 20, ),
                 appState.isCurrentUser() ? MainUIButton(
              text:"Sign Out",
              onPressed: () {
                appState.logout(); tappedMenuButton(context, "/");  },
              ):SizedBox(  height: 50, ),
                SizedBox(height: 40, ),
              ])
            ],
          );
  }

  Widget claimsList(BuildContext context){
    var appState = locator<AppState>();
    List<Widget> clWidget=[];
    Map claims = safeGet(map: appState.getProfileData(), key: "claims",alt: {});
    claims.forEach((k, cl) {
     // Map des =state.designs.firstWhere((element) => element["id"]== cl["designID"], orElse: ()=>{});
    Map des = appState.dataRepo.getItemByID("designs", cl["designID"]);
      Map org = appState.dataRepo.getItemByID("orgs", cl["orgID"]);
     // Map org =state.orgs.firstWhere((element) => element["id"]== cl["orgID"], orElse: ()=>{});
      String d= safeGet(key: "name", map: des, alt: "design");
      String o= safeGet(key: "name", map: org, alt: "Organization");
      clWidget.add(
        ListTile(
          leading: IconButton(icon: Icon(Icons.check_circle_outline), onPressed: null),
          title:Text("${cl["quantity"]} $d to $o"),
          trailing: (appState.isCurrentUser() && !safeGet(map: cl, key: "isDone",alt: false))?
          Container(width:150.0, child: MainUIButton(text:"Update Claim",
          onPressed: (){
             var formManager = locator<FormManager>();
             formManager.initUpdate(claimData:cl);  
            formManager.setForm("update", resetBuffer: false);
                    }
          )):SizedBox(width:20.0)
          )
      );
    });
    return Column(children: clWidget);
  }
  @override
  Widget build(BuildContext context) {
    var appState = locator<AppState>();
    double w = MediaQuery.of(context).size.width;
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: ListView(
            children: <Widget>[
          userInfoWidget(w, context),
          SizedBox(
            height: 40,
          ),
        appState.isCurrentUser() ?  MainUIButton(
              onPressed: () {
                 var formManager = locator<FormManager>();
                formManager.setForm("update",);
              },
              text: "New Update"):Container(),
          TitleText(title:"Claims"),
          claimsList(context),
           SizedBox( height: 40,),
          TitleText(title:"Updates"),
                Container(
          height:500.0,
          child: GridView.count(
  crossAxisCount: getColumnNum(w),
  children: imageSliders(safeGet(
                            map: appState.getProfileData(),
                            key: "resources",
                            alt: {}).values
                            ))
                            )
        ]
      
      )),
    );
  }

 List<Widget> imageSliders(List resources) {
    List<String> r= ["Image", "Update", "Submission"];

    List<Widget> imgs = [];
    resources.forEach((resData) {
      String url = safeGet(key: "url", map: resData, alt: "");
      String type = safeGet(key: "type", map: resData, alt: "");
      if (url != "" && r.contains(type)){
        imgs.add(Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(url, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          "",
                          //safeGet(key:"name", map:resData, alt: ""),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ));
      }
    });

    return imgs;
  }

}

class UpdatesTile extends StatefulWidget {
  const UpdatesTile({Key key, @required this.userData})
      : super(key: key);

  final Map userData;

  @override
  _DesignTileState createState() => _DesignTileState();
}

class _DesignTileState extends State<UpdatesTile> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Container(
          color: Colors.grey[200],
          child: Column(
            children: [
              Expanded(
                child: Container(
                    child: 
                    CarouselSlider(
                        options: CarouselOptions(),
                        items: imageSliders(safeGet(
                            map: widget.userData,
                            key: "resources",
                            alt: [])))
                            ),
              ),
              ListTile(title: Text("Stats:  "))
            ],
          ),
        ),
      )),
    );
  }
  List<Widget> imageSliders(List resources) {
    List<Widget> imgs = [];
    resources.forEach((resData) {
      String url = safeGet(key: "url", map: resData, alt: "");
      if (url != "" && resData["type"]=="Update") {
        imgs.add(Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(url, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          "",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ));
      }
    });

    return imgs;
  }
}




