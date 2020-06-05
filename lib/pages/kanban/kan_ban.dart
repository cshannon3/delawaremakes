
  
import 'package:flutter/material.dart';


/*

https://medium.com/flutter-community/a-deep-dive-into-draggable-and-dragtarget-in-flutter-487919f6f1e4

*/


class Item {
  int id;
  int row;
  final String text;

  Item({@required this.id, this.text="", this.row=0,});
}


class KanBan extends StatefulWidget {
  KanBan({Key key}) : super(key: key);

  createState() => KanBanState();
}

class KanBanState extends State<KanBan> {
  /// Map to keep track of score

  /// Choices for game
  // Random seed to shuffle order of items.
  int seed = 0;
  //List<Widget> requested, claimed, done;
  Map<int, Item> items={};
  @override
  void initState() {
    items={
      1:Item(row: 0, id:1),
      2:Item(row: 0, id:2),
      3:Item(row: 1, id:3),
      4:Item(row: 2, id:4),
    };
    super.initState();
   
  }


  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    
    return  Row(
       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("Open Requests"),),
                ),
                Expanded(
                  child: ListView(
                      children: [
                      ...items.values.where((item) =>item.row==0).map((item) => _buildDraggable(item, s)),
                      _buildDragTarget(s,0)
                      ]),
                ),
              ],
            )
            ),
          Expanded(
            child:  Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("Claimed"),),
                ),
                Expanded(
                  child: ListView(
                      children: [
                      ...items.values.where((item) =>item.row==1).map((item) => _buildDraggable(item, s)),
                      _buildDragTarget(s,1)
                      ]),
                ),
              ],
            )
          ),
             Expanded(
               child:Column(
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Center(child: Text("Completed"),),
                   ),
                   Expanded(
                     child: ListView(
                      children: [
                      ...items.values.where((item) =>item.row==2).map((item) => _buildDraggable(item, s)),
                      _buildDragTarget(s,2)
                      ]),
                   ),
                 ],
               )
             ),
        ],
    
    );
  }


  Widget _buildDragTarget(Size s, int rowNum) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150.0,
         width: s.width/4,
                    color: Colors.green,
                    child: DragTarget(
                      builder:
                          (context, List<int> candidateData, rejectedData) {
                        return Center(child: Text("", style: TextStyle(color: Colors.white, fontSize: 22.0),));
                      },
                      onWillAccept: (data) {
                        return true;
                      },
                      onAccept: (data) {
                        setState(() {
                          items[data].row=rowNum;
                          // claimed.add(requested.last);
                          // requested.removeLast();
                          
                        });
                       
                      },
                    ),
                  ),
    );
    
  }

  Widget _buildDraggable(Item item, Size s){

    return   Padding(
      padding:  EdgeInsets.all(8.0),
      child: Draggable(
                data: item.id,
                child: Container(
                  height: 150.0,
                  width: s.width/4,
                  child: Center(
                    child: Text(
                      item.text,
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    ),
                  ),
                  color: Colors.pink,
                ),
                feedback: Container(
                  width: s.width/4,
                  height: 150.0,
                  child: Center(
                    child: Text(
                      item.text,
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                    ),
                  ),
                  color: Colors.pink,
                )),
    );
  }
}


 // requested = [
    //   _buildDraggable()
    // ];
    // claimed = [
    //   _buildDragTarget(),
    //   _buildDragTarget(),
    // ];
    // done= [
    //   _buildDragTarget(),
    //   _buildDragTarget(),
    // ];