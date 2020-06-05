import 'package:delaware_makes/database/database.dart';
import 'package:flutter/material.dart';

/*

*/



class ClaimTile extends StatelessWidget {
    final CustomModel claim;
    final Function() update;
    final bool isDone;
    

  ClaimTile({Key key, this.claim, this.update, @required this.isDone}) : super(key: key);
    @override
    Widget build(BuildContext context) {
      String userName = claim.getVal("name", collection:"users");
     String groupName = claim.getVal("name", collection:"groups");
     if(userName=="")userName= claim.getVal("userName",);


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
                    )
                  ),
                ),
                    Text("$userName", style: TextStyle(fontSize:12.0 ,color:Colors.black),),
                    Text("($groupName)", style: TextStyle(fontSize:10.0,color:Colors.black), ),
                     Expanded(child: Container(),),
                     isDone?SizedBox():Padding(
             padding: EdgeInsets.all(5.0),
           ),
          isDone?SizedBox(): updateButton()
              ],
              
            ),
          ),
      );
    }


       Widget updateButton()=> MaterialButton(
                      height: 30,
                      minWidth: 50.0,
                      onPressed: ()=>update(),
                      color: Colors.orangeAccent,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0)),
                      child: Text("Update",
                          style:  TextStyle(color: Colors.white, fontSize: 12.0)),
            );
 }
  


  // print("Claim Tile");
    //  print( claim.oneToManyData);
  //bool isClaimDone = claim.oneToManyData.containsKey("resources")&&claim.oneToManyData["resources"].length>0;
 