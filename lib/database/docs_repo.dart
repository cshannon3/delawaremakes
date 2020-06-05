
import 'package:cloud_firestore/cloud_firestore.dart';
String token = "_";

class GoogleDocInfo {
  String docID;
  String title;
  String text;
  Map<String, dynamic> sections={};
  GoogleDocInfo({this.docID, this.text, this.title,});
}

class DocsRepo{
  GoogleDocInfo doc=GoogleDocInfo();
  String content = "1uA3vdxTFktt6q3IFoQXtTyY6I_Tjmd9xI4lqVltWkko";

  DocsRepo();
  // add refresh and integration with firebase
  initialize(Firestore db) async {
    doc=GoogleDocInfo();
    
    loadDoc(db);
     await Future.delayed(Duration(milliseconds: 100));
  }

loadDoc(Firestore db) async {
   db.collection("texts").snapshots().listen((onData) {
      onData.documents.forEach((dataItem) {
        if (dataItem.data != null) {
          Map<String, dynamic> map = dataItem.data;
          doc.sections[map["id"]]= map["text"];
        }
      });
    });
  }
}

