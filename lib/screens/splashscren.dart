import 'dart:async';
import 'package:flutter/material.dart';
import 'insert.dart';
import '../widgets/widgets.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  

   @override
  void initState(){
    super.initState();
    startTime();
  }
 
  startTime() async {
    var duration = new Duration(seconds:2);
    return new Timer (duration, route);
  }
  route(){
    Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>Insert(),transitionDuration: Duration(seconds: 0)));
    
  }
  @override
  Widget build(BuildContext context) {

    return Material(
          child: Container(
            height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("images/train.jpg",),fit: BoxFit.fitHeight,
              colorFilter: ColorFilter.mode(Color(0XFFFDFFFC).withOpacity(0.37), BlendMode.dstATop))),
        child:Padding(padding: const EdgeInsets.only(bottom:200.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [
            logo(120,120),
            title(38),
          
            
            ]
          ),
        )
        
      ),
    );
  }
}