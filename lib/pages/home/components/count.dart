import 'package:delaware_makes/counters/designCounts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CountsWidget extends StatelessWidget {
  final bool isMobile;


  CountsWidget({Key key, this.isMobile}) ;
  @override

  Widget build(BuildContext context) {
      
    var facesh =  DesignModel(designID: "5f2009e0-55a8-4d4b-aa6a-a9becf5c9392", designName: "Face Shields");
    var earsaver =   DesignModel(designID: "fa900ce5-aae8-4a69-92c3-3605f1c9b494", designName: "Ear Savers");

      facesh.init();
      earsaver.init();
      int btm = 300;
      String hsm = "35,000";
      String fs = facesh.totalQuantity.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
      String es = earsaver.totalQuantity.toString().replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
    return Container(
      color: Colors.grey,
      child: Column(
                 children:

          [Container(
           // height: 120.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
               //   countWidget(name: "Hand-Sewn Masks", quantity: "$hsm+"),
                  countWidget(name: "Face Shields", quantity: "$fs+"),
                  countWidget(name: "Ear Savers", quantity: "$es+"),
                  countWidget(name: "Bias Tape Makers", quantity: "$btm+"),
                ],
              ),
            ),
          )
        ] 
      ),
    );
   // );
  }
}


Widget countWidget({String quantity, String name}) => Container(
        child: Column(
      children: <Widget>[
        Text(
          quantity,
           style: TextStyle( color:Colors.white, fontSize:30.0)
        ),
        Text(name,
           style: TextStyle( color:Colors.white)),
        Text("Produced",
           style: TextStyle( color:Colors.white))
      ],
    ));

