import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback resumeCallBack;

  LifecycleEventHandler({this.resumeCallBack});

  @override
  Future<Null> didChangeAppLifecycleState(AppLifecycleState state) async {
    // switch (state) {
    //   case AppLifecycleState.inactive:
    //   case AppLifecycleState.paused:
    //   case AppLifecycleState.detached:
      if (AppLifecycleState.resumed == state) {
        await resumeCallBack();
      }
        
  }
}