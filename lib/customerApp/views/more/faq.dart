import 'package:flutter/material.dart';
import 'package:urban/api_urls.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: faq,
      ),
    );
  }
}
