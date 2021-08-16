import 'package:flutter/material.dart';
import 'package:urban/api_urls.dart';
import 'package:webview_flutter/webview_flutter.dart';
class EmergencyResources extends StatefulWidget {
  @override
  _EmergencyResourcesState createState() => _EmergencyResourcesState();
}

class _EmergencyResourcesState extends State<EmergencyResources> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: emgRes,
      ),
    );
  }
}
