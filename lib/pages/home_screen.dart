import 'package:flutter/material.dart';
import 'package:train_service/homescreen_buttons/duty_records.dart';
import 'package:train_service/homescreen_buttons/imp_numbers.dart';
import 'package:train_service/homescreen_buttons/news.dart';
import 'package:train_service/homescreen_buttons/roaster.dart';
import 'package:train_service/homescreen_buttons/work%20history.dart';
import 'package:train_service/pages/chat_screen.dart';
import 'package:train_service/pages/profile.dart';
import 'package:train_service/pages/livelocation.dart';
import 'package:train_service/pages/save.dart';
import 'package:train_service/pages/searchresult.dart';
import 'package:train_service/pages/videoLibrary.dart';
import 'package:train_service/widgets/bottomNavBar.dart';
import 'package:train_service/widgets/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json, base64 ,ascii;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


final storage=FlutterSecureStorage();
const mainLink="https://servicemanag.herokuapp.com";
          final HttpLink httpLink=HttpLink(uri: mainLink);
 // 5f9969e3b41e5005688845da
       







  


class Home extends StatefulWidget {
  final String jwt,userid;
  final Map<String,dynamic>payload;

  const Home({this.jwt, this.payload, this.userid}) ;
 
  factory Home.fromBase64(String jwt)=>
  Home(jwt:jwt,payload:json.decode(ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));
  
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String fn='';
String ln='';
String eid='';
String mn='';
String uid;

  @override
  Widget build(BuildContext context) {
    var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
       backgroundColor: Color(0xFF011627),
      extendBodyBehindAppBar: false,
      appBar: new AppBar(automaticallyImplyLeading: false,title:topRow(context),elevation: 0,backgroundColor: Color(0xFF011627),),
          body: Stack(children: [
              Positioned(top:0,child: 
             Container(height: screenHeight,width: screenWidth,decoration: BoxDecoration(color: Color(0xFF011627),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40),)),
            child: hbody()),),
  
              Align(alignment: Alignment.bottomCenter,child: footer1(
                context:context,
                w1: ()=> Navigator.push(context, PageRouteBuilder(pageBuilder:(_,__,___)=>Profile(fn:fn,ln: fn,eid: eid,mn: eid,),transitionDuration: Duration(seconds: 0))),
                w2: ()=> Navigator.push(context, PageRouteBuilder(pageBuilder:(_,__,___)=>Tower(),transitionDuration: Duration(seconds: 0))),
                w3: ()=> Navigator.push(context, PageRouteBuilder(pageBuilder:(_,__,___)=>ChatScreen(),transitionDuration: Duration(seconds: 0))),
                w4: ()=> Navigator.push(context, PageRouteBuilder(pageBuilder:(_,__,___)=>SaveScreen(),transitionDuration: Duration(seconds: 0))),
               
              )),

              Positioned(bottom:15,left:100,right:100,child: footer2(
                context: context,
                w:()=> Navigator.push(context, PageRouteBuilder(pageBuilder:(_,__,___)=>Search1(uid:uid),transitionDuration: Duration(seconds: 0))),
               
              )),
            ],
          ),
    );
}

  Widget hbody() {
   var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    return FutureBuilder(
              
        future: http.get('https://servicemanag.herokuapp.com', headers: {"Authorization": widget.jwt}),
        //initialData: widget.payload["userID"],
        builder: (BuildContext context,AsyncSnapshot snapshot){       
          
        final AuthLink authLink=AuthLink(getToken: ()async=>"Bearer ${widget.jwt}");
        final Link link1=authLink.concat(httpLink);   
        final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(GraphQLClient(link: link1,
          cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject,),));     
          
           

       
         String user1= widget.payload['userID'];
          return GraphQLProvider(
            client: client,
            child:Query(options:QueryOptions(document: r"""
                          query getid1($_id:ID!){
                      getUserDetails(_id:$_id){
                        _id
                        first_name
                        last_name
                        mobile_number
                        email
                      }}""",variables:<String,dynamic>{"_id":"$user1",} 
                    ),
              builder:(  QueryResult result, {Refetch refetch,FetchMore fetchMore,}) {  
if(result.hasException)return Column(
                                      mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                                      children:[Icon(Icons.wifi_off,),Text("no internet")]);
                if(result.loading)return Center(child: CircularProgressIndicator(),);
                fn=result.data["getUserDetails"]["first_name"];
                ln=result.data["getUserDetails"]["last_name"];
                eid=result.data["getUserDetails"]["email"];
                mn=result.data["getUserDetails"]["mobile_number"];
                uid=result.data["getUserDetails"]["_id"];
                //Profile(fn:fn,ln:ln,eid:eid,mn:mn);

           print(uid);
          return Container(height: screenHeight,width: screenWidth,decoration: BoxDecoration(color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40),)),
                      child: Padding(padding: const EdgeInsets.only(left:10.0,right: 10),
                        child: ListView(children: <Widget>[
                  Padding(padding:const EdgeInsets.only(left:20,right:20),

                  child:_welcomeText("${fn}"+"${ln}"),),
                 
                  SizedBox(height:10),
                  firstRow(),
                  
                  SizedBox(height:10), 
                  secondRow(),
                  
                  SizedBox(height:10),
                  _announcement(),
                  
                  SizedBox(height:10),
                  fourthRow(),
                  
                  SizedBox(height:10),
                  GestureDetector(
                    onTap:() => Navigator.push(context, PageRouteBuilder(pageBuilder:(_,__,___)=>VideoLibrary(),transitionDuration: Duration(seconds: 0))),
                    child:_videoLibrary(),),            
                  SizedBox(height:65),
        ]),
    )) ;
        }
      ),
    );
        
        }
      
    );
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  }

