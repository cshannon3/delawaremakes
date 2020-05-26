



import 'package:delaware_makes/counters/request_model.dart';
import 'package:delaware_makes/pages/locations/components/claim_tile.dart';
import 'package:delaware_makes/pages/locations/components/tickers.dart';
import 'package:delaware_makes/state/service_locator.dart';
import 'package:delaware_makes/state/state.dart';
import 'package:delaware_makes/utils/utils.dart';
import 'package:domore/state/custom_model.dart';
import 'package:flutter/material.dart';

class RequestTile extends StatelessWidget {
  final RequestModelCount requestModel;
 // final Function() setState;

   RequestTile({Key key, this.requestModel,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
      TextStyle tickerText = Theme.of(context).textTheme.caption;
      TextStyle buttonText = Theme.of(context).textTheme.button;
      TextStyle nameText = Theme.of(context).textTheme.subtitle1.copyWith(color:Colors.black);
      TextStyle addressText = Theme.of(context).textTheme.bodyText1.copyWith(color:Colors.black);
      Color buttonColor = Theme.of(context).buttonColor;
      String designID =requestModel.request.getVal("id", collection:"designs");
      String designName = requestModel.request.getVal("name", collection:"designs");
      String orgName =requestModel.request.getVal("name", collection:"orgs");
      String orgAddress = requestModel.request.getVal("address", collection:"orgs");
      String url =   safeGet(key:  designID, map: icons, alt:placeHolderUrl);


      return Padding(
        padding: EdgeInsets.symmetric(vertical:10.0),
        child: ListTile(
        title:Row(
          children: [
           Tooltip(
             message: '$requestModel.quantityRequested $designName Requested',
             child: Container(
                  height: 40.0,
                  width: 60.0,
                 decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0)),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(url),
                ),
           ),

            Expanded(child: Column(
              children: <Widget>[
                 Text(orgName, 
                  style: nameText
                 // TextStyle(fontSize:12.0, color: Colors.black),
                 ),
                 Text(orgAddress,
                  style:addressText
                  // TextStyle(fontSize:12.0, color: Colors.black),
                  ),
              ],
            ),),
          Column(children: [
              requestModel.isDone?
              DoneTicker(
                textStyle: tickerText,
                quantityDelivered: requestModel.quantityDelivered,
              ):requestModel.isClaimed?
              PendingTicker(
                textStyle: tickerText,
                quantityClaimed: requestModel.quantityClaimed,
              ):ActiveTicker(
                unclaimedTextStyle: tickerText,
                doneTextStyle: tickerText,
                quantityDelivered: requestModel.quantityDelivered,
                quantityClaimed: requestModel.quantityClaimed,
                quantityRequested: requestModel.quantityRequested,
              ),
                  Container(
                 height: 40.0,
                 child: Padding(
                   padding: EdgeInsets.all(3.0),
                   child: requestModel.isClaimed?SizedBox():claimButton(
                     color: buttonColor,
                     textStyle: buttonText
                   ),
                 ),
               ),
                ],),
          ],
          
        ),
     subtitle:Column(children: getClaimTiles(),)
        ),
      );
    }

List<Widget> getClaimTiles(){
    List<Widget> out =[];
   requestModel.request.getVal("resources", associated: true)?.
   forEach((claimID) {
      CustomModel m = requestModel.getClaimModel(claimID);
      if(m!=null)
        out.add(ClaimTile(claim:m));
    });
    return out;
    }

  Widget claimButton({
    @required TextStyle textStyle, 
    @required Color color})=> MaterialButton(
          height: 30,
          minWidth: 50.0,
          onPressed:(){
              var appState= locator<AppState>();
             //  setState();
              appState.initClaim(requestModel);
              // setState();
            
          },
          color: color,
          //textColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(18.0)),
          child: Text("Claim",
              style:  textStyle),
); }
//TextStyle(color: Colors.white, fontSize: 12.0)