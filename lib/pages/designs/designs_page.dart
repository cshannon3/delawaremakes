
import 'package:delaware_makes/state/state.dart';
import 'package:delaware_makes/utils/utils.dart';
import 'package:domore/database/custom_model.dart';
import 'package:domore/domore.dart';
import 'package:flutter/material.dart';




class DesignsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    TextStyle t = TextStyle(
      fontSize: 30.0,
      color:Colors.black, fontStyle: FontStyle.normal, decoration: TextDecoration.underline);
    TextStyle tt = Theme.of(context).textTheme.headline3.copyWith(color:Colors.black);


    int cols = getColumnNum(MediaQuery.of(context).size.width);
    var dataRepo = locator<DataRepo>();
    List<CustomModel> designVersions = dataRepo.getModels("design_versions").values.toList();
    List<CustomModel> designsRec = designVersions.where((element) => element.getVal("isStarred", alt:false)).toList();
    List<CustomModel> designsOther = designVersions.where((element) => !element.getVal("isStarred", alt:false)).toList();
    designVersions = designsRec;
    designVersions.addAll(designsOther);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 20),
      child:Column(
        children: <Widget>[
         Text("Design Library", 
         style: t,
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.end,
           children: [
           Text("NIH Link"),
           SizedBox(width: 40.0,),
           Text("Prusa Link")
         ],),
         SizedBox(height: 30.0,),
         Expanded(child: 
         GridView.count(
           cacheExtent: 9999999,
           crossAxisCount: cols,
         children: designVersions.map((designModel) => 
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: StylizedImageBox(
              url: designModel.getVal("url"),
                 topLeftWidget:  (designModel.getVal("sourceUrl")!=null)?
                    Tooltip(
                      message: "Source Url",
                      child: IconButton(
                        icon: Icon(Icons.web, color: Colors.grey[300],),
                        onPressed: ()=>launch(designModel.getVal("sourceUrl")),
                      ),
                    ):null,
              topRightWidget:  (designModel.getVal("downloadUrl")!=null)?
                    Tooltip(
                      message: "Download Stl",
                      child: IconButton(
                        icon: Icon(Icons.cloud_download, color: Colors.green,),
                        onPressed: ()=>launch(designModel.getVal("downloadUrl")),
                      ),
                    ):null,
            bottomText: designModel.getVal("name"),
            onPressed: ()=>launch(designModel.getVal("sourceUrl")),
             ),
          )).toList()))
        ],
      ),
    );
  }


}
// import 'package:delaware_makes/shared_widgets/shared_widgets.dart';
// import 'package:delaware_makes/utils/utils.dart';
// import 'package:flutter/material.dart';
// class DesignsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 40),
//       child: ListView(
//         children: <Widget>[
//      SizedBox(height: 20),
//         Text("To get involved, email us at: delawaremakes@gmail.com",
//             style:
//                 TextStyle(color: Colors.black, fontSize: 16.0)),
//         SizedBox(height: 20),
          
//          // TitleText(title:"Community"),
//          Row(
//            children: <Widget>[
//            Expanded(
//              child: Container(
//                  child: CallToActionContainer(topText: "Want to connect with our community?",buttonText: 'Join FB Group', onPressed: ()=>launch("https://www.facebook.com/groups/1624749267680924"),)),
//            ),
//            SizedBox(width: 20.0,),
//                     Expanded(
//                        child: Container(
//                child: CallToActionContainer(textSize: 16.0,topText: "Want to check out the NIH-approved designs?",buttonText: 'NIH 3D Printing Exchange', onPressed: ()=>launch("https://3dprint.nih.gov/collections/covid-19-response"),)),
//                      ),
//            ],
//          ),
//           TitleText(title:"Design Info"),
//           SizedBox(height:20.0 ),
//           TitleText(title:"Recommended Face Shields", underline: true),
//           SizedBox(height:20.0),
//           ...adaptive(MediaQuery.of(context).size.width),
//            SizedBox(
//             height:20.0),
//           TitleText(title:"Other Designs", underline: true),
//           SizedBox(height:30.0),
//           nihEarSavers(),
//           template(),
//           SizedBox(height:300.0),
//         ],
//       ),
//     );
   