_videoLibrary() {
  return Container(height: 200,decoration: BoxDecoration(image: DecorationImage(image: AssetImage("images/tyellow.jpg",),fit: BoxFit.fill,
      colorFilter: ColorFilter.mode(Color(0XFF505FE1).withOpacity(0.56),BlendMode.dstOut),),
      color: Color(0XFF505FE1).withOpacity(0.56),borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(padding: const EdgeInsets.only(left:30.0,top:2,bottom: 70),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.start,children: [
          CircleAvatar(backgroundImage:AssetImage("images/videolibrary.png"),radius: 35,),
          SizedBox(width:10),
          Text("video Library".toUpperCase(),textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white,fontSize: 25,fontFamily: "Roboto2",fontWeight: FontWeight.bold,)),
        ],),
      ),);
}
  _welcomeText(String a) {
    var screenWidth=MediaQuery.of(context).size.width;
    return  Container(height: 20,width: screenWidth,decoration: BoxDecoration(shape: BoxShape.rectangle,
        border: Border(bottom:BorderSide(color: Color(0XFF343F4B).withOpacity(0.53),width: 0.5,style: BorderStyle.solid),
        left: BorderSide(color: Color(0XFF343F4B).withOpacity(0.53),width: 0.5,style: BorderStyle.solid),
        right: BorderSide(color: Color(0XFF343F4B).withOpacity(0.53),width: 0.5,style: BorderStyle.solid),),),
    child: Row(crossAxisAlignment: CrossAxisAlignment.center,children: [
        Image.asset("images/welcome.png",height: 15,width: 25,color: Color(0XFFFF8080C5),),
        SizedBox(width:5),
        Text("Welcome Mr. $a. Happy Birthday...........................",
        style: const TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto2",fontSize: 10,fontWeight: FontWeight.w800,),),],),
    );
  }

  firstRow() {
    return  Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
      CategoryCard(imageUrl:'images/roaster.png',labels: 'roaster',sublabels: '',h: 60,w: 60,wid:RoasterF(uid:uid)),
      CategoryCard(imageUrl:'images/workhistory.png',labels: 'work',sublabels: "history",h:50,w: 50,wid: WorkHistory(),), 
      GestureDetector(
          onTap: () =>Navigator.push(context, PageRouteBuilder(pageBuilder:(_,__,___)=>DutyRecords(uid:uid),transitionDuration: Duration(seconds: 0))),
              child: Container(height: 110,width: 110,decoration: BoxDecoration(color:Color(0XFF505FE1).withOpacity(0.2),
          borderRadius: BorderRadius.circular(25),),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [
              Image.asset('images/duty.png',height: 55,width: 60,color: Color(0XFFFFF95F62),),
              Text("duty".toUpperCase(),style: const TextStyle(color: Color(0XFF002C5B),
                fontFamily: "Roboto2",fontSize: 12,fontWeight: FontWeight.w800,),),
              Text("records".toUpperCase(),style: const TextStyle(color: Color(0XFF002C5B),
                fontFamily: "Roboto2",fontSize: 12,fontWeight: FontWeight.w800),),
            ],
          ),),
      )],
  );
  }

  secondRow() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
        CategoryCard(imageUrl:'images/importantnumbers.png',labels: 'important',sublabels: "numbers",h: 55,w: 55,wid: AA(),),
        CategoryCard(imageUrl:'images/rules.png',labels: 'rules &',sublabels: "updates",h: 60,w: 50,wid: SaveScreen(),),
        CategoryCard(imageUrl:'images/news.png',labels: 'news',sublabels: '',h: 60,w: 50,wid: News(),),
      ],
    );
  }


