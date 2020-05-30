
import 'package:delaware_makes/shared_widgets/shared_widgets.dart';
import 'package:delaware_makes/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:domore/domore.dart';

import 'dart:math' as math;
class TextModel {}

class AboutPerson {
  final String name;
  final String role;
  final String text;
  final String url;
  final double offset;

  AboutPerson({this.name, this.role, this.text, this.url, this.offset});
}

List people = [
  AboutPerson(
    name: "Yianni Jannelli",
    role: "",
    text: yianniStr,
    url: yianniUrl,
    offset: 10.0,
  ),
  AboutPerson(
      name: "Connor Shannon",
      role: "",
      text: connorStr,
      url: connorUrl,
      offset: 0.0),
];

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle fsMed= Theme.of(context).textTheme.subtitle1.copyWith(color:Colors.black);
    TextStyle fsVLg= Theme.of(context).textTheme.headline1.copyWith(color:Colors.black);
     TextStyle fsLg= Theme.of(context).textTheme.headline3.copyWith(color:Colors.black);
    TextStyle fsSm= Theme.of(context).textTheme.subtitle2.copyWith(color:Colors.black);
    Color secondaryBackgroundColor= Theme.of(context).secondaryHeaderColor;
    // DocsRepo docsRepo =  locator<DocsRepo>();
    double w = MediaQuery.of(context).size.width;
    bool mobile = isMobile(w);
    double exp=0;
    if(w>650){
      if(w>1300.0)exp=120.0;
      else exp = 120.0*((w-650)/(1300-650));
    }
    return w < 1300.0
        ? ListView(
            children: [
              Container(
                  height: 300.0,
                  width: double.infinity,
                  child: Stack(children: [
                    Align(
                        alignment: Alignment.topCenter,
                        child: Container(height: 150.0,
                          child: Padding(
                            padding: EdgeInsets.only(top:30.0),
                            child: headTitle("About Us", secondaryBackgroundColor, fsVLg),
                          ))),
                  
                    about(w: w, top:50.0, left: -300.0 -exp, h:250.0,rotation: -math.pi/30, url: "https://scontent.fphl2-1.fna.fbcdn.net/v/t1.0-9/100087198_10163684081755092_8366618098156961792_o.jpg?_nc_cat=100&_nc_sid=8bfeb9&_nc_ohc=rhHtvC0h8WYAX9x_U4Y&_nc_ht=scontent.fphl2-1.fna&oh=13a2917d06350edf9c1b7e9132c0e39d&oe=5EEE9569"),
                    about(w: w, top:50.0, left: 110.0+exp, h:250.0,rotation: math.pi/30, url: "https://scontent.fphl2-4.fna.fbcdn.net/v/t1.0-9/95258229_10163550216665092_3526744581871763456_o.jpg?_nc_cat=106&_nc_sid=730e14&_nc_ohc=YGpT-BeCzPoAX_n3XB6&_nc_ht=scontent.fphl2-4.fna&oh=94d16b798228935ba454837473f1a167&oe=5EEF7783",),
                    about(w: w, top:150.0, h:150.0, left:exp/5, wid:150.0, url: "https://scontent.fphl2-1.fna.fbcdn.net/v/t1.0-9/92470100_10222513279318993_2011992938938105856_o.jpg?_nc_cat=103&_nc_sid=825194&_nc_ohc=vwwzrwkz6AwAX_lj92F&_nc_ht=scontent.fphl2-1.fna&oh=23bc077b056444bd72899b6307ae7fbe&oe=5EF139E1"),
                    about(w: w, top:150.0, left: -150.0-exp/5, h:150.0, wid:150.0, url: "https://scontent.fphl2-1.fna.fbcdn.net/v/t1.0-9/93378709_3139143336119330_2227783348703461376_o.jpg?_nc_cat=103&_nc_sid=825194&_nc_ohc=130g8HSRv9EAX_LUFPP&_nc_ht=scontent.fphl2-1.fna&oh=84ac83a8b613a0ef164bf9be6a2c3ffe&oe=5EEE8954"),
                   
                  ])),
                  SizedBox(height: 50.0),
                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: w>800?((w - 800) / 2): mobile? 10.0:(120 -exp)),
                  child: Text(
                    abt,
                    style: fsMed,
                  )
                  //toColumnText( safeGet(key:"AboutUs", map:docsRepo.doc.sections, alt:"")),
                  ),// toColumnText(safeGet(key:"AboutUs", map:docsRepo.doc.sections, alt:""))),
                SizedBox(height: 50.0),
              headTitle("Our Team", secondaryBackgroundColor, fsVLg),

              ...people.map((e) => PersonTile(
                fsLg: fsLg,
                fsSm: fsSm,
                    mobile: mobile,
                    person: e,
                  ))
            ],
          )
        : ListView(
            children: [
              Container(
                  height: 300.0,
                  width: double.infinity,
                  child: Stack(children: [
                    Align(
                        alignment: Alignment.topCenter,
                        child: Container(height: 150.0,
                          child: Padding(
                            padding: EdgeInsets.only(top:30.0),
                            child: headTitle("About Us", secondaryBackgroundColor, fsVLg),
                          ))),
                  
                    about(w: w, top:50.0, left: -420.0, h:250.0,rotation: -math.pi/30, url: "https://scontent.fphl2-1.fna.fbcdn.net/v/t1.0-9/100087198_10163684081755092_8366618098156961792_o.jpg?_nc_cat=100&_nc_sid=8bfeb9&_nc_ohc=rhHtvC0h8WYAX9x_U4Y&_nc_ht=scontent.fphl2-1.fna&oh=13a2917d06350edf9c1b7e9132c0e39d&oe=5EEE9569"),
                     about(w: w, top:50.0, left: 210.0, h:250.0,rotation: math.pi/30, url: "https://scontent.fphl2-4.fna.fbcdn.net/v/t1.0-9/95258229_10163550216665092_3526744581871763456_o.jpg?_nc_cat=106&_nc_sid=730e14&_nc_ohc=YGpT-BeCzPoAX_n3XB6&_nc_ht=scontent.fphl2-4.fna&oh=94d16b798228935ba454837473f1a167&oe=5EEF7783",),
                    about(w: w, top:150.0, h:200.0, wid:200.0, url: "https://scontent.fphl2-1.fna.fbcdn.net/v/t1.0-9/92470100_10222513279318993_2011992938938105856_o.jpg?_nc_cat=103&_nc_sid=825194&_nc_ohc=vwwzrwkz6AwAX_lj92F&_nc_ht=scontent.fphl2-1.fna&oh=23bc077b056444bd72899b6307ae7fbe&oe=5EF139E1"),
                    about(w: w, top:150.0, left: -220.0, h:200.0, wid:200.0, url: "https://scontent.fphl2-1.fna.fbcdn.net/v/t1.0-9/93378709_3139143336119330_2227783348703461376_o.jpg?_nc_cat=103&_nc_sid=825194&_nc_ohc=130g8HSRv9EAX_LUFPP&_nc_ht=scontent.fphl2-1.fna&oh=84ac83a8b613a0ef164bf9be6a2c3ffe&oe=5EEE8954"),
                   
                  ])),
              SizedBox(height: 50.0),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: (w - 800) / 2),
                  child: Text(
                    abt,
                    style: fsMed,
                  )
                  //toColumnText( safeGet(key:"AboutUs", map:docsRepo.doc.sections, alt:"")),
                  ),
              SizedBox(height: 50.0),
              headTitle("Our Team", secondaryBackgroundColor, fsVLg),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: people
                    .map((e) => PersonTile(
                      fsLg: fsLg,
                      fsSm: fsSm,
                          mobile: mobile,
                          person: e,
                        ))
                    .toList(),
              ),
              SizedBox(height: 100.0),
              // headTitle("Our Partners"),
            ],
          );
  }

  Widget about({double w, double left=0.0, double h=200.0, double wid= 200.0, double top=0.0, double rotation=0.0, String url})=>        Positioned(
                      left: (w / 2) + left,
                      top: top,
                      child: Transform.rotate(
                        angle:rotation,
                        child: Container(
                            height: h,
                            width: wid,
                            child: RoundedImage(url: url)
                         ),
                      ),
                    );

  Widget headTitle(String text, Color secondaryBackgroundColor, TextStyle fsVLg) => Center(
        child: Container(
          height: 150.0,
          width: double.infinity,
          color: secondaryBackgroundColor,
          //Colors.grey[300],
          child: Padding(
            padding: EdgeInsets.only(top:20.0),
            child: Text(
              text,
              style: fsVLg,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
}

class PersonTile extends StatelessWidget {
  final AboutPerson person;
  final bool mobile;
  final TextStyle fsLg;
  final TextStyle fsSm;
  PersonTile({
    Key key,
    this.mobile,
    this.person,
    @required this.fsLg, 
    @required this.fsSm,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return mobile ? mobileLayout() : desktopLayout();
  }

  Widget mobileLayout() => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            person.name,
            style: fsLg,
          ),
          SizedBox(height: 20.0),
          Container(
            height: 170.0,
            width: 150.0,
            decoration: BoxDecoration(shape: BoxShape.circle),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Transform.translate(
                offset: Offset(0.0, 0.0),
                child: Image.network(
                  person.url,
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(height: 20.0),
          Text(
            person.text,
            style: fsSm,
          )
        ]),
      );
  Widget desktopLayout() => Center(
        child: Container(
            height: 400.0,
            width: 650.0,
            child: Row(
              children: [
                Container(
                    height: 300,
                    width: 220.0,
                    child: RoundedImage(url: person.url)),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          person.name,
                          style: fsLg,
                        ),
                        SizedBox(height: 20.0),
                        Text(person.text,
                          style: fsSm,
                        )
                       
                      ]),
                ))
              ],
            )),
      );
}

