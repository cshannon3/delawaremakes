
import 'package:delaware_makes/service_locator.dart';
import 'package:delaware_makes/state/app_state.dart';
import 'package:delaware_makes/utils/utils.dart';
import 'package:flutter/material.dart';
class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppState state =  locator<AppState>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal:20.0, vertical: 40.0),
      child:  toListText(
              safeGet(key:"AboutUs", map:state.docsRepo.doc.sections, alt:""))
    );
   
  }
}
// Yianni
//https://scontent.fphl2-3.fna.fbcdn.net/v/t1.0-9/94612989_10163550215880092_3340293540381982720_o.jpg?_nc_cat=102&_nc_sid=730e14&_nc_ohc=Ab1ll0Njhm0AX8WA5Ad&_nc_ht=scontent.fphl2-3.fna&oh=287772403db28d915bea68d7c336c46b&oe=5EEDBAE1

//Connor
//
//