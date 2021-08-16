import 'package:flutter/material.dart';
import 'package:urban/api_urls.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
class TermsConditions extends StatefulWidget {
  @override
  _TermsConditionsState createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: termsConditions,
        ),
      ),
    );
  }
}
