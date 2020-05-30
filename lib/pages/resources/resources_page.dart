
import 'package:delaware_makes/shared_widgets/shared_widgets.dart';
import 'package:delaware_makes/utils/utils.dart';
import 'package:flutter/material.dart';

class ResourcesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle aTextStyle= Theme.of(context).textTheme.headline1;
    TextStyle bTextStyle= Theme.of(context).textTheme.subtitle1.copyWith(color:Colors.black);

  
    return Padding(
      padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 40),
      child: ListView(
        children: <Widget>[
         Center(
           child: Text(
             "How Get Involved",
             style: aTextStyle,
           ),
         ),
         Padding(
           padding: EdgeInsets.symmetric(horizontal:30.0),
           child: Text('''


        If you haven't already let either Connor or Yianni know that you want to be involved. Send us an email at delawaremakes@gmail.com and we will set up an account for you. Once you have the account, you can contribute in a few different ways. 
                   
        1. Offer To Print For Organizations- you can offer to print open requests by going to the "Open Requests" tab and clicking the claim button. For this method, we can either put you in direct contact with the organization that made the request so you can organize delivery or we can work with you to get the prints picked up and delivered. If you need help with delivery, just email us using the subject line "Deliver Request" 
        

        2. Share Designs- if you've found or made any designs that you believe the community might find useful, send us an email with a picture of the design and a link to where you found it. We can then add it to the design collection we have. We will use that to keep track of the items being printed by the community and offer certian designs to the organizations.


        3. Print Updates-  you can update us on what you have printed so far so we can add your prints to the live tally. Just send us estimates on how many of each item you've made to delawaremakes@gmail.com using the subject line "Print Update" and we will add them. Please attach any pictures you have of the prints as well.
        
           ''',
             style:bTextStyle),
         ),
         Row(
           children: <Widget>[
           Expanded(
             child: Container(
                 child: CallToActionContainer(topText: "Want to connect with our community?",buttonText: 'Join FB Group', onPressed: ()=>launch("https://www.facebook.com/groups/1624749267680924"),)),
           ),
           SizedBox(width: 20.0,),
                    Expanded(
                       child: Container(
               child: CallToActionContainer(textSize: 16.0,topText: "Want to check out the NIH-approved designs?",buttonText: 'NIH 3D Printing Exchange', onPressed: ()=>launch("https://3dprint.nih.gov/collections/covid-19-response"),)),
                     ),
           ],
         ),
     
        ],
      ),
    );
   
  }

}



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
//                   width:300.0,
//                   height:300.0,
//                   child: StylizedImageBox(
//                     bottomText: "Manta Ray Design",
//                     url:"https://media.prusaprinters.org/thumbs/cover/1200x630/media/prints/28352/images/282195_b49c4fbc-7410-4aa8-a3ca-407b0a5bfb9b/img_9034.jpg" ,
//                      bottomWidget: Row(children: <Widget>[
//                     Text("Manta Ray Design",style: TextStyle(color:Colors.white),) ,
//                     Expanded(child: Container(),),
//                     iconButton(
//                       icon: CommonIcons.LINK, 
//                       color: Colors.white,
//                       onPressed: ()=>launch("https://www.prusaprinters.org/prints/28352-manta-ray-face-shield-v6-prusa-3dverkstan-remix")
//                       ),
//                    ],),
//                    )),
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