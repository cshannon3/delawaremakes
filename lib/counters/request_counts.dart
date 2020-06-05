
import 'package:flutter/material.dart';

Map icons={
    "fa900ce5-aae8-4a69-92c3-3605f1c9b494":"https://images.squarespace-cdn.com/content/v1/597f55aa20099e0ef5ad6f39/1588881166426-SIZUR1NVBLYOBD53YB3X/ke17ZwdGBToddI8pDm48kKAwwdAfKsTlKsCcElEApLR7gQa3H78H3Y0txjaiv_0fDoOvxcdMmMKkDsyUqMSsMWxHk725yiiHCCLfrh8O1z5QPOohDIaIeljMHgDF5CVlOqpeNLcJ80NK65_fV7S1UY_1Meb8-Dj4GHImj6dpC0aR7O2ZKZedZTAz84fFYaQfMW9u6oXQZQicHHG1WEE6fg/Ear+Saver+Hydra+Single+%282000%29.png",
    "5f2009e0-55a8-4d4b-aa6a-a9becf5c9392":"https://lh3.googleusercontent.com/qny-IW0VZVfORmqJ4Uyc99nU3mVUW83947HgRizZsUdeVytRiW9oM_dBM31fxEaTwGsYNqeO2UBIxwp9z54GVv64=w640-h480-p"
};


class RequestModelCount{
    final String requestID;
    final int quantityRequested;
    final int quantityClaimed;
    final int quantityDelivered;
    final bool isDone;
   final  bool isClaimed;
    final bool isVerified;
   const RequestModelCount({
     this.isDone=false, 
     this.isClaimed=false, 
     this.isVerified=false, 
     @required this.requestID, 
      this.quantityRequested=0,
       this.quantityClaimed=0, 
       this.quantityDelivered=0,
   });
    int remaining()=>quantityRequested-quantityDelivered;

}

