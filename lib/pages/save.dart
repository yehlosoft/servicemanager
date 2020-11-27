import 'package:flutter/material.dart';
import 'package:train_service/pages/profile.dart';
import 'package:train_service/pages/searchresult.dart';
import 'package:train_service/widgets/bottomNavBar.dart';
import 'package:train_service/widgets/widgets.dart';
import 'package:train_service/pages/livelocation.dart';
import 'chat_screen.dart';


class SaveScreen extends StatefulWidget {
  @override
  _SaveScreenState createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
 
  @override
  Widget build(BuildContext context) {
    var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
          body: Stack(
            children: [
              Positioned(top:0,child: Container(height: screenHeight,width: screenWidth,child: saveScreenBody()),),
              
              Align(alignment: Alignment.bottomCenter,child: footer1(
                context:context,
                 w1: ()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>Profile(),transitionDuration: Duration(seconds: 0))),
                w2: ()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>Tower(),transitionDuration: Duration(seconds: 0))),
                w3: ()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>ChatScreen(),transitionDuration: Duration(seconds: 0))),
                w4:(){},               
              )),

              Positioned(bottom:15,left:100,right:100,child: footer2(
                context: context,
                w:()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>Search1(),transitionDuration: Duration(seconds: 0))),
               
              )),
            ],
          ),
    );
}

  
  
  Widget saveScreenBody() {
     var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF011627),
      extendBodyBehindAppBar: false,
      appBar: new AppBar(automaticallyImplyLeading: false,title:topRow(context),elevation: 0,backgroundColor: Color(0xFF011627),),
      body: Container(height: screenHeight,width: screenWidth,decoration: BoxDecoration(color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40),)),
      child: Column(children: [

        Padding(padding: const EdgeInsets.all(15),child: head("Downloads"),),

        Expanded(child: ListView(children: <Widget>[
         
  ],),),],)),);
}


}