//   }
//  List<Widget> adaptive(double width)=>(width>900)?desktop():(width>800)?middle():mobile();
    

//  List<Widget> mobile()=> [
//                   prusa(),
//                     SizedBox(height: 10.0,), 
//                   vert(),
//                     SizedBox(height: 10.0,),
//                 manta(),
//                 SizedBox(height: 10.0,),
//           ];
//  List<Widget> middle()=> [
//    Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               prusa(), vert(),
//           ],),
//            SizedBox(height: 10.0,),
//                Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               manta(), SizedBox(height: 300.0,width: 300.0,),
//           ],),   
               
               
//           ];

//  List<Widget> desktop()=> [Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               prusa(), vert(), manta(),
//           ],)];


// Widget nihEarSavers()=>   Center(
//   child:   Container(
//                   width:300.0,
//                   height:300.0,
//                   child: StylizedImageBox(
//                     url:"https://cdn.thingiverse.com/assets/98/df/20/19/c8/featured_preview_strap-remix.JPG" ,
//                    bottomWidget: Row(children: <Widget>[
//                     Text("NIH Ear Saver",style: TextStyle(color:Colors.white),) ,
//                     Expanded(child: Container(),),
//                     iconButton(
//                       icon: CommonIcons.LINK, 
//                       color: Colors.white,
//                       onPressed: ()=>launch("https://3dprint.nih.gov/discover/3dpx-013410")
//                       ),
//                    ],),
//                    )),                
// );

// Widget template()=>   Center(
//   child:   Container(
//                   width:300.0,
//                   height:300.0,
//                   child: StylizedImageBox(
//                     url:"https://scontent.fphl2-3.fna.fbcdn.net/v/t1.0-9/98574660_3256293901057024_8901266270092001280_o.jpg?_nc_cat=104&_nc_sid=825194&_nc_ohc=3A_ze86a3DsAX_pIwPi&_nc_ht=scontent.fphl2-3.fna&oh=71d4c7383f504fa413b303da9b877157&oe=5EECC142" ,
//                    bottomWidget: Row(children: <Widget>[
//                     Text("Beebe mask template ",style: TextStyle(color:Colors.white),) ,
//                     Expanded(child: Container(),),
//                     iconButton(
//                       icon: CommonIcons.LINK, 
//                       color: Colors.white,
//                       onPressed: ()=>launch("https://www.thingiverse.com/thing:4380238")
//                       ),
//                    ],),
//                    )),                
// );

// Widget biasTape()=>   Center(
//   child:   Container(
//                   width:300.0,
//                   height:300.0,
//                   child: StylizedImageBox(
//                     url:"https://scontent.fphl2-3.fna.fbcdn.net/v/t1.0-9/98574660_3256293901057024_8901266270092001280_o.jpg?_nc_cat=104&_nc_sid=825194&_nc_ohc=3A_ze86a3DsAX_pIwPi&_nc_ht=scontent.fphl2-3.fna&oh=71d4c7383f504fa413b303da9b877157&oe=5EECC142" ,
//                    bottomWidget: Row(children: <Widget>[
//                     Text("Beebe mask template ",style: TextStyle(color:Colors.white),) ,
//                     Expanded(child: Container(),),
//                     iconButton(
//                       icon: CommonIcons.LINK, 
//                       color: Colors.white,
//                       onPressed: ()=>launch("https://www.thingiverse.com/thing:4380238")
//                       ),
//                    ],),
//                    )),                
// );

