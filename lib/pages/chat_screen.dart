import 'package:flutter/material.dart';
import 'package:train_service/pages/profile.dart';
import 'package:train_service/pages/livelocation.dart';
import 'package:train_service/pages/save.dart';
import 'package:train_service/pages/searchresult.dart';
import 'package:train_service/widgets/bottomNavBar.dart';
import 'package:train_service/widgets/widgets.dart';
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(children: [
              Positioned(top:0,child: Container(height: screenHeight,width: screenWidth,child: chatScreenBody()),),
              
              Align(alignment: Alignment.bottomCenter,child: footer1(
                context:context,
               w1: ()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>Profile(),transitionDuration: Duration(seconds: 0))),
                w2: ()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>Tower(),transitionDuration: Duration(seconds: 0))),
                w3:(){},
                w4: ()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>SaveScreen(),transitionDuration: Duration(seconds: 0))),
               
              )),
             
              Positioned(bottom:15,left:100,right:100,child:  footer2(
                context: context,
                w: ()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>Search1(),transitionDuration: Duration(seconds: 0))),
               
              )),
              
              Positioned(bottom:105,left:0,right:0,
                  child: Container(
                    height:40,decoration: BoxDecoration(shape: BoxShape.rectangle,
                      border: Border(bottom:BorderSide(color: Color(0XFF343F4B).withOpacity(0.53),width: 1,style: BorderStyle.solid),
                        top: BorderSide(color: Color(0XFF343F4B).withOpacity(0.53),width: 1,style: BorderStyle.solid),),),
                    child: typeMSG()),
               ),
          ],),);
}

 typeMSG() {
    return Container(height: 40,
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left:15),focusColor: Color(0XFF011627).withOpacity(0.44),
          hintText: "   Enter Your Message Here",hintStyle: const TextStyle(color: Colors.black,fontFamily: "Roboto",fontSize: 12),
          fillColor: Color(0XFFFdFFFC),filled: true,
          prefixIcon: Image(image: AssetImage("images/keyboard.png"),height: 20,width:40,color: Color(0XFFFFF95F62)),
          suffixIcon: Image(image: AssetImage("images/sent.png"),height: 20,width:40,color: Color(0XFFFFF95F62)),
        )
      ),
    );
  }

  Widget chatScreenBody() {
    var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF011627),
      extendBodyBehindAppBar: false,
      appBar: new AppBar(automaticallyImplyLeading: false,title:topRow(context),elevation: 0,backgroundColor: Color(0xFF011627),),
      body: Container(height: screenHeight,width: screenWidth,decoration: BoxDecoration(color: Color(0XFFFdFFFC),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40),)),
              child: Padding(padding: const EdgeInsets.only(left:10.0,right: 10),
              child: Column(children: [
                  Padding(padding: const EdgeInsets.only(left:30,right:30,bottom: 10),child: _lobbyName(),),
                  Container(height: screenHeight-270,
                    child: Expanded(child: ListView(children: <Widget>[
                        
                        _incomingMSG("I am waiting for my train"),
                        _outgoingMSG("asd"),
                        _incomingMSG("I am waiting for my train"),
                        _outgoingMSG(""),
                        _incomingMSG("I am waiting for my train"),
                        _outgoingMSG(""),
                        _incomingMSG("I am waiting for my train"),
                        _outgoingMSG(""),
                        _incomingMSG("I am waiting for my train"),
                        _outgoingMSG(""),
                        _incomingMSG("I am waiting for my train"),
                        _outgoingMSG(""),
                        _incomingMSG("I am waiting for my train"),
                        _outgoingMSG(""),
                        _incomingMSG("I am waiting for my train"),
                        _outgoingMSG(""),
                        _incomingMSG("I am waiting for my train"),
                        _outgoingMSG(""),
                        _incomingMSG("I am waiting for my train"),
                        _outgoingMSG(""),
                        _incomingMSG("I am waiting for my train"),
                        _outgoingMSG(""),
                        _incomingMSG("I am waiting for my train"),
                        _outgoingMSG(""),
                        _incomingMSG("I am waiting for my train"),
                        _outgoingMSG(""),
                        _incomingMSG("I am waiting for my train"),
                        _outgoingMSG(""),
                        _incomingMSG("I am waiting for my train"),
                        _outgoingMSG(""),
                        _incomingMSG("I am waiting for my train"),
                        _outgoingMSG(""),
                        _incomingMSG("I am waiting for my train"),
                        _outgoingMSG(""),
                        _incomingMSG("I am waiting for my train"),
                        _outgoingMSG(""),
                        _incomingMSG("I am waiting for my train"),
                        _outgoingMSG(""),
                        _incomingMSG("I am waiting for my train"),
                        _outgoingMSG(""),
                        SizedBox(height:10),
          ],),
      ),),],),))
    );
  }
 
  _lobbyName() {
    var screenWidth=MediaQuery.of(context).size.width;
    return Container(width: screenWidth,height:40,decoration: BoxDecoration(color: Color(0xFF8080C5).withOpacity(0.3),
        borderRadius: BorderRadius.all( Radius.circular(5),)),
      child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
        Image(image: AssetImage("images/chat1.png",),height: 35,width: 35,),
        SizedBox(width:10),
        Text("kalyan chat lobby".toUpperCase(),style: const TextStyle(color: Color(0XFFF95F62),fontFamily: "Norwester",fontSize: 18,fontWeight: FontWeight.bold),)
    ],),);
  }

  _incomingMSG(String a) {
    var screenWidth=MediaQuery.of(context).size.width;
    return Row(crossAxisAlignment:CrossAxisAlignment.start,
      children: [
      CircleAvatar(backgroundColor: Color(0XFFC0CCDA),radius: 20,),
      SizedBox(width:5),
      Column(crossAxisAlignment:CrossAxisAlignment.start,children: [
          SizedBox(height:5),
          Container(width:0.6*screenWidth,height: 40,decoration: BoxDecoration(color: Color(0XFFC0CCDA),
              borderRadius: BorderRadius.all( Radius.circular(3),)),
            child: Padding(padding: const EdgeInsets.all(8.0),
              child: Text(a,style: const TextStyle(color: Color(0XFF47525E),fontSize: 12,fontFamily: "Roboto"),),),),
            Text("Ravi Shastri",style: const TextStyle(color: Color(0XFFF95F62),fontSize: 9,fontFamily: "Roboto"),)
        ],
      )
    ],);
  }

  _outgoingMSG(String a) {
    var screenWidth=MediaQuery.of(context).size.width;
    return Row(mainAxisAlignment: MainAxisAlignment.end,children: [
    Container(width:0.6*screenWidth,height: 40,decoration: BoxDecoration(color: Color(0XFFC0CCDA),
            borderRadius: BorderRadius.all( Radius.circular(3),)),
            child: Align(alignment: Alignment.centerRight,
              child: Padding(padding: const EdgeInsets.all(8.0),
                child: Text(a,style: const TextStyle(color: Colors.black,fontSize: 12,fontFamily: "Roboto"),),
      )),),],
    );
  }
}