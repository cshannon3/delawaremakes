// import 'package:universal_html/html.dart';
// import 'dart:ui' as ui;

// import 'package:flutter/material.dart';

// class IframeScreen extends StatefulWidget {
//   const IframeScreen({Key key}) : super(key: key);

//   @override
//   _IframeScreenState createState() => _IframeScreenState();
// }

// class _IframeScreenState extends State<IframeScreen> {
//   Widget _iframeWidget;

//   final IFrameElement _iframeElement = IFrameElement();

//   final _textController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     _iframeElement.height = '500';
//     _iframeElement.width = '500';

//     _iframeElement.src = ' https://www.youtube.com/embed/UeKfZ5r9s9s';
//     _iframeElement.style.border = 'none';

//     // ignore: undefined_prefixed_name
//     ui.platformViewRegistry.registerViewFactory(
//       'iframeElement',
//       (int viewId) => _iframeElement,
//     );

//     _iframeWidget = HtmlElementView(
//       key: UniqueKey(),
//       viewType: 'iframeElement',
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     //
//     final _width = 600.0;

//     final _height = _width*9/16;
//     return  SizedBox(
//           height: _height,
//           width: _width,
//           child: _iframeWidget,
//     );
//   }
  
// }