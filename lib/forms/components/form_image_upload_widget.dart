
import 'package:delaware_makes/shared_widgets/shared_widgets.dart';
import 'package:delaware_makes/utils/constant.dart';
import 'package:flutter/material.dart';

import 'package:universal_html/prefer_universal/html.dart' as html;


class ImageUploadWidget extends StatefulWidget {

    final Function(html.File) uploadImageFile;
    final Function() onCheckActive;
    final String imageName;
    final String url;
  //  final bool isActive;
  const ImageUploadWidget({Key key, 
      @required this.uploadImageFile,
      this.onCheckActive, 
      this.imageName="name", 
      //this.isActive=false,
      this.url//="https://www.ajactraining.org/wp-content/uploads/2019/09/image-placeholder.jpg"
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {

  CustomLoader loader;
  String downloadurl;
  String url;
  //  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int currentIndex=0;
  
  @override
  void initState() {
    url = widget.url;
   // if(url=="")url="https://www.ajactraining.org/wp-content/uploads/2019/09/image-placeholder.jpg";
    loader = CustomLoader();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
   // print(widget.url);
    return Column(children: <Widget>[
                Center(child: Container(width:200.0, height:200.0, 
                child:Image.network((widget.url!="")?widget.url:placeHolderUrl)
                ,),),
                 MainUIButton(
                 text: "Upload",
                 onPressed:
                 (){
                   if(widget.onCheckActive())
                      uploadImage();
                 }),
                 SizedBox(height: 20.0,),
                  ]);
                  
  }

  
 uploadImage() {
    // HTML input element
    html.InputElement uploadInput = html.FileUploadInputElement();
    uploadInput.click();
    uploadInput.onChange.listen(
      (changeEvent) {
        final file = uploadInput.files.first;
        final reader = html.FileReader();
        reader.readAsDataUrl(file);
        reader.onLoadEnd.listen(
          // After file finiesh reading and loading, it will be uploaded to firebase storage
          (loadEndEvent) async {
           
             widget.uploadImageFile(file,);
          },
        );
      },
    );
  }
}




  // uploadImageFile(html.File image,
  //       ) async {
  //       //String name = safeGet(map:appstate.currentUser??{}, key:"name", alt:"");name + 
  //        loader.showLoader(context);
  //       String now = DateTime.now().toUtc().toString();
       
  //     fb.StorageReference storageRef = fb.storage().ref('userupdates/i${widget.imageName}$now');
  //      //print(label);
  //     fb.UploadTaskSnapshot uploadTaskSnapshot = await storageRef.put(image).future;
  //     // print(label);
  //     Uri imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
  //    //  print(label);
  //     loader.hideLoader();
  //     print(imageUri.toString());
  //     downloadurl=url;
  //      widget.onImageUpload(imageUri.toString());

  //     return imageUri;
  // }