import 'package:delaware_makes/database/database.dart';
import 'package:delaware_makes/pages/home/components/intro.dart';
import 'package:delaware_makes/pages/home/components/maker_section.dart';
import 'package:delaware_makes/pages/home/components/request_section.dart';
import 'package:delaware_makes/shared_widgets/button_widgets.dart';
import 'package:delaware_makes/state/app_state.dart';
import 'package:delaware_makes/state/service_locator.dart';
import 'package:delaware_makes/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//“If you get, give. if you learn, teach”-Maya Angelou
//"Treat people as if they were what they ought to be, and you help them to become what they are capable of being." -Johann von Goethe
//"Things do not happen. Things are made to happen" -John F. Kennedy
//"Nothing will work unless you do" -Maya Angelou
//"Ever tried. Ever failed. No matter. Try again. Fail again. Fail better" -Samuel Beckett
//"Hope is not a strategy"— James Cameron
//"The most difficult thing is the decision to act. The rest is merely tenacity" - Amelia Erhart
//“The way to get good ideas is to get lots of ideas and throw out the bad ones.” - Linus Pauling
List<String> ppl = [
  "David Milunic",
  "Floyd Kingsley",
  "Jon Malenfant",
  "Donna L Watson",
  "Luann Purfield D'Agostino",
  "Michael Haggerty",
  "Matt Gordon",
  "Dave Everhart",
  "Becky Urbanek",
  "Dustin C. Dixon",
  "Kathy Buterbaugh",
  "Noelle Picara",
  "April Mei Joon",
  "Daniel Siders",
  "John Spickes",
  "Judson Wagner",
  "Jonathan Rudenberg",
  "Sani Chalima",
  "Dr. Jennifer Buckley",
  "Dr. Ajay Prasad",
  "Danielle Cekine",
  "Heidi Tumey",
  "Dee Borges",
  "Kerry Kristine",
  "Kristin Barnekov-Short",
  "Susan Bunni Bodan",
  "Paul Morriss",
];




class HomePageMain extends StatelessWidget {
  HomePageMain({
    Key key,
  }) : super(key: key);

  List<String> getOrgNames(DataRepo dataRepo) {
    //var dataRepo = locator<DataRepo>();
    List<CustomModel> orgsData = dataRepo.getModels("orgs").values.toList();
    orgsData.forEach((groupMod) => groupMod.addAssociatedIDs(
        otherCollectionName: "claims", getOneToMany: dataRepo.getOneToMany));
    orgsData.sort((a, b) => b
        .getVal("claims", associated: true, alt: [])
        .length
        .compareTo(a.getVal("claims", associated: true, alt: []).length));
    // safeGet(map: b, key:"claims", alt:[]).length.compareTo(safeGet(map: a, key:"claims", alt:[]).length));
    if (orgsData.length > 13) orgsData = orgsData.sublist(0, 13);
    List<String> orgNames = [];
    orgsData.forEach((value) {
      String name = value.getVal("name");
      if (name != null) orgNames.add(name);
    });
    return orgNames;
  }

  List<String> getGroupNames(DataRepo dataRepo) {
   // var dataRepo = locator<DataRepo>();
    List<CustomModel> groupsData = dataRepo.getItemsWhere("groups");
    groupsData.forEach((groupMod) => groupMod.addAssociatedIDs(
        otherCollectionName: "claims", getOneToMany: dataRepo.getOneToMany));
    groupsData.sort((a, b) => b
        .getVal("claims", associated: true, alt: [])
        .length
        .compareTo(a.getVal("claims", associated: true, alt: []).length));
    // safeGet(map: b, key:"claims", alt:[]).length.compareTo(safeGet(map: a, key:"claims", alt:[]).length));
    if (groupsData.length > 13) groupsData = groupsData.sublist(0, 13);
    List<String> groupsNames = [];
    groupsData.forEach((value) {
      String name = value.getVal("name");
      if (name != null) groupsNames.add(name);
    });
    return groupsNames;
  }

