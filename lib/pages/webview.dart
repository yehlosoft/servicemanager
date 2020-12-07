import 'package:flutter/material.dart';
import 'package:train_service/widgets/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';


class WebVBody extends StatefulWidget {
   final String abc;

  WebVBody({this.abc});

  @override
  _WebVBodyState createState() => _WebVBodyState();
}

class _WebVBodyState extends State<WebVBody> {
  final Completer<WebViewController>_controller=Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: false,
      appBar: new AppBar(automaticallyImplyLeading: false,title:topRow(context),elevation: 0,backgroundColor: Color(0xFF011627),),
      body: WebView( 
                initialUrl: widget.abc,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webc){
                  _controller.complete(webc);
                },
      ),
    );
  }
}
