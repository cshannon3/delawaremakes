import 'package:delaware_makes/forms/components/form_components.dart';
import 'package:delaware_makes/forms/form_manager.dart';
import 'package:delaware_makes/pages/home/home_constants.dart';
import 'package:delaware_makes/service_locator.dart';
import 'package:delaware_makes/shared_widgets/shared_widgets.dart';
import 'package:delaware_makes/state/data_repo.dart';
import 'package:delaware_makes/utils/utils.dart';
import 'package:flutter/material.dart';


class RequestSection extends StatelessWidget {
  final bool isMobile;
  const RequestSection({Key key, @required this.isMobile}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var dataRepo = locator<DataRepo>();
    List orgsData = dataRepo.getItemsWhere("orgs",getLinkedData: true);
    orgsData.sort((a, b) => safeGet(map: b, key: "claims", alt: [])
        .length
        .compareTo(safeGet(map: a, key: "claims", alt: []).length));
    orgsData = orgsData.sublist(0, 13);
    List<String> orgNames = [];

    orgsData.forEach((value) {
      String orgName = safeGet(map: value, key: "name", alt: "");
      if (orgName != "") orgNames.add(orgName);
    });

    return isMobile
        ? Container(
            height: 820.0,
            child: Column(children: [
              SizedBox(
                height: 20.0,
              ),
              FormTitle(title:"Is your organization in need of the following items?"),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Container(
                  width: 300.0,
                  child: CallToActionButton(
                    name: "Request Donation",
                    onPressed: () {
                      var formManager = locator<FormManager>();
                      formManager.setForm("request");
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
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
                            bottomText: "Face Shields",
                            url:
                                "https://cdn.myminifactory.com/assets/object-assets/5e8d747938361/images/720X720-img-20200408-083219749.jpg")),
                    Container(
                        width: tileW,
                        height: tileH,
                        child: StylizedImageBox(
                            bottomText: "Ear Savers",
                            url:
                                "https://www.kold.com/resizer/V2_1DOI5V4K4m57fH9SdmUKZZYg=/1400x0/arc-anglerfish-arc2-prod-raycom.s3.amazonaws.com/public/SCALPHZ4Y5GLFDNEO63FGWO76Y.jpg")),
                  ],
                ),
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
                              child: Image.network(
                                "https://scontent.fphl2-4.fna.fbcdn.net/v/t1.0-9/95258229_10163550216665092_3526744581871763456_o.jpg?_nc_cat=106&_nc_sid=730e14&_nc_ohc=osXWIpSl0TwAX_dU703&_nc_ht=scontent.fphl2-4.fna&oh=ad5931b1d34d6a55638c77f00dd25bae&oe=5EEB8303",
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
                                  Text(
                                    "Delivering To:",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  ),
                                  SizedBox(height: 20),
                                  ...orgNames.map((e) => Padding(
                                        padding: EdgeInsets.only(top: 3.0),
                                        child: Text(e,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0)),
                                      )),
                                  Text(
                                    "...",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
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
                  FormTitle(title:"Is your organization in need of these items?"),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: Container(
                      width: 300.0,
                      child: CallToActionButton(
                        name: "Request Donation",
                        onPressed: () {
                          var formManager = locator<FormManager>();
                          formManager.setForm("request");
                        },
                      ),
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
                          child: StylizedImageBox(
                              bottomText: "Face Shields",
                              url:
                                  "https://cdn.myminifactory.com/assets/object-assets/5e8d747938361/images/720X720-img-20200408-083219749.jpg")),
                      Container(
                          width: tileWdesk,
                          height: tileHdesk,
                          child: StylizedImageBox(
                              bottomText: "Ear Savers",
                              url:
                                  "https://www.kold.com/resizer/V2_1DOI5V4K4m57fH9SdmUKZZYg=/1400x0/arc-anglerfish-arc2-prod-raycom.s3.amazonaws.com/public/SCALPHZ4Y5GLFDNEO63FGWO76Y.jpg")),
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
                              child: Image.network(
                                "https://scontent.fphl2-4.fna.fbcdn.net/v/t1.0-9/95258229_10163550216665092_3526744581871763456_o.jpg?_nc_cat=106&_nc_sid=730e14&_nc_ohc=osXWIpSl0TwAX_dU703&_nc_ht=scontent.fphl2-4.fna&oh=ad5931b1d34d6a55638c77f00dd25bae&oe=5EEB8303",
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
                                  Text(
                                    "Delivering To:",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  ),
                                  SizedBox(height: 20),
                                  ...orgNames.map((e) => Padding(
                                        padding: EdgeInsets.only(top: 3.0),
                                        child: Text(e,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0)),
                                      )),
                                  Text(
                                    "...",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
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
