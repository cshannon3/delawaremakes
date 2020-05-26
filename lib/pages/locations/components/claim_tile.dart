


import 'package:domore/state/custom_model.dart';
import 'package:flutter/material.dart';

class ClaimTile extends StatelessWidget {
    final CustomModel claim;

  const ClaimTile({Key key, this.claim}) : super(key: key);
    @override
    Widget build(BuildContext context) {

    bool isClaimDone = claim.oneToManyData.containsKey("resources")&&claim.oneToManyData["resources"].length>0;
    String userName = claim.getVal("name", collection:"users");
     String groupName = claim.getVal("name", collection:"groups");
    return Container(
      child:Padding(
        padding: EdgeInsets.only(left:50.0),
        child: 
            Row(
              children: <Widget>[
                Container(
                  height: 30.0, width:30.0,
                  child:
                    Center(child: Text("${claim.getVal("quantity", alt:0)}"
                    ,style: TextStyle(fontSize:14.0, color: Colors.green),
                    )),
                ),
                    Text("$userName",
                     style: TextStyle(fontSize:12.0
                     ),
                     ),
                    Text("($groupName)", style:
                     TextStyle(fontSize:10.0),
                     ),
                     Expanded(child: Container(),),
                     isClaimDone?SizedBox():Padding(
             padding: EdgeInsets.all(5.0),
           ),
              ],
              
            ),
      ),
      );
    }
 }
  