  Widget requestButton(AppState appState) => CallToActionButton(
        name: "Request Donation",
        onPressed: () {
          appState.initRequest();
        },
      );

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    TextStyle t =
        Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.black);
    TextStyle tt =
        Theme.of(context).textTheme.headline3.copyWith(color: Colors.black);
    bool mobile = isMobile(s.width);
    var appState = locator<AppState>();
    appState.setSize(s);
    //appState.initDesigns();
   // formatCountText(appState.designs[0].quantityDelivered);

    return Container(
        height: double.infinity,
        width: double.infinity,
        child: ListView(
          cacheExtent: 9999999999,
          children: [
            IntroBlock(
              isMobile: mobile,
              faceShieldCount: formatCountText(appState.designs[0].quantityDelivered)??"",
              earsaverCount: formatCountText(appState.designs[1].quantityDelivered)??"",
            ),
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mobile ? 5.0 : 30.0),
              child: RequestSection(
                requestButton: requestButton(appState),
                isMobile: mobile,
                orgNames: getOrgNames(appState.dataRepo),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: mobile ? 5.0 : 30.0),
              child: MakerSection(
                groupsNames: getGroupNames(appState.dataRepo),
                isMobile: mobile,
              ),
            ),
            SizedBox(height: 50),
            Container(
              color: Colors.grey[300],
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text(
                        "We'd Like To Acknowledge The Following People For Their Meaningful Contributions To The Community During This Pandemic",
                        style: tt,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            ...pplWidgets(s.width, t),
            SizedBox(height: 50),
            quoteRow(s.width),
            SizedBox(height: 50),
            Container(
                color: Colors.black,
                height: 150.0,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("If you have any questions, please contact us at:",
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.0)),
                      SizedBox(height: 10),
                      Text("delawaremakes@gmail.com",
                          style: TextStyle(color: Colors.white, fontSize: 25.0))
                    ],
                  ),
                )),
          ],
        ));
  }

  Widget quoteRow(double w) {
    List<Widget> quotes = [
      Quote(
          text:
              "Life's most persistent and urgent question is, 'What are you doing for others?'",
          author: "Martin Luther King Jr."),
      Quote(
          text: "Things do not happen. Things are made to happen",
          author: "John F Kennedy"),
      Quote(
          text:
              "The most difficult thing is the decision to act. The rest is merely tenacity",
          author: "Amelia Erhart"),
      Quote(text: "Hope is not a strategy", author: "James Cameron"),
      Quote(
          text: "If you get, give. if you learn, teach",
          author: "Maya Angelou"),
    ];
    int j = (w < 650) ? 1 : 2;
    return Row(children: quotes.sublist(0, j));
  }

  List<Widget> pplWidgets(double w, TextStyle t) {
    List<Widget> out = [];
    int i = 0;
    ppl.shuffle();
    int j = (w < 650) ? 2 : (w < 900) ? 3 : (w < 1200) ? 4 : 5;
    while (i < ppl.length) {
      List<Widget> r = [];
      int y = 0;
      while (y < j) {
        r.add(Expanded(
            child: Center(
                child: i < ppl.length
                    ? Text(
                        ppl[i],
                        style: t,
                      )
                    : SizedBox())));
        i += 1;
        y += 1;
      }
      out.add(Padding(
        padding: const EdgeInsets.all(3.0),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: r,
        ),
      ));
    }
    return out;
  }
}

class Quote extends StatelessWidget {
  final String text;
  final String author;

  const Quote({Key key, this.text = "", this.author = ""}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 50.0, right: 30),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[300].withOpacity(0.2),
              border: Border(left: BorderSide(color: Colors.black))),
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                text,
                //"Life's most persistent and urgent question is, 'What are you doing for others?'",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 16.0,
                      fontStyle: FontStyle.italic,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "       - $author",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Widget title(String titleText)=>makeSliverHeader(
//           Container( height: double.infinity,width: double.infinity,
//              child:titleText==""?null: formTitle(titleText, underline:true),
//           ),minH: 50.0, maxH: 50.0);

// DesignsPage(),
//  Container( height: 50.0,
//  width: double.infinity,
//       child: formTitle("", underline:true),),
// Gallery(w:s.width),

//"Regina Simonetti",
//"Christina Sullivan",
// "Jason Norat",
//"Claudia Shannon",

//   Center(
//   child: Container(
//     child: Text("And Thank You To Everyone Whose Working Hard To Help Their Community During These Hard Times", style: tt,
//     ),
//   ),
// ),

//             Container(
//   padding: EdgeInsets.only(left: 50.0, right: 30),
//   child: Container(
//    decoration: BoxDecoration(
//      color: Colors.grey[300].withOpacity(0.2),
//      border:Border(left: BorderSide(color:Colors.black))),
//     padding: EdgeInsets.all(20.0),
//     child: Column(
//       children: [
//             Text(

//               "Life's most persistent and urgent question is, 'What are you doing for others?'",
//            textAlign: TextAlign.center,
//             style: GoogleFonts.poppins(
//            textStyle: TextStyle(fontSize: 20.0,fontStyle:FontStyle.italic, color: Colors.black),),),
//           SizedBox(height:10),
//            Text("       - Martin Luther King Jr.", style: TextStyle(color:Colors.blue, fontWeight:FontWeight.bold),)
//       ],
//     ),
//   ),
// ),