String abt = '''
      We are a network of volunteers dedicated to supplying essential workplaces with personal protective equipment(PPE)-related items made from 3D printers. While most of our staff is composed of staff from learning centers across the state, many of our team members are also small businesses or simply individuals who are engineering enthusiasts. 
      
      When this crisis began and news outlets began to report that healthcare facilities were running out of essential items, we sought a way to aid them however we could. Before long, a number of local activists came together on social media to collaborate on getting supplies to those in need. Governor John Carney's office worked with these group members to pair them with the Delaware Department of Education to expand these efforts dramatically. 
      
      What did teachers and schools have that most do not? 3D printers, which can produce face shields, ear savers, and other equipment in high demand. Today, educators from most of our state's public school districts, colleges, and universities are aiding in the fight against COVID-19 by mass-producing PPE. This gear is then donated on a regular basis to medical centers, nursing homes, and hospitals throughout the state who have notified us of their needs. 
      
      Whether you work in a healthcare facility or own a 3D printer, we ask you to please join us in this fight to flatten the curve! ''';

// Yianni
String yianniUrl =
    "https://scontent.fphl2-3.fna.fbcdn.net/v/t1.0-9/94612989_10163550215880092_3340293540381982720_o.jpg?_nc_cat=102&_nc_sid=730e14&_nc_ohc=Ab1ll0Njhm0AX8WA5Ad&_nc_ht=scontent.fphl2-3.fna&oh=287772403db28d915bea68d7c336c46b&oe=5EEDBAE1";

