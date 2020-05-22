
import 'package:delaware_makes/routes.dart';
import 'package:delaware_makes/service_locator.dart';
import 'package:delaware_makes/state/app_state.dart';
import 'package:delaware_makes/utils/constant.dart';
import 'package:delaware_makes/utils/utility.dart';
import 'package:flutter/material.dart';
class Gallery extends StatefulWidget {
  final double w;

  const Gallery({Key key, @required this.w}) : super(key: key);
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  AppState appState;
    List<Widget>  tiles;
  
  @override
  void initState() { // loader = CustomLoader();
    tiles = galleryTiles(getColumnNum(widget.w));
    super.initState();
  }

  List<Widget> galleryTiles(int itemsPerRow) {
    appState = locator<AppState>();
    List<Widget> out=[];
    List<String> r= ["Submission"];

   List resources= appState.dataRepo.getItemsWhere("resources", fieldFilters: {
   "type":"Submission"
    });
   resources.shuffle();
   int maxLen = itemsPerRow*2<resources.length? itemsPerRow*2:resources.length;

   for (int i=0; i<maxLen; i++){
     String type= safeGet(key: "type", map: resources[i], alt: "");
     String url =safeGet(key: "url", map:resources[i], alt:null);
    Widget bottomWid;
     if(resources[i].containsKey("userID")){
        Map user = appState.dataRepo.getItemByID("users", resources[i]["userID"]);
        bottomWid= ListTile(
          onTap: (){
            appState.setUserProfile(user);
            tappedMenuButton(context, "/users/${user["id"]}");
          },
          leading: Container(
            height:50.0,
            width: 50.0,
            child: CircleAvatar(
              radius: 50.0,
              backgroundImage: NetworkImage(safeGet(key: "url", map:user, alt:placeHolderUrl)),
            ),
          ),
          title: Text(safeGet(key: "name", map:user, alt:"User"), style: TextStyle(color:Colors.white),),
        );
       
     }
    
     if(r.contains(type)&&url!=null){
       out.add(Padding(
         padding: EdgeInsets.all(8.0),
         child: Container(
           decoration: BoxDecoration(image:DecorationImage(image:NetworkImage(url))),
           
            margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                     // Image.network(url, fit: BoxFit.cover, width: 1000.0, alignment: Alignment.center,),
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
                          child:bottomWid
                        ),
                      ),
                     
                    ],
                  )),
            )));
        }}        
   return out;
    
}

  @override
  Widget build(BuildContext context) {
    
    return Container(
      height:600.0,
      child: GridView.count(crossAxisCount: getColumnNum(widget.w), children:tiles)
      
      );
  }
}