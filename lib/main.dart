import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'injection_container.dart' as di;
import 'app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp
  ]);
  di.init();
  runApp(const App());
}
