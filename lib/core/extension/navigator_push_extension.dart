import 'dart:developer';

import 'package:flutter/material.dart';

extension NavigatorPushExtension on BuildContext {
  void navToPush(Widget page) {
    log("navToPush: $page");
    Navigator.push(this, MaterialPageRoute(builder: (context) => page));
  }
}
