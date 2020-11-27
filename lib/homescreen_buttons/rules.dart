import 'package:flutter/material.dart';
import 'package:train_service/pages/chat_screen.dart';
import 'package:train_service/pages/profile.dart';
import 'package:train_service/pages/searchresult.dart';
import 'package:train_service/widgets/bottomNavBar.dart';
import 'package:train_service/widgets/widgets.dart';
import 'package:train_service/pages/livelocation.dart';


class RulesScreen extends StatefulWidget {
  @override
  _RulesScreenState createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen> {
   int _currentIndex =1;
   int isSelected=1;
   int _currentIndex2=0;
   int isSelected2=0;
  @override
  Widget build(BuildContext context) {
    var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
          body: Stack(
            children: [
              Positioned(top:0,child: Container(height: screenHeight,width: screenWidth,child: rulesScreenBody()),),
              
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

  
  
  Widget rulesScreenBody() {
     var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF011627),
      extendBodyBehindAppBar: false,
      appBar: new AppBar(automaticallyImplyLeading: false,title:topRow(context),elevation: 0,backgroundColor: Color(0xFF011627),),
      body: Container(height: screenHeight,width: screenWidth,decoration: BoxDecoration(color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40),)),
      child: Column(children: [

        Padding(padding: const EdgeInsets.all(15),child: head("rules and updates"),),

        Expanded(child: ListView(children: <Widget>[
          Container(height: 30,width: screenWidth,color: Color(0XFF011627).withOpacity(0.33),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                GestureDetector(onTap: ()=>onChoose(0),child: Container(height: 28,width: 0.4*MediaQuery.of(context).size.width,
                  decoration: isSelected==0?BoxDecoration(color: Color(0XFFFDFFFC).withOpacity(0.8),
                  borderRadius: BorderRadius.all( Radius.circular(50),)):BoxDecoration(color: Color(0XFF011627).withOpacity(0.01)),
                  child: Center(child: Text("department".toUpperCase(),
                    style:  TextStyle(fontSize: 12,fontFamily:isSelected==0?"Roboto": "Roboto2",
                      fontWeight:isSelected==0? FontWeight.normal:FontWeight.w800,color: Color(0XFF011627)),)),),),


                GestureDetector(onTap: ()=>onChoose(1),child: Container(height: 28,width: 0.4*MediaQuery.of(context).size.width,
                  decoration: isSelected==1?BoxDecoration(color: Color(0XFFFDFFFC).withOpacity(0.8),
                  borderRadius: BorderRadius.all( Radius.circular(50),)):BoxDecoration(color: Color(0XFF011627).withOpacity(0.01)),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                    Text("pw1".toUpperCase(),
                    style:  TextStyle(fontSize: 12,fontFamily: isSelected==1?"Roboto":"Roboto2",fontWeight: isSelected==1? FontWeight.normal:FontWeight.w800,color: Color(0XFF011627)),),
                    SizedBox(width:15),
                    Image.asset("images/dropdown.png",height: 15,width: 15,color: Color(0XFFFFF95F62),)
                  
                  ],),),)])),


         _currentIndex==0?deptOpt():pwdOpt(),


        _currentIndex==0?Container(height: 200,width: 100,child: Center(child: Text("Department Lists")),)
            : Container(color: Color(0XFF8080C5).withOpacity(0.19),
                child: SingleChildScrollView(
                  child: Column(children: [
                    _pwdListItem(),
                      SizedBox(height:2),
                        _pwdListItem(),
                      SizedBox(height:2),
                        _pwdListItem(),
                      SizedBox(height:2),
                        _pwdListItem(),
                      SizedBox(height:2),
                        _pwdListItem(),
                      SizedBox(height:2),
                      _pwdListItem(),
                      SizedBox(height:2),
                        _pwdListItem(),
                      SizedBox(height:2),
                        _pwdListItem(),
                      SizedBox(height:2),
                        _pwdListItem(),
                      SizedBox(height:2),
                        _pwdListItem(),
                      SizedBox(height:2),
                      _pwdListItem(),
                      SizedBox(height:2),
                        _pwdListItem(),
                      SizedBox(height:2),
                        _pwdListItem(),
                      SizedBox(height:2),
                        _pwdListItem(),
                      SizedBox(height:2),
                        _pwdListItem(),
                      SizedBox(height:2),
                      _pwdListItem(),
                      SizedBox(height:2),
                        _pwdListItem(),
                      SizedBox(height:2),
                        _pwdListItem(),
                      SizedBox(height:2),
                        _pwdListItem(),
                      SizedBox(height:2),
                        _pwdListItem(),
                      SizedBox(height:2),
                      _pwdListItem(),
                      SizedBox(height:2),
                        _pwdListItem(),
                      SizedBox(height:2),
                        _pwdListItem(),
                      SizedBox(height:2),
                        _pwdListItem(),
                      SizedBox(height:2),
                        _pwdListItem(),
                      SizedBox(height:2),
                 ],),),),
        SizedBox(height:200)
  ],),),],)),);
}


 

  _pwdListItem() {
    return Container(
      height: 70,color: Color(0XFFFDFFFC).withOpacity(0.6),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
               Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ammendment slip no 51".toUpperCase(),style: const TextStyle(fontSize: 11,color: Color(0XFF47525E),fontFamily: "Roboto2"),),
                  Text("Date:20/10/2020".toUpperCase(),style:  TextStyle(fontSize: 9,fontFamily: "Roboto",color: Color(0XFF47525E).withOpacity(0.73)),),
                ],
              ),
              Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("hindi".toUpperCase(),
                style: const TextStyle(fontSize: 10,decoration: TextDecoration.underline,color: Color(0XFF9A1518),fontFamily: "Roboto2")),
                
              ],),
              Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("english".toUpperCase(),
                style: const TextStyle(fontSize: 10,decoration: TextDecoration.underline,color: Color(0XFF9A1518),fontFamily: "Roboto2")),
                
              ],),
              Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Download".toUpperCase(),
                style: const TextStyle(fontSize: 10,decoration: TextDecoration.underline,color: Color(0XFF9A1518),fontFamily: "Roboto2")),
                
              ],),
        ],
      ),
    );
          
  }
  Widget deptOpt() {
    return Container(height: 45,child: Center(child: Text("Dept opt")),);
  }

  Widget pwdOpt() {
    return Container(height:45,color: Color(0XFFE2EEE7).withOpacity(0.85),
      child: SingleChildScrollView(scrollDirection: Axis.horizontal,
          child: Row(children: [
            pwdsublist(0,"G&SR Correction"),
          SizedBox(width:10),
          pwdsublist(1,"Correction Slip"),
          SizedBox(width:10),
          pwdsublist(2,"Accidental Manual"),
          SizedBox(width:10),
          pwdsublist(3,"Operaating Manual"),
          SizedBox(width:10),
            pwdsublist(4,"G&SR Correction"),
          SizedBox(width:10),
          pwdsublist(5,"Correction Slip"),
          SizedBox(width:10),
          pwdsublist(6,"Accidental Manual"),
          SizedBox(width:10),
          pwdsublist(7,"Operaating Manual"),
          SizedBox(width:10),
            pwdsublist(8,"G&SR Correction"),
          SizedBox(width:10),
          pwdsublist(9,"Correction Slip"),
          SizedBox(width:10),
          pwdsublist(10,"Accidental Manual"),
          SizedBox(width:10),
          pwdsublist(11,"Operaating Manual"),
          SizedBox(width:10),
          
    ],),));
  }
  pwdsublist(int b,String a){
    return GestureDetector(onTap: ()=>onChoose2(b),
          child: Container(height: 28,width: 0.25*MediaQuery.of(context).size.width,
        decoration: isSelected2==b?BoxDecoration(color: Color(0XFFFDFFFC).withOpacity(0.73),borderRadius: BorderRadius.all( Radius.circular(50),))
        :BoxDecoration(color: Color(0XFFE2EEE7).withOpacity(0.15),borderRadius: BorderRadius.all( Radius.circular(0),)),
          child: Center(child: Text(a,style:  TextStyle(fontSize: 9,color: isSelected2==b?Color(0XFFF95F62):Color(0XFF47525E),fontFamily: "Roboto")),),
      ),
    );
}

  onChoose(int a) {
    setState(() {
      _currentIndex=a;
      isSelected=a;
    });
  }

  
  onChoose2(int a) {
    setState(() {
      _currentIndex2=a;
      isSelected2=a;
    });
  }
}