String connorUrl =
    "https://scontent.fphl2-3.fna.fbcdn.net/v/t1.0-9/98135797_3222151604485169_380042771051839488_o.jpg?_nc_cat=101&_nc_sid=b9115d&_nc_ohc=qla0R4W5EBEAX--AYa0&_nc_ht=scontent.fphl2-3.fna&oh=cf3d73bb4daf167b78b1d64ed083b6cb&oe=5EEEDBE5";
//
String yianniStr = '''
     During these unprecedented times, we all must do what we can to protect those who are at the greatest risk of this terrible disease. 
     
     With the help of Governor John Carney's office as well as Secretary Bunting from the Delaware Department of Education (DDOE), I sent a call to action out to every public school district superintendent in the First State. I asked them to partner with me to follow the example of current students at Brandywine High School who proactively took 3D printers home from their classrooms to make PPE for local hospitals. 
     
     We have since organized and mobilized volunteers from over a dozen school districts to retrieve 3D printers from their classrooms to create PPE for those in need.
''';

String connorStr = '''
     I have lived in Delaware my whole life. I attended the Charter School of Wilmington and graduated from the University of Delaware with a Biomedical Engineering degree in 2018. Since then, I have worked in Medical Device Development. 
     
     After reading about  3D Printed Face Shields, I saw an opportunity to use my 3D Printing and Medical Device experience to help protect Medical Professionals in Delaware. In the last few months, I've teamed up with local makers to help produce over 200 face shields for medical professionals in Delaware.
     
     More recently, I've been working on building this site in order to make it easier for 3D Printing groups to connect to facilities in need of supplies.
     ''';

