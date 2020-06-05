
import 'package:delaware_makes/shared_widgets/shared_widgets.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';
import 'components/form_components.dart';
import 'form_model.dart';

import '../extensions/hover_extension.dart';
import 'package:universal_html/prefer_universal/html.dart' as html;

class FormOverlay extends StatefulWidget {
  final Function() onDone;//final List<FormModel> forms;
  final Function(bool) onSubmit;
  final FormModel formModel;
  final Function(html.File) uploadImageFile;
  final bool isFullView;
  final Widget child;


  FormOverlay({
    Key key, 
    @required this.formModel, 
    this.uploadImageFile, 
    @required this.onDone, 
    this.isFullView=false, 
    @required this.child, 
    @required this.onSubmit,//  @required this.forms,//@required this.onComplete
  }) : super(key: key);
  @override
  _FormOverlayState createState() => _FormOverlayState();
}


class _FormOverlayState extends State<FormOverlay> { // int currentScreenNum = 0; // Map buffer;//AppState appstate;
   CustomLoader loader;
   FormModel activeModel;
    final  List<GlobalKey<FormState>>formKeys =  [];

  @override
  void initState() {
     super.initState();
      loader = CustomLoader();
      activeModel= widget.formModel;  
      activeModel.init();
      activeModel.getTabs().forEach((element) {
        formKeys.add(new GlobalKey<FormState>());
      });

  }
  @override
  void dispose() {
    formKeys.forEach((element) {
      if(element!=null &&element.currentState!=null )
      element.currentState.dispose();
    });
    super.dispose();
  }
Map<String, dynamic> validators={
    "email":(val)=>(validateEmail(val))?null:'Please enter email correctly',  
};

  @override
  Widget build(BuildContext context) {
   // Size s = MediaQuery.of(context).size;
    //(activeModel.name);
    return widget.isFullView?fullView():overlayView();
  //);
  }

  Widget fullView()=>Stack(
    children: [
      widget.child,
      formTab(true),
      CloseButton(
        onPressed: ()=>widget.onDone()
      ),

    ],
  );

