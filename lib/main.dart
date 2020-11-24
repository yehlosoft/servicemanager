import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splashscren.dart';

void main() =>runApp(MyApp());
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
    return MaterialApp(
  debugShowCheckedModeBanner: false,
  initialRoute:'/splash' ,
  routes: { 
    '/splash':(context) => SplashScreen(),    
  },
);
  }
}
