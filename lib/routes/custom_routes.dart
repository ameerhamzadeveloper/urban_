import 'package:flutter/material.dart';
import 'package:urban/incoming_audio_call.dart';
import 'package:urban/not_found_page.dart';
import 'package:urban/routes/routes_names.dart';


class CustomRoutes {
  static Route<dynamic> allRoutes(RouteSettings setting) {
    switch (setting.name) {
      case audioIncomming:
        return MaterialPageRoute(builder: (_) => IncomingAudioCall());

    }
    return MaterialPageRoute(builder: (_) => NotFoundPage());
  }
}