  Widget overlayView()=> Stack(
      children: <Widget>[
        widget.child,
        InkWell(
          excludeFromSemantics: true,
          onTap: (){
              widget.onDone(); 
              setState(() {
              });
            },
          child: Container( height: double.infinity,
          width: double.infinity,
          color: Colors.grey.withOpacity(0.7),
          ),
        ),

        Center(child: Container(
      width: 400.0,
      child:
         Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
              progressRow(),
              SizedBox( height: 10.0, ), 
              formTab(false) 
          ]),
      ))

       
      ],
    );


  Widget formTab(bool full){
 //   print("fform tab");
    List<Widget> items = [];int i =0;
   // print(activeModel.currentForm.formData["items"]);
    activeModel.currentForm.formData["items"].forEach((data) {
      items.add(line(data, i));
      items.add(SizedBox(height:safeGet(key: "b", map: data, alt: 0.0),));
      i+=1;
    });
    if(full)items.add(SizedBox(height:300.0));
    return  padForm(
      Center(
          child: Container(
            child: Form(
              key: formKeys[activeModel.currentScreenNum],
              child: ListView(
                children:items
          ),
            )),
        ),
        h:full?double.infinity:
        safeGet(key: "h", map: activeModel.currentForm.formData, alt: 450.0),
        w: full?double.infinity:400.0
    );
  }



  Widget iconButton(int itemNum){
        bool current = itemNum==activeModel.currentScreenNum;
        bool done =activeModel.getTabs()[itemNum].isCompleted;
      return  Container(
          decoration: BoxDecoration(
          border: Border.all(color:current?Colors.blue:done?Colors.green:Colors.grey, width: 2.0),
            shape:BoxShape.circle
            ),
          child:Tooltip(
            message: safeGet(key: "tooltip", map: activeModel.getTabs()[itemNum].formData, alt: "Tooltip"),
            child: Padding(
              padding: EdgeInsets.all(3.0),
              child: IconButton(
                onPressed: (){
                  bool isAvailable=true;
                  for (int i = 0;i<itemNum; i++){
                    if(!activeModel.getTabs()[itemNum].isCompleted)
                      isAvailable=false;
                  }
                  if(isAvailable){ setState(() { activeModel.currentScreenNum=itemNum; }); }
                },
                icon: Icon(
                  safeGet(key: "icon", map: activeModel.getTabs()[itemNum].formData, alt: Icons.reorder),
                   color: done?Colors.green:Colors.grey,)),
            ),
          )).showCursorOnHover.moveUpOnHover;
        }

  Widget progressRow(){
    List<Widget> icons =[];
    int i=0;
    activeModel.getTabs().forEach((form) {
      if(form.showIconBar){
        icons.add(iconButton(i));
      }i+=1;
    });return Container(
        decoration: BoxDecoration(
                color: Colors.white,//.withOpacity(0.9),
                borderRadius: BorderRadius.all(Radius.circular(50.0)), ),
        width: 400.0,
        child: Padding(padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: icons  ),
        ),
      );
  }



  Widget line(Map data, int index){
     String type  = safeGet(key: "type", map: data, alt: "");
     String text  = safeGet(key: "text", map: data, alt: "");
     String tooltip = safeGet(key: "tooltip", map: data, alt: null);
     switch (type) {
        case "title": 
        return FormTitle(title:text);
       break;
        case "description":
        return FormDescription(title:text,tooltip: tooltip,); 
        break;
        case "image":
          String url = safeGet(key: "url", map: data, alt: "");
          return  Container(
            height:200.0,
            child: Center(child: Container(width:200.0, height:200.0, 
                  child:Image.network((url!="")?url:placeHolderUrl)
                  ,),),
          );
          break;
        case "formEntryField":
              String key  = safeGet(key: "key", map: data, alt: "");
              int maxLines  = safeGet(key: "maxLines", map: data, alt: 1);
              String validator =  safeGet(key: "validator", map: data, alt: "empty");
              validators.containsKey(validator);
              var v = activeModel.currentForm.getVal(key);

             var f = new FormEntryField(
                  maxLines: maxLines,
                  initVal: v,
                  validator: safeGet(key: validator, map: validators, alt: null),
                  labelText: text,hint: text,
                  onChange:(val)=> setState(() { activeModel.currentForm.setKey(key, val);} ));
            return f;
         break;

        case "imageInputForm":
              String key  = safeGet(key: "key", map: data, alt: "");
              String url=  safeGet(key: "url", map: data, alt: null);
              String name  = safeGet(key: "name", map: data, alt: "");
              var v = activeModel.currentForm.formData["buffer"]["requests"][key];
           //   print(key);
             // print(v);
             return StylizedImageFormInput(
                  initVal: v,
                  url: url,
                  name: name,//hint: text,
                  onChange:(val)=> setState(() { activeModel.currentForm.formData["buffer"]["requests"][key]=val;}));
         break;

         case "imageUpload":
              String key  = safeGet(key: "key", map: data, alt: "");
              String url=  activeModel.currentForm.getVal(key);
              String name  =activeModel.currentForm.getVal("name");
            //  print(name);
             // bool  isActive =currentForm.getVal("isActive")??false;
             return ImageUploadWidget(
                  url: url,
                  imageName: name,
                  onCheckActive:(){
                 return true;
                  },
                  uploadImageFile:widget.uploadImageFile);
         break;
        case "dropdown":
              List ite = safeGet(key: "items", map: data, alt: (val){});
              String key  = safeGet(key: "key", map: data, alt: "");
              var v = activeModel.currentForm.getVal(key);  //  Function(dynamic) onChange  = safeGet(key: "onChange", map: data, alt: (val){});
             return FormDropDown(
               options: ite, 
               onChange: (val)=> setState(() { activeModel.currentForm.setKey(key, ite[val]); }) ,
               selectedIndex:ite.contains(v) ?ite.indexOf(v):0,
              );
         break;
        case "submitButton": // print(currentForm.formData["buffer"]);
          bool submit =  safeGet(key: "submit", map: data, alt:false);
          return MainUIButton(onPressed:() async{
           // print("Hello Submit");
           // if(!currentForm.validate){
             bool done;
            if(formKeys[activeModel.currentScreenNum].currentState.validate()){
              formKeys[activeModel.currentScreenNum].currentState.save();
              loader.showLoader(context);
              activeModel.currentForm.isCompleted=true;
               activeModel.next().then((isDone) {
                 done=isDone;
               }).whenComplete(() async{
                   loader.hideLoader();
                  if(submit)await widget.onSubmit(done);
                   else if(done)widget.onDone();
                   else{
                     setState(() { });
                   }
                 } 
               );
            }}, text: text,);
           break;
       default:
       return Container();
     }
  }
}

    Widget padForm(Widget widget, {double h = 400, double w = 400.0}) => Center(
    child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        width: w,
        height: h,
        child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: widget)));



// class Positions{

// }


      // case "expanded":
      // return Expanded(child: Container(),);

 //print(activeModel.currentScreenNum);
                  //  if((
                  //    activeModel.currentScreenNum)>=activeModel.getTabs().length){
                  //    widget.onDone(true);
                  //    }
                //     setState(() { 
                //       print(activeModel.currentScreenNum);
                // });

        // }else{
                    //   activeModel.currentScreenNum += 1;
                    // }

        // .then((value) {}).whenComplete((){
        //            loader.hideLoader();
        //            print(activeModel.currentScreenNum);
        //            if((activeModel.currentScreenNum)>=activeModel.getTabs().length){
                     
        //             }else{
        //               activeModel.currentScreenNum += 1;
        //             }
        //             setState(() { 
        //               print(activeModel.currentScreenNum);
        //              }); } 

                  //  }else{
                    //  print("error"); // customSnackBar(scaf, "Enter Valid Code");
                      //  return false;
                    //} 
                      //  if (checkCode()){
                     //       print("validate");//  currentForm.formKey.currentState.save();
                              // FormOverlay(
        //   formModel:activeModel,
        //   uploadImageFile: uploadImageFile,
        //   onDone:(){isActive=false;notifyListeners();}
        // )),