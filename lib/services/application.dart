import 'package:flutter/services.dart';

void exitApp() {
  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
}
