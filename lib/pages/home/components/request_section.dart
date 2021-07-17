import 'package:delaware_makes/shared_widgets/rounded_image_box.dart';
import 'package:delaware_makes/shared_widgets/shared_widgets.dart';
import 'package:delaware_makes/shared_widgets/stylized_image_box.dart';
import 'package:delaware_makes/theme.dart';
import 'package:delaware_makes/utils/utils.dart';
import 'package:domore/domore.dart';
import 'package:flutter/material.dart';

class RequestSection extends StatelessWidget {
  final bool isMobile;
  final List<String> orgNames;
  final Widget requestButton;
  const RequestSection(
      {Key key,
      @required this.isMobile,
      @required this.orgNames,
      @required this.requestButton})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // var dataRepo = locator<DataRepo>();
    TextStyle aTextStyle = Theme.of(context).textTheme.headline5;
    TextStyle bTextStyle = Theme.of(context).textTheme.headline6;
    TextStyle cTextStyle =
        Theme.of(context).textTheme.headline2.copyWith(color: Colors.black);
    TextStyle dTextStyle =
        Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.black);
//https://maskcrusaders.org/delaware-receive-ppe
    //https://docs.google.com/forms/d/e/1FAIpQLSfy5UIMseILx9rBfX4bnvNMErSSrce5dVt60mPb1-iNGVhZag/viewform

    return isMobile
        ? Container(
            // height: 820.0,
            child: Column(children: [
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Is your organization in need of PPE?",
              style: cTextStyle,
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              "We can 3D Print Face Shields and Ear-Savers for you",
              style: dTextStyle,
            ),
            SizedBox(
              height: 30.0,
            ),
            Center(
              child: Container(width: 300.0, child: requestButton),
            ),
            SizedBox(
              height: 20.0,
            ),
            // TitleText(title:"Looking for Face Shields or Ear Savers?"),
            Container(
              height: 200.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      width: tileW,
                      height: tileH,
                      child: RoundedImage(
                          // bottomText: "Face Shields",
                          url:
                              "https://cdn.myminifactory.com/assets/object-assets/5e8d747938361/images/720X720-img-20200408-083219749.jpg")),
                  Container(
                      width: tileW,
                      height: tileH,
                      child: RoundedImageAsset(
                          //  bottomText: "Ear Savers",
                          url:
                              "https://www.kold.com/resizer/V2_1DOI5V4K4m57fH9SdmUKZZYg=/1400x0/arc-anglerfish-arc2-prod-raycom.s3.amazonaws.com/public/SCALPHZ4Y5GLFDNEO63FGWO76Y.jpg")),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Other Resources",
              style: dTextStyle,
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 200.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      width: tileW,
                      height: tileH,
                      child: StylizedImageBox(
                          onPressed: () =>
                              launch("https://persistshields.org/"),
                          bottomText: "Persist Shields",
                          url: "https://persistshields.org/img/shield.jpg")),
                  Container(
                      width: tileW,
                      height: tileH,
                      child: StylizedImageBox(
                          onPressed: () =>
                              launch("https://tinyurl.com/ybqyb4pz"),
                          bottomText: "Sewn Masks",
                          url:
                              "https://scontent.fphl2-3.fna.fbcdn.net/v/t1.0-9/98565508_3430997256914607_3733525460215136256_o.jpg?_nc_cat=109&_nc_sid=825194&_nc_ohc=wzgkELLakh0AX9S9jKx&_nc_ht=scontent.fphl2-3.fna&oh=1819c8caf9e013fb5a525d8513479985&oe=5EF19342")),
                ],
              ),
            ),
            Container(
              height: 200.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      width: tileW,
                      height: tileH,
                      child: StylizedImageBox(
                          onPressed: () => launch(
                              "https://maskcrusaders.org/delaware-receive-ppe"),
                          bottomText: "Mask Crusaders",
                          url:
                              "data:image/png;base64,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")),
                  Container(
                      width: tileW,
                      height: tileH,
                      child: StylizedImageBox(
                          onPressed: () =>
                              launch("https://coronavirus.delaware.gov/"),
                          bottomText: "DE Coronavirus Site",
                          url:
                              "https://coronavirus.delaware.gov/wp-content/uploads/sites/177/2020/03/dhss_logo_100.jpg")),
                ],
              ),
            ),
            SizedBox(
              height: 40.0,
            ),

            SizedBox(
              height: 20.0,
            ),
            Center(
              child: Container(
                  height: 400.0,
                  width: 400.0,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: Stack(children: [
                        Container(
                            height: double.infinity,
                            width: double.infinity,
                            child: Image.asset(
                              "christiana.jpg",
                              fit: BoxFit.cover,
                            )),
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: Colors.black.withOpacity(0.7),
                          child: Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(height: 10),
                                Text("Delivering To:", style: aTextStyle
                                    //TextStyle(/  color: Colors.white, fontSize: 20.0),
                                    ),
                                SizedBox(height: 20),
                                ...orgNames.map((e) => Padding(
                                      padding: EdgeInsets.only(top: 3.0),
                                      child: Text(e, style: bTextStyle
                                          // TextStyle( color: Colors.white,fontSize: 16.0)
                                          ),
                                    )),
                                Text("...", style: aTextStyle
                                    // TextStyle(  color: Colors.white, fontSize: 20.0),
                                    ),
                              ],
                            ),
                          ),
                        ),
                      ]))),
            ),
          ]))
        :
        //  SliverChildListDelegate(
        Container(
            height: 400.0,
            child: Row(children: [
              Expanded(
                child: Column(children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  TitleText(
                      title: "Is your organization in need of these items?"),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: Container(width: 300.0, child: requestButton

                        //  CallToActionButton(
                        //   name: "Request Donation",
                        //   onPressed: () {
                        //     var appState = locator<AppState>();
                        //     appState.initRequest();
                        //   //  formManager.setForm("request");
                        //   },
                        // ),
                        ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                          width: tileWdesk,
                          height: tileHdesk,
                          child: StylizedImageBoxAsset(
                              bottomText: "Face Shields",
                              url: "faceshield.jpg")),
                      Container(
                          width: tileWdesk,
                          height: tileHdesk,
                          child: StylizedImageBoxAsset(
                              bottomText: "Ear Savers",
                              url:
                                  "earsavers_ex.jpg")),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                ]),
              ),
              Expanded(
                child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Stack(children: [
                          Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: Image.asset(
                                "christiana.jpg",
                                fit: BoxFit.cover,
                              )),
                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            color: Colors.black.withOpacity(0.5),
                            child: Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(height: 10),
                                  Text("Delivering To:", style: aTextStyle
                                      //TextStyle( color: Colors.white, fontSize: 20.0),
                                      ),
                                  SizedBox(height: 20),
                                  ...orgNames.map((e) => Padding(
                                        padding: EdgeInsets.only(top: 3.0),
                                        child: Text(e,
                                            textAlign: TextAlign.end,
                                            style: bTextStyle
                                            //  TextStyle(color: Colors.white, fontSize: 16.0)
                                            ),
                                      )),
                                  Text("...", style: aTextStyle
                                      // TextStyle( color: Colors.white, fontSize: 20.0),
                                      ),
                                ],
                              ),
                            ),
                          ),
                        ]))),
              )
            ]),
          );
  }
}



                    //  appState.setForm("request");
                      // var formManager = locator<FormManager>();
                      // formManager.setForm("request");
                          // List orgsData = dataRepo.getItemsWhere("orgs");
    // orgsData.sort((a, b) => safeGet(map: b, key: "claims", alt: [])
    //     .length
    //     .compareTo(safeGet(map: a, key: "claims", alt: []).length));
    // orgsData = orgsData.sublist(0, 13);
    // List<String> orgNames = [];

    // orgsData.forEach((value) {
    //   String orgName = safeGet(map: value, key: "name", alt: "");
    //   if (orgName != "") orgNames.add(orgName);
    // });


                  
                  //  CallToActionButton(
                  //   name: "Request Donation",
                  //   onPressed: () {
                  //     var appState =  locator<AppState>();
                  //     appState.initRequest();
                  //   },
                  // ),