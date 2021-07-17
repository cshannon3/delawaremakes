
import 'package:delaware_makes/routes.dart';
import 'package:delaware_makes/shared_widgets/shared_widgets.dart';
import 'package:delaware_makes/shared_widgets/stylized_image_box.dart';
import 'package:delaware_makes/state/state.dart';
import 'package:delaware_makes/theme.dart';
import 'package:domore/domore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


//  "https://scontent.fphl2-1.fna.fbcdn.net/v/t1.15752-9/s2048x2048/97004143_237907727468307_3348191839210438656_n.jpg?_nc_cat=100&_nc_sid=b96e70&_nc_ohc=f5XU8kL6bVIAX9WZaBz&_nc_ht=scontent.fphl2-1.fna&_nc_tp=7&oh=d91b91d0aa5c5392ce61cd4ab6ee8bd1&oe=5EE9CFBA",
class MakerSection extends StatelessWidget {
  final bool isMobile;
  final List<String> groupsNames;
  const MakerSection({
    Key key,
    @required this.isMobile, 
    @required this.groupsNames,
  }) : super(key: key);

  Widget cta(BuildContext context) => Center(
        child: Container(
          width: 300.0,
          child: CallToActionButton(
            name: "Get Involved",
             onPressed:  () {
            tappedMenuButton(context, "/resources");},),
        ),
      );

  @override
  Widget build(BuildContext context) {

    TextStyle aTextStyle= Theme.of(context).textTheme.headline5;
   TextStyle bTextStyle= Theme.of(context).textTheme.headline6;



    return isMobile
        ? Container(height:850.0,
          child:
           Column(
           children:[
            SizedBox( height: 30.0,),
            TitleText(title:makerCTA),
            SizedBox(height: 20.0,),
            cta(context),
            SizedBox(height: 30.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                designs(context, isMobile), 
                 locations(context, isMobile)
               // faceshield()
                ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
                       child: Padding(
                         padding: const EdgeInsets.all(20.0),
                         child: Container(height: double.infinity, width: double.infinity,
                         child:ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child:Stack(children: [
     Container(
       height: double.infinity,width:double.infinity,
       child: Image.asset(
         "groups_inv.jpg",
         fit: BoxFit.cover,
         )),
                Container(height: double.infinity,width:double.infinity, color:Colors.black.withOpacity(0.6),
                child: Padding(
                  padding:EdgeInsets.only(left:8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    SizedBox(height:20),
                    Text("Groups Involved:", 
                    style: aTextStyle ),
                    SizedBox(height:10),
                    ...groupsNames.map((e) => Padding(
                      padding: EdgeInsets.only(top:3.0),
                      child: Text(e, 
                      style: bTextStyle),
                      //TextStyle( color:Colors.white, fontSize: 16.0)),
                    )),
                    Text("...", style: aTextStyle),
                  
                  ],),
                ),
                ),

          ]))),
                       ),
                 
          ),
              SizedBox(
              height: 10.0,
            ),
          ])//)
          
        ): Container(
          height: 460.0,
          child: Row(
            children: [
                 Expanded(
                       child: Padding(
                         padding: const EdgeInsets.all(20.0),
                         child: Container(height: double.infinity, width: double.infinity,
                         child:ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child:Stack(children: [
     Container(
       height: double.infinity,width:double.infinity,
       child: Image.asset(
         "groups_inv.jpg",
          fit: BoxFit.cover,
         )),
                Container(height: double.infinity,width:double.infinity, 
                color:Colors.black.withOpacity(0.7),
                child: Padding(
                  padding:EdgeInsets.only(left:8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    SizedBox(height:20),
                    Text("Groups Involved:",
                     style: aTextStyle
                    
                     ),
                    SizedBox(height:10),
                    ...groupsNames.map((e) => Padding(
                      padding: EdgeInsets.only(top:3.0),
                      child: Text(e, 
                      style: bTextStyle
                   
                      ),
                    )),
                    Text("...", 
                  style:aTextStyle
                
                    ),
                  
                  ],),
                ),
                ),
          ]))),
                       ),
                 
          ),
              Expanded(
                child: Column(
                  children:
                    //delegate: SliverChildListDelegate([
                   [ SizedBox(
                      height: 30.0,
                    ),
                    TitleText(title:makerCTA),
                    SizedBox(
                      height: 20.0,
                    ),
                    cta(context),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        designs(context, isMobile),
                        locations(context, isMobile)
                 
                      ],
                    ),
                    SizedBox(
                      height: 60.0,
                    ),
                  ]),
              ),
            ],
          ),
        );
  }

  Widget designs(BuildContext context,bool mobile) => Container(
      width: mobile ?tileW:tileWdesk,
      height: mobile ?tileH:tileHdesk,
      child: StylizedImageBoxAsset(
          onPressed: () {
            tappedMenuButton(context, "/resources");
          },
          bottomText: "Help 3D Print PPE",
          url:"pins.jpg"));


Widget locations(BuildContext context, bool mobile) => Container(
      width: mobile ?tileW:tileWdesk,
      height: mobile ?tileH:tileHdesk,
      child: StylizedImageBoxAsset(
        //topRightWidget: iconButton(icon: CommonIcons.INFO, onPressed: null, ),
          onPressed: () {
             tappedMenuButton(context, "/designs");
            },
          bottomText: "Design Library",
          url: "earsavers.jpg"));
}


  // TextStyle( color:Colors.white, fontSize: 20.0),   
  //TextStyle( color:Colors.white, fontSize: 16.0)
   //TextStyle( color:Colors.white, fontSize: 20.0),
   // TextStyle( color:Colors.white, fontSize: 20.0),
    //TextStyle( color:Colors.white, fontSize: 20.0),

      // Widget share(bool mobile) => Container(
  //     width: 220.0,
  //     height: 220.0,
  //     child: StylizedImageBox(
  //         bottomText: "Share Makes",
  //         url:"https://firebasestorage.googleapis.com/v0/b/million-more-makers.appspot.com/o/userupdates%2F45813f00-9636-11ea-ad9c-85a16895bf4b?alt=media&token=dc6f4399-8826-45e9-a451-d712e8e76494"));
  
  // Widget discover(bool mobile) => Container(
  //     width: 220.0,
  //     height: 220.0,
  //     child: StylizedImageBox(
  //         bottomText: "Discover Other Designs",
  //         url: "https://scontent.fphl2-4.fna.fbcdn.net/v/t1.0-9/97340636_3236644053022009_4108035780813783040_o.jpg?_nc_cat=110&_nc_sid=825194&_nc_ohc=ZniW0vNucD4AX8pDhI4&_nc_ht=scontent.fphl2-4.fna&oh=8eb173d87f38e05e32da6604e33ebc9d&oe=5EE3D2F4"));