_announcement() {
  var screenWidth=MediaQuery.of(context).size.width;
  return Container(height: 135,width: screenWidth,
      decoration:BoxDecoration(color: Color(0XFF505FE1).withOpacity(0.28),borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(children: [
        Container(width: 0.25*screenWidth,
        child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Image.asset("images/announcement.png",height: 65,width: 65,),
                Text("Announcements",style: const TextStyle(color: Color(0XFF47525E),
                  fontFamily: "Roboto2",fontSize: 10,fontWeight: FontWeight.w800,),),],)),
                Padding(padding: const EdgeInsets.fromLTRB(0, 25, 10,25),
                child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,children: [
                  _announcementList("All Trains Cancelled today at harbour"),
                  SizedBox(height:5),
                  _announcementList("G&SR Correction Sheet Update"),
                 SizedBox(height:5),
                _announcementList("All Trains Cancelled today at harbour"),
        ],),)],),
      );
}

  _announcementList(String a) {
    var screenWidth=MediaQuery.of(context).size.width;
    return Container(height:25,width: 0.75*screenWidth-30,color: Color(0XFFFDFFFC).withOpacity(0.42),
      child: Row(children: [
        SizedBox(width:10),
        Image.asset("images/alist.png",height: 16,width: 16,color: Color(0XFFFFE83437),),
        SizedBox(width:5),
        Text(a,style: const TextStyle(fontSize: 10,fontFamily: "Roboto2",color: Color(0XFF47525E)),)
      ],),);
  }


  fourthRow() {
    return Container(height: 165,
      decoration: BoxDecoration(color: Color(0XFF505FE1).withOpacity(0.38),borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
        Column(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
          circularBut("pension"),                     
          circularBut("nda"),                     
          circularBut("lme"),
        ],),
        Column(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
          circularBut("grativity"),                     
          circularBut("hra"),                     
          circularBut("nha"),
        ],),
        Column(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
          circularBut("da"),                     
          circularBut("leaves"),                     
          circularBut("rra"),
        ],),
        Column(mainAxisAlignment: MainAxisAlignment.center,children: [
          Image.asset("images/calculator.png",height: 60,width: 60,color: Color(0XFFFFF95F62),),
          Text("Calculator",style:const TextStyle(fontSize: 10,fontFamily: "Roboto2",color: Color(0XFF47525E),fontWeight: FontWeight.w800),),
          SizedBox(height:5),
          Container(height: 40,width: 75,
          decoration: BoxDecoration(color:Color(0XFFFDFFFC).withOpacity(0.6),borderRadius: BorderRadius.circular(50),),
          child:Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
            Text("More".toUpperCase(),style:const TextStyle(fontSize: 10,
              fontFamily: "Roboto2",color: Color(0XFF47525E),fontWeight: FontWeight.w800,decoration: TextDecoration.underline),),
            Image.asset('images/more.png',height: 15,color: Color(0XFF47525E),),],)))],),],),
      );
  }


  circularBut(String a){
    return Container(
      height: 40,width: 75,
      decoration: BoxDecoration(color:Color(0XFFFDFFFC).withOpacity(0.6),
        borderRadius: BorderRadius.circular(50),),
      child:Center(child: Text(a.toUpperCase(),style:const TextStyle(fontSize: 9,fontFamily: "Roboto2",color: Color(0XFF47525E),fontWeight: FontWeight.w800),)
    ));
  }
}

class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String labels;
  final String sublabels;
  final double h;
  final double w;
  final Widget wid;
  const CategoryCard({
    Key key,@required this.imageUrl, @required this.labels, this.sublabels, @required this.h,@required this.w, this.wid,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: () =>Navigator.push(context, PageRouteBuilder(pageBuilder:(_,__,___)=>wid,transitionDuration: Duration(seconds: 0))),
          child: Container(height: 115,width: 115,decoration: BoxDecoration(color:Color(0XFF505FE1).withOpacity(0.2),
          borderRadius: BorderRadius.circular(25),),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,children: [
              Image.asset(imageUrl,height: h,width: w,),
              Text(labels.toUpperCase(),style: const TextStyle(color: Color(0XFF002C5B),
                fontFamily: "Roboto2",fontSize: 12,fontWeight: FontWeight.w800,),),
              Text(sublabels.toUpperCase(),style: const TextStyle(color: Color(0XFF002C5B),
                fontFamily: "Roboto2",fontSize: 12,fontWeight: FontWeight.w800),),
            ],
          ),
      ),
    );
  }
}
