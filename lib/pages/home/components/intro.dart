
import 'package:delaware_makes/pages/home/components/count.dart';
import 'package:delaware_makes/service_locator.dart';
import 'package:delaware_makes/state/app_state.dart';
import 'package:delaware_makes/utils/utils.dart';
import 'package:flutter/material.dart';

class IntroBlock extends StatelessWidget {
  final bool isMobile;

  const IntroBlock({Key key,@required this.isMobile}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AppState state =  locator<AppState>();
    return Container(
      height:500.0,
       color: Colors.grey[300],
      child: Center(
        child: Column(
              children: <Widget>[
                SizedBox(height:50),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text("Welcome to Delaware Makes",
                        textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            style: TextStyle(color: Colors.black, fontSize: 50.0)),
                      ),
                         SizedBox(height: 20.0,),
                       Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: 
                          toRichText(safeGet(key:"Intro", map:state.docsRepo.doc.sections, alt:""))
                  ),
                    ],
                  ),
                ),
                
                 SizedBox(height: 65.0,),
               // Divider(color: Colors.black,),
            
                    CountsWidget(isMobile:isMobile)
              ],
        ),
      ),
    );
  }
}

