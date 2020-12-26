import 'package:flutter/material.dart';
import 'package:train_service/pages/livelocation.dart';
import 'downloads.dart';
import 'package:train_service/pages/searchresult.dart';
import 'package:train_service/widgets/bottomNavBar.dart';
import 'package:train_service/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'chat_screen.dart';


class Profile extends StatefulWidget {
  final String fn,ln,eid,mn;

  const Profile({Key key, this.fn="Test", this.ln="Test", this.eid, this.mn}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
     var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
          body: Stack(
            children: [
              Positioned(top:0,child: Container(height: screenHeight,width: screenWidth,child: profileBody()),),
              
              Align(alignment: Alignment.bottomCenter,child: footer1(
                context:context,
                 w1: (){},
                w2: ()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>Tower(),transitionDuration: Duration(seconds: 0))),
                w3: ()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>ChatScreen(),transitionDuration: Duration(seconds: 0))),
                w4: ()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>SaveScreen(),transitionDuration: Duration(seconds: 0))),
               
              )),

              Positioned(bottom:15,left:100,right:100,child: footer2(
                context: context,
                w:()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>Search1(),transitionDuration: Duration(seconds: 0))),
               
              ),)
            ],
          ),
    );
}

  Widget profileBody() {
     var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF011627),
      extendBodyBehindAppBar: false,
      appBar: new AppBar(automaticallyImplyLeading: false,title:topRow(context),elevation: 0,backgroundColor: Color(0xFF011627),),
      body: Container(height: screenHeight,width: screenWidth,decoration: BoxDecoration(color: Color(0XFFFdFFFC),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40),)),
            child: Padding(padding: const EdgeInsets.only(left:10.0,right: 10.0),
              child: Column( children: [
              Padding(padding: const EdgeInsets.all(15),child: head("profile"),),
              
              Expanded(
                child: ListView(children: [
                  CircleAvatar(radius: 90,backgroundColor: Colors.red[100],child: Icon(Icons.person_outline,size: 100,)),
                  SizedBox(height: 20,),

                  profiledetails(Icons.person,"Name","${widget.fn} ${widget.ln}",""),
                  profiledetails(Icons.contact_mail,"Email","${widget.eid}","mailto:${widget.eid}"),
                  profiledetails(Icons.home_work,"Address","Pune",""),
                  profiledetails(Icons.contact_phone,"Phone","${widget.mn}","tel:${widget.mn}")
      
                  
                  
        ],))],),)
      ),
    );
  }
  Widget profiledetails(IconData i,String t, String s,String url){
    return GestureDetector(
      onTap: () async{
    if (await canLaunch(url)) {
        await launch(url);}
    else {
        throw "Can't launch call";}
                                
  },
      
          child: ListTile(  
                
        
        leading: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(i,color: Color(0xFF9A1518),size: 30,),
          ],
        ),
        title: Text(t,style: TextStyle(fontFamily: "Norwester",fontSize: 14,fontWeight: FontWeight.w500,decorationStyle: TextDecorationStyle.wavy),),
        subtitle: Text(s,style: TextStyle(fontFamily: "Roboto",fontSize: 12,fontWeight: FontWeight.bold),),
        
      ),
    );
  }


}