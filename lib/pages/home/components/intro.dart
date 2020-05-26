
import 'package:delaware_makes/pages/home/components/count.dart';
import 'package:delaware_makes/state/docs_repo.dart';
import 'package:delaware_makes/state/service_locator.dart';
import 'package:delaware_makes/state/app_state.dart';
import 'package:delaware_makes/utils/utils.dart';
import 'package:flutter/material.dart';

class IntroBlock extends StatelessWidget {
  final bool isMobile;

  const IntroBlock({Key key,@required this.isMobile}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DocsRepo docsRepo =  locator<DocsRepo>();
    TextStyle titleTextStyle= Theme.of(context).textTheme.headline1;
    Color secondaryBackgroundColor= Theme.of(context).secondaryHeaderColor;

    return Container(
      height:500.0,
       color:secondaryBackgroundColor,
       // Colors.grey[300],
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
                            style: titleTextStyle //TextStyle(color: Colors.black, fontSize: 50.0)
                            ),
                      ),
                         SizedBox(height: 20.0,),
                       Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: 
                          toRichText(safeGet(key:"Intro", map:docsRepo.doc.sections, alt:""))
                  ),
                    ],
                  ),
                ),
                 SizedBox(height: 65.0,),
                    CountsWidget(isMobile:isMobile)
              ],
        ),
      ),
    );
  }
}

//#size18#We are a network of volunteers dedicated to supplying essential workplaces with locally-produced personal protective equipment(PPE).#size35#