// Widget vert()=>   Center(
//   child:   Container(
//                   width:300.0,
//                   height:300.0,
//                   child: StylizedImageBox(
//                     url:"https://cdn.myminifactory.com/assets/object-assets/5e8d747938361/images/720X720-img-20200408-083219749.jpg" ,
//                    bottomWidget: Row(children: <Widget>[
//                     Text("3D Versktan Design",style: TextStyle(color:Colors.white),) ,
//                     Expanded(child: Container(),),
//                     iconButton(
//                       icon: CommonIcons.LINK, 
//                       color: Colors.white,
//                       onPressed: ()=>launch("https://3dverkstan.se/protective-visor/")
//                       ),
//                    ],),
//                    )),
// );
// Widget manta()=>                 Center(
//   child:   Container(
//           width:300.0,
//           height:300.0,
//           child: StylizedImageBox(
//             bottomText: "Manta Ray Design",
//             url:"https://media.prusaprinters.org/thumbs/cover/1200x630/media/prints/28352/images/282195_b49c4fbc-7410-4aa8-a3ca-407b0a5bfb9b/img_9034.jpg" ,
//               bottomWidget: Row(children: <Widget>[
//             Text("Manta Ray Design",style: TextStyle(color:Colors.white),) ,
//             Expanded(child: Container(),),
//             iconButton(
//               icon: CommonIcons.LINK, 
//               color: Colors.white,
//               onPressed: ()=>launch("https://www.prusaprinters.org/prints/28352-manta-ray-face-shield-v6-prusa-3dverkstan-remix")
//               ),
//             ],),
//             )),
// );
//   Widget prusa()=>      Center(
//     child: Container(
//                   width:300.0,
//                   height:300.0,
//                   child: StylizedImageBox(
//                   url:"https://cdn.blog.prusaprinters.org/wp-content/uploads/2020/03/us_shield.jpg",
//                   bottomWidget: Row(children: <Widget>[
//                     Text("Prusa Design",style: TextStyle(color:Colors.white),) ,
//                     Expanded(child: Container(),),
//                     iconButton(
//                       icon: CommonIcons.LINK, 
//                       color: Colors.white,
//                       onPressed: ()=>launch("https://www.prusaprinters.org/prints/28504-slim-rc3-us-with-comfort-features-plus-shield")
//                       ),
//                    ],),
//                    )),
//   );
// }



/*
NIH Exchange
"https://3dprint.nih.gov/collections/covid-19-response"

Prusa Library

// */
// List d = [[
//   "NIH Ear Saver",
// "https://cdn.thingiverse.com/assets/98/df/20/19/c8/featured_preview_strap-remix.JPG",
// "https://3dprint.nih.gov/discover/3dpx-013410"],[

// "Template",
// "https://scontent.fphl2-3.fna.fbcdn.net/v/t1.0-9/98574660_3256293901057024_8901266270092001280_o.jpg?_nc_cat=104&_nc_sid=825194&_nc_ohc=3A_ze86a3DsAX_pIwPi&_nc_ht=scontent.fphl2-3.fna&oh=71d4c7383f504fa413b303da9b877157&oe=5EECC142",
// "https://www.thingiverse.com/thing:4380238"],[


// "Bias Tape",
// "https://scontent.fphl2-3.fna.fbcdn.net/v/t1.0-9/98574660_3256293901057024_8901266270092001280_o.jpg?_nc_cat=104&_nc_sid=825194&_nc_ohc=3A_ze86a3DsAX_pIwPi&_nc_ht=scontent.fphl2-3.fna&oh=71d4c7383f504fa413b303da9b877157&oe=5EECC142",
// "https://www.thingiverse.com/thing:4380238"],

// ["Manta Ray Design",
// "https://media.prusaprinters.org/thumbs/cover/1200x630/media/prints/28352/images/282195_b49c4fbc-7410-4aa8-a3ca-407b0a5bfb9b/img_9034.jpg",
// "https://www.prusaprinters.org/prints/28352-manta-ray-face-shield-v6-prusa-3dverkstan-remix"],

// ["Prusa Design",
// "https://cdn.blog.prusaprinters.org/wp-content/uploads/2020/03/us_shield.jpg",
// "https://www.prusaprinters.org/prints/28504-slim-rc3-us-with-comfort-features-plus-shield"],
// [
// "3D Verkstan",
// "https://cdn.myminifactory.com/assets/object-assets/5e8d747938361/images/720X720-img-20200408-083219749.jpg",
// "https://3dverkstan.se/protective-visor/",]];