String missionStatement = '''
   In difficult and uncertian times like these, we have to come together as a community to help each other get through this. 
   Delaware Makes focusing on 'match-making,' connecting community members to the groups, individuals, or resources they need to get through this.
''';

String values = '''
Our actions are motivated by a few core values:
1. Transparency - 
2. Accountability - 
2. Positivity - 
3. Experimental Mindset - Solving the problems we are faces requires creativity and experimentation. 
We encourage people to test out new ideas. 
''';
/*
Values - 
Transparency
Positivity
Proactivity
Community-Focus
*/
 
                    // Positioned(
                    //   left: (w / 2) ,
                    //   top: 150.0,
                    //   child: Container(
                    //       height: 200.0,
                    //       width: 200.0,
                    //       child: Image.network(
                    //           "https://scontent.fphl2-1.fna.fbcdn.net/v/t1.0-9/92470100_10222513279318993_2011992938938105856_o.jpg?_nc_cat=103&_nc_sid=825194&_nc_ohc=vwwzrwkz6AwAX_lj92F&_nc_ht=scontent.fphl2-1.fna&oh=23bc077b056444bd72899b6307ae7fbe&oe=5EF139E1",
                    //           fit: BoxFit.fill,)),
                    // ),

// mainAxisAlignment: MainAxisAlignment.center,
//crossAxisAlignment: CrossAxisAlignment.center,
// Widget teamTitle()=>Center(
//   child: Container(height: 200.0,width: double.infinity,
//   color: Colors.grey[300],
//    child: Center(child: Text("Our Team", style: fsVLg,)),),
// );

  //  Positioned(
  //                     left: (w / 2) -220 ,
  //                     top: 150.0,
  //                     child: Container(
  //                         height: 200.0,
  //                         width: 200.0,
  //                         child: Image.network(
  //                             "https://scontent.fphl2-1.fna.fbcdn.net/v/t1.0-9/93378709_3139143336119330_2227783348703461376_o.jpg?_nc_cat=103&_nc_sid=825194&_nc_ohc=130g8HSRv9EAX_LUFPP&_nc_ht=scontent.fphl2-1.fna&oh=84ac83a8b613a0ef164bf9be6a2c3ffe&oe=5EEE8954",
  //                             fit: BoxFit.fill,)),
  //                   ),

    // Positioned(
    //                   left: (w / 2) + 210.0,
    //                   top: 50.0,
    //                   child: Transform.rotate(
    //                     angle:math.pi/30,
    //                     child: Container(
    //                         height: 250.0,
    //                         child: Image.network(
    //                             "https://scontent.fphl2-4.fna.fbcdn.net/v/t1.0-9/95258229_10163550216665092_3526744581871763456_o.jpg?_nc_cat=106&_nc_sid=730e14&_nc_ohc=YGpT-BeCzPoAX_n3XB6&_nc_ht=scontent.fphl2-4.fna&oh=94d16b798228935ba454837473f1a167&oe=5EEF7783",
    //                             fit: BoxFit.fill,
    //                             )),
    //                   ),
    //                 ),      Positioned(
                    //   left: (w / 2) - 420.0,
                    //   top: 50.0,
                    //   child: Transform.rotate(
                    //     angle:-math.pi/30,
                    //     child: Container(
                    //         height: 250.0,
                    //         child: Image.network(
                    //             "https://scontent.fphl2-1.fna.fbcdn.net/v/t1.0-9/100087198_10163684081755092_8366618098156961792_o.jpg?_nc_cat=100&_nc_sid=8bfeb9&_nc_ohc=rhHtvC0h8WYAX9x_U4Y&_nc_ht=scontent.fphl2-1.fna&oh=13a2917d06350edf9c1b7e9132c0e39d&oe=5EEE9569")),
                    //   ),
                    // ),
                  