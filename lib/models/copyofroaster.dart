// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:getflutter/components/search_bar/gf_search_bar.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:train_service/pages/profile.dart';
// import 'package:train_service/pages/livelocation.dart';
// import 'package:train_service/pages/save.dart';
// import 'package:train_service/widgets/bottomNavBar.dart';
// import 'package:train_service/widgets/widgets.dart';
// import '../widgets/addtoroaster.dart';
// import 'package:workmanager/workmanager.dart';
// import 'chat_screen.dart';
// import 'package:flutter_dash/flutter_dash.dart';

// class SearchResult extends StatefulWidget {
//   final String uid;

//   const SearchResult({Key key, this.uid}) : super(key: key);
//   @override
//   _SearchResultState createState() => _SearchResultState();
// }

// class _SearchResultState extends State<SearchResult> {
//    List<dynamic>getSet; String uid;
 
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =FlutterLocalNotificationsPlugin();
//   void callbackDispatcher() {
//   Workmanager.executeTask((taskName, inputData){
//     var initializationSettingsAndroid =AndroidInitializationSettings('ic_launcher');
//     var initSetttings = InitializationSettings(android:initializationSettingsAndroid,);
//     flutterLocalNotificationsPlugin.initialize(initSetttings,onSelectNotification: onSelectNotification);
//         return Future.value(true);

//     } );
//   }
  
//   String searchHint="Enter SET Number to Search";
//   String searchLabel="SET NO 232";
//   List<dynamic> searchItems,setDetails;
//   String abc="234";
//   int a=1;
//   TextEditingController editingController=TextEditingController();
//   String az='';
//   TimeOfDay st=TimeOfDay(hour: 0,minute: 1),en;
//   List getTrain,trainList;
//   String stime="",etime="",dhrs="",kms="",nDH="",scode="",ecode="";
//   bool azbool=true;

//   @override
//   void initState() {
//     super.initState();
//     Workmanager.initialize(callbackDispatcher,isInDebugMode: true);
//     WidgetsFlutterBinding.ensureInitialized();
//     Workmanager.registerPeriodicTask("2", "taskName",frequency: Duration(minutes: 15));
//   }

//   Future onSelectNotification(String payload) async{
//     Navigator.of(context).push(MaterialPageRoute(builder: (_) {return NewScreen(payload: payload,);}));
//   }
//   Future<void> scheduleNotification(int year,int month,int day,int hour,int minute,String t,String b) async {    
//     var scheduledNotificationDateTime =new DateTime(year,month,day,hour,minute,0).subtract(Duration(minutes: 10));
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'media channel id',
//       'media channel name',
//       'media channel description',
//       color: Colors.red,
//       enableLights: true,
//       largeIcon: DrawableResourceAndroidBitmap("ic_launcher"),
//       styleInformation: MediaStyleInformation(),
//     );
   
//     var platformChannelSpecifics = NotificationDetails(android:androidPlatformChannelSpecifics,);
//     await flutterLocalNotificationsPlugin.schedule(
//         0,
//         t,
//         b,
//         scheduledNotificationDateTime,
//         platformChannelSpecifics,
//         payload: "asdfghjbvdfghj"
        
//         );
        
//   }

  
//   Future<void> cancelNotification() async {await flutterLocalNotificationsPlugin.cancel(0);}

//   @override
//   Widget build(BuildContext context) {
//    var screenWidth=MediaQuery.of(context).size.width;
//     var screenHeight=MediaQuery.of(context).size.height;
//     return Scaffold(
//        backgroundColor: Color(0xFF011627),
//       extendBodyBehindAppBar: false,
//       appBar: new AppBar(automaticallyImplyLeading: false,title:topRow(context),elevation: 0,backgroundColor: Color(0xFF011627),),
//           body: Stack(children: [
//               Positioned(top:0,child: 
//              Container(height: screenHeight,width: screenWidth,decoration: BoxDecoration(color: Color(0xFF011627),
//         borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40),)),
//             child: searchResultBody()),),
  
//               Align(alignment: Alignment.bottomCenter,child: footer1(
//                 context:context,
//                 w1: ()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>Profile(),transitionDuration: Duration(seconds: 0))),
//                 w2: ()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>Tower(),transitionDuration: Duration(seconds: 0))),
//                 w3: ()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>ChatScreen(),transitionDuration: Duration(seconds: 0))),
//                 w4: ()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>SaveScreen(),transitionDuration: Duration(seconds: 0))),
               
//               )),

//               Positioned(bottom:15,left:100,right:100,child: footer2(
//                 context: context,
//                 w:(){},
               
//               )),
//             ],
//           ),
//     );
// }


//   Widget searchResultBody() {
//     var screenWidth=MediaQuery.of(context).size.width;
//     var screenHeight=MediaQuery.of(context).size.height;
//      final HttpLink httpLink=HttpLink(uri: "https://servicemanag.herokuapp.com",);
//     final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
//       GraphQLClient(link: httpLink,cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject,),),);
//     return GraphQLProvider(      
//       client: client,
//       child:Scaffold(
//                  backgroundColor: Color(0xFF011627),
//         body: Container(
//           height: screenHeight,width: screenWidth,
//           decoration: BoxDecoration(color: Color(0XFFFdFFFC),
//         borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40),)),
//           child: Column(
//             children: [
//                Padding(padding: const EdgeInsets.all(15),child: head("duty records"),),
//               Expanded(
//                               child:Query(
//         // ignore: deprecated_member_use
//         options:QueryOptions(
//           document: r"""
//             query getS{
//               getAllSets{
//                 _id
//                 setno
//                 start_station_code
//                 end_station_code
//                 sign_on
//                 sign_off
//                 duty_hrs
//                 distance
//                 ndh
//               }
//             }""",
//            ),
         
//         builder:(  QueryResult result, {Refetch refetch,FetchMore fetchMore,}) {
//           if(result.loading)return Center(child: CircularProgressIndicator(),);
          
//           getSet=result.data["getAllSets"];
//             return ListView(children: <Widget>[
//                     _radioBut(),

//                     Padding(padding: const EdgeInsets.fromLTRB(25, 0, 25,0),
//                       child: a==1?searchbar(getSet):searchbar(getSet), ),

//                    Padding(padding: const EdgeInsets.fromLTRB(15, 0, 15,0),
//                       child: Container(height: 400,width: screenWidth,
//                       decoration: BoxDecoration(color: Color(0XFF505FE1).withOpacity(0.23),borderRadius: BorderRadius.circular(15),),
//                         child: Column(children: [
//                           frow(),
//                            trainset(),
//                           raisedButtons(),
//                     ],),),),
                    
                  
//           ],
//     );
                        
                    
//         }
//       ),
//               ),
//               SizedBox(height:140)
//             ],
            
//           ),
//         ),
//   ),);
//   }
 
// Widget fetchTrain(){
//    final HttpLink httpLink=HttpLink(uri: "https://servicemanag.herokuapp.com",);
//     final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
//       GraphQLClient(link: httpLink,cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject,),),);
//     return GraphQLProvider(      
//       client: client,
//       child:Query(
//         // ignore: deprecated_member_use
//         options:QueryOptions(
//           document: r"""
//             query getT{
//               getAllTrains{
//                 _id
//                 setno
//                 train_no
//                 train_type
//                 start_station_code
//                 end_station_code
//                 route_code
//                 train_type
//                 start_on
//                 change_on
//                 halts_at
//               }
//             }""",),
//         builder:(  QueryResult result, {Refetch refetch,FetchMore fetchMore,}) {
//           if(result.loading)return Text("");
//           getTrain=result.data["getAllTrains"];
//           return searchbar2(getTrain);
            
         
//         }
//       ),);
// }

  

//   Widget searchbar(List<dynamic> a) {
//     return GFSearchBar(
//       searchBoxInputDecoration: InputDecoration(
//         enabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none),borderRadius: BorderRadius.all(Radius.circular(50))),
//         disabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none),borderRadius: BorderRadius.all(Radius.circular(50))),
//         contentPadding: EdgeInsets.only(left:25),
//         focusColor: Color(0XFF011627).withOpacity(0.44),
//         labelText: searchLabel,
//         labelStyle: TextStyle(color: Color(0XFF011627),fontFamily: "Roboto",fontSize: 16,fontWeight: FontWeight.bold),
//         hintText: searchHint,
//         hintStyle: TextStyle(color: Color(0XFF011627),fontFamily: "Roboto",fontSize: 12),
//         fillColor: Color(0XFF011627).withOpacity(0.44),filled:true,
//         focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),
//           borderSide: BorderSide(color: const Color(0XFF011627).withOpacity(0.44),style:BorderStyle.none )),
//         suffixIcon: Icon(Icons.search,color: Color(0XFFBFF95F62),size: 30,),
//           border: new OutlineInputBorder(borderSide: BorderSide(style:BorderStyle.none ,),borderRadius: BorderRadius.all(Radius.circular(50)))),

//       searchList: a,

//       searchQueryBuilder: (query, a) {
//         return a.where((item) =>item["setno"].toLowerCase().contains(query.toUpperCase())).toList();},

//       overlaySearchListItemBuilder: (item){
//         return new Container(width: double.infinity,
//           decoration: BoxDecoration(color: Color(0XFF011627).withOpacity(0.1)),
//           child:Padding(padding: const EdgeInsets.all(10),
//             child: Text(item["setno"],style: TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 15),),),);
//       },
      
//       onItemSelected: (item) {
//         setState(() {
//         // searchLabel = item["setno"];      
//           az=item["setno"];
//           azbool=false;
//           dhrs=item["duty_hrs"];
//           stime=item["sign_on"];
//            etime=item["sign_off"];
//             kms=item["distance"];
//              nDH=item["ndh"];
//              ecode=item["start_station_code"];
//              scode=item["end_station_code"];
//             List<String> sts=item["sign_on"].split(".");
//             int sth=int.parse(sts[0]);
//             int stm=int.parse(sts[1]);
//             List<String> ens=item["sign_off"].split(".");
//             int enh=int.parse(ens[0]);
//             int enm=int.parse(ens[1]);
//              st=TimeOfDay(hour: sth,minute: stm);
//               en=TimeOfDay(hour: enh,minute: enm);
//         });
//       },
//     );
//   }

  
//   Widget trainset() {
//       final HttpLink httpLink=HttpLink(uri: "https://servicemanag.herokuapp.com",);
//     final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
//       GraphQLClient(link: httpLink,cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject,),),);
//     return GraphQLProvider(      
//       client: client,
//       child:Query(
//         // ignore: deprecated_member_use
//         options:QueryOptions(
//           document: r"""
//             query getS($details:String!){
//               getTrainsbySetno(details:$details){
//                 _id
//                 setno
//                 train_no
//                 start_station_code
//                 end_station_code
//                 start_on
//                 change_on
//                 halts_at
//                 train_type
//               }
//             }""",
//          variables:<String,dynamic>{"details":"$az"}),
//         builder:(  QueryResult result, {Refetch refetch,FetchMore fetchMore,}) {

//           // if(result.data=="")return Text("a");
//             if(result.loading)return srow([]);
//             trainList=result.data["getTrainsbySetno"];
//           //  stime=item["sign_on"];
//           //           etime=item["sign_off"];
//           //           dhrs=item["duty_hrs"];kms=item["distance"];nDH=item["ndh"];
//           //           scode=item["start_station_code"];
//           //           ecode=item["end_station_code"];


//             return srow(trainList);
            
         
//         }
//       ),);
//   }
//   Widget searchbar2(List<dynamic> at) {
//     return GFSearchBar(
//       searchBoxInputDecoration: InputDecoration(
//         enabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none),borderRadius: BorderRadius.all(Radius.circular(50))),
//         disabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none),borderRadius: BorderRadius.all(Radius.circular(50))),
//         contentPadding: EdgeInsets.only(left:25),
//         focusColor: Color(0XFF011627).withOpacity(0.44),
//         labelText: searchLabel,
//         labelStyle: TextStyle(color: Color(0XFF011627),fontFamily: "Roboto",fontSize: 16,fontWeight: FontWeight.bold),
//         hintText: searchHint,
//         hintStyle: TextStyle(color: Color(0XFF011627),fontFamily: "Roboto",fontSize: 12),
//         fillColor: Color(0XFF011627).withOpacity(0.44),filled:true,
//         focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),
//           borderSide: BorderSide(color: const Color(0XFF011627).withOpacity(0.44),style:BorderStyle.none )),
//         suffixIcon: Icon(Icons.search,color: Color(0XFFBFF95F62),size: 30,),
//           border: new OutlineInputBorder(borderSide: BorderSide(style:BorderStyle.none ,),borderRadius: BorderRadius.all(Radius.circular(50)))),

//       searchList: at,

//       searchQueryBuilder: (query, at) {
//         return at.where((item) =>item["setno"].toLowerCase().contains(query.toUpperCase())).toList();},

//       overlaySearchListItemBuilder: (item){
//         return new Container(width: double.infinity,
//           decoration: BoxDecoration(color: Color(0XFF011627).withOpacity(0.1)),
//           child:Padding(padding: const EdgeInsets.all(10),
//             child: Text(item["setno"],style: TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 15),),),);
//       },
      
//       onItemSelected: (item) {
//         setState(() {
//          //searchLabel = item["setno"];      
//           az=item["setno"];
          
//         });
//       },
//     );
//   }
  

//   Widget _radioBut() {
//     return  Row(children: [
//           Radio(value: 1, groupValue: a, activeColor:  Color(0XFFF95F62),
//           onChanged: (T){
//             setState(() {
//               a=T;
//               searchHint="Enter SET Number to Search";
//               searchLabel="SET NO 232";
//               });}),
//           Text("Search Set Number",
//             style: const TextStyle(fontFamily: "Roboto",fontSize: 11,color: Color(0XFF47525E),fontWeight: FontWeight.w900,),maxLines: 2,),
//         Spacer(),
//           Radio(value: 2, groupValue: a, activeColor:  Color(0XFFF95F62),
//           onChanged: (T){
//             setState(() {
//               a=T;
//               searchHint="Enter Train Number to Find a SET";
//               searchLabel="TRAIN NO 90001";
//               });}),
//           Text(
//             "Search Set By Train Number",
//             style: const TextStyle(fontFamily: "Roboto",fontSize: 11,color: Color(0XFF47525E),fontWeight: FontWeight.w900,),maxLines: 2,),
//             SizedBox(width: 15,),
//         ],
//       );
//   }



// frow() {
//   return  Padding(
//   padding:const EdgeInsets.fromLTRB(10, 10, 1,0),
//   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Container(height: 60,width:0.75*(MediaQuery.of(context).size.width-30),decoration: BoxDecoration(
//         color: Color(0XFFFDFFFC).withOpacity(0.6),borderRadius: BorderRadius.circular(10),),
//     child: Padding(padding: const EdgeInsets.only(top: 5),
//       child: Row(children: [
//               Padding(padding: const EdgeInsets.only(left:5.0),
//                 child: Column(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment:CrossAxisAlignment.start,
//                 children: [
//                 Text('Sign on'.toUpperCase(),style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11,fontWeight:FontWeight.bold),),
//                 Text(stime,style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11),),
//                 Text(scode.toUpperCase(),style:TextStyle(color: Color(0XFFF95F62),fontFamily: "Roboto",fontWeight:FontWeight.bold,fontSize: 12),),],),),           
//               SizedBox(width:5),
//               Dash(direction:Axis.vertical,dashColor: Color(0XFF505FE1),length: 50,),SizedBox(width:4),
//               Column(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment:CrossAxisAlignment.start,
//                 children: [
//                 Text('Sign off'.toUpperCase(),style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11,fontWeight:FontWeight.bold),),
//                 Text(etime,style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11),),
//                 Text(ecode.toUpperCase(),style:TextStyle(color: Color(0XFFF95F62),fontFamily: "Roboto",fontWeight:FontWeight.bold,fontSize: 12),),],),           
//                 SizedBox(width:5),Dash(direction:Axis.vertical,dashColor: Color(0XFF505FE1),length: 50,),SizedBox(width:4),
//               Column(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment:CrossAxisAlignment.start,
//                 children: [
//                 Text('duty hrs'.toUpperCase(),style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11,fontWeight:FontWeight.bold),),
//                 Text(dhrs,style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11),),],),           
//               SizedBox(width:5),Dash(direction:Axis.vertical,dashColor: Color(0XFF505FE1),length: 50,),SizedBox(width:4),
//               Column(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment:CrossAxisAlignment.start,
//                 children: [
//                 Text('kms'.toUpperCase(),style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11,fontWeight:FontWeight.bold),),
//                 Text(kms.toUpperCase(),style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11),),],),           
//               SizedBox(width:5),Dash(direction:Axis.vertical,dashColor: Color(0XFF505FE1),length: 50,),SizedBox(width:4),
//               Column(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment:CrossAxisAlignment.start,
//                 children: [
//                 Text('ndh'.toUpperCase(),style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11,fontWeight:FontWeight.bold),),
//                 Text(nDH.toUpperCase(),style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11),),],),],),)),
//               Container(width:70,height: 45,
//                 decoration: BoxDecoration(color: Color(0XFFFDFFFC).withOpacity(0.6),borderRadius: BorderRadius.circular(10),),
//                   child: Center(child:Text(az,style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 15,fontWeight:FontWeight.bold),),),
//               )
//         ],
//       ),
//     );
// }

//  srow(List<dynamic> zz) {
//    return Padding(padding:const EdgeInsets.fromLTRB(10, 5, 10,0),
//     child: Container(height: 250,width: MediaQuery.of(context).size.width,decoration: BoxDecoration(color: Color(0XFFFDFFFC).withOpacity(0.6),
//     borderRadius: BorderRadius.circular(20),),
//     child: Padding(padding: const EdgeInsets.only(top:8.0),
// child: Row(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment:CrossAxisAlignment.start,children: [
//   Padding(padding: const EdgeInsets.only(left:5.0),
//     child: Container(width: 80,
//       child: Column(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment:CrossAxisAlignment.center,children: [
//         Text('train no'.toUpperCase(),style: TextStyle(decoration: TextDecoration.underline,
//           color: Color(0XFF47525E),fontSize: 12,fontFamily: "Roboto2",fontWeight: FontWeight.w800),),
//         SizedBox(height: 5,),
//           Expanded(
//                           child: ListView.builder(
//   itemCount: zz.length,
//   itemBuilder: (context,i){
//     return Column(
//       children: [
//         Row(children: [
//                    Text(zz[i]["train_type"],style: TextStyle(color: Color(0XFF9A1518),fontFamily: "Roboto",fontSize: 11,)),
//                    SizedBox(width: 8,),
//                    Text(zz[i]["train_no"],style: TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11,),),],),
//                    SizedBox(height: 20,),
//       ],
//     );
               

// }),
//           ),
//                     ],),),),   
//   SizedBox(width:3),
//   Dash(direction:Axis.vertical,dashColor: Color(0XFF505FE1),length: 240,),SizedBox(width:3),
//   Container(width: 55,
//   child: Column(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment:CrossAxisAlignment.center,children: [
//       Text('Start'.toUpperCase(),style: TextStyle(decoration: TextDecoration.underline,
//         color: Color(0XFF47525E),fontSize: 12,fontFamily: "Roboto2",fontWeight: FontWeight.w800),),
//       SizedBox(height: 5,),
//       Expanded(child: ListView.builder(
//         itemCount: zz.length,
//         itemBuilder: (context,i){
//         return Row(mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment:CrossAxisAlignment.center,children: [
//         Column(children: [
//           Text(zz[i]["start_station_code"].toUpperCase(),style:TextStyle(color: Color(0XFFF95F62),fontFamily: "Roboto",fontWeight:FontWeight.bold,fontSize: 11),),
//           Text(zz[i]["start_on"].toUpperCase(),style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11),),
//           SizedBox(height: 5),

//                 ],),],);
//       }))
      
          
//          ],),),           
//     Dash(direction:Axis.vertical,dashColor: Color(0XFF505FE1),length: 240,),
//     Container(width: 75,
//   child: Column(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment:CrossAxisAlignment.center,children: [
//       Text('change'.toUpperCase(),style: TextStyle(decoration: TextDecoration.underline,
//         color: Color(0XFF47525E),fontSize: 12,fontFamily: "Roboto2",fontWeight: FontWeight.w800),),
//       SizedBox(height: 5,),
//       Expanded(child: ListView.builder(
//         itemCount: zz.length,
//         itemBuilder: (context,i){
//         return Row(mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment:CrossAxisAlignment.center,children: [
//         Column(children: [
//           Text(zz[i]["end_station_code"],style:TextStyle(color: Color(0XFFF95F62),fontFamily: "Roboto",fontWeight:FontWeight.bold,fontSize: 11),),
//           Text(zz[i]["change_on"],style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11),),
//           SizedBox(height: 5,),
//                 ],),],);
//       }))
      
          
//          ],),),                 
//               SizedBox(width:2),Dash(direction:Axis.vertical,dashColor: Color(0XFF505FE1),length: 240,),
//             Spacer(),
//     ],),)),);
//  }


//   Widget raisedButtons() {
//   return Padding(
//     padding: const EdgeInsets.fromLTRB(10,5,10,0),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         FlatButton(color: Color(0xFF8FB339),minWidth: 160,child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [
//                 Icon(Icons.add, size: 20, color: Color(0XFFFDFFFC)),SizedBox(width: 3),
//                 Text('Add To Roaster', style: const TextStyle(color: Color(0XFFFDFFFC),fontSize: 11)),],),
//                 onPressed:() {
//                   _showCalender();
                 

//                   }),

//        FlatButton(color: Color(0xFFF95F62),minWidth: 160,child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [
//                Image.asset('images/notibell.png', height: 20),SizedBox(width: 3),
//                Text('SET REMAINDER', style: const TextStyle(color: Color(0XFFFDFFFC),fontSize: 11)),],),
//                onPressed: () {
//                  showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now()).then((value){
//                   int a=value.year;
//                   int b=value.month;
//                   int c=value.day;
//                   showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {
//                     int d=value.hour;
//                     int e=value.minute;
//                     scheduleNotification(a, b, c, d, e,"Set No"+az,"Set"+az+"will start after 10 minutes");
//                   });
                  

//                 });
//                },
               
//                ),

//       ],
//     ),
//   );
// }

//  _showCalender() {
//     showDialog(
//       context: context,
//       builder: (context) => Container(height: 500,width: double.infinity,
//         child: AlertDialog(
//           backgroundColor: Colors.white,
//           contentPadding: EdgeInsets.all(5),
          
//           content: RunM1(az:az,uid:widget.uid),
//           title:Center(child: Text('    Calender    ',
//             style: const TextStyle(color: Colors.white,fontSize: 17,fontFamily: "Norwester",backgroundColor: Color(0xFF011627),),)),
//           actions: [
//             FlatButton(onPressed: (){
//               Navigator.pop(context);
//               }, child: Text("Close"))
//           ],
//         ),
//       )
//     );
//  } 
// }

// class NewScreen extends StatelessWidget {
//   final String payload;

//   NewScreen({
//     @required this.payload,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(payload),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_dash/flutter_dash.dart';
// import 'package:getflutter/components/search_bar/gf_search_bar.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:train_service/pages/chat_screen.dart';
// import 'package:train_service/pages/profile.dart';
// import 'package:train_service/pages/livelocation.dart';
// import 'package:train_service/pages/save.dart';
// import 'package:train_service/pages/searchresult.dart';
// import 'package:train_service/widgets/bottomNavBar.dart';
// import 'package:train_service/widgets/widgets.dart';
// import 'package:train_service/widgets/addtoroaster.dart';




// class RoasterF extends StatefulWidget {
//   final String uid;
//   const RoasterF({ this.uid}) ;
  
//   @override
//   _RoasterFState createState() => _RoasterFState();
// }

// class _RoasterFState extends State<RoasterF> {
//   List<dynamic>getR;
//   @override
//   Widget build(BuildContext context) {
//    final HttpLink httpLink=HttpLink(uri: "https://servicemanag.herokuapp.com",);
//     final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
//       GraphQLClient(link: httpLink,cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject,),),);
//     return GraphQLProvider(      
//       client: client,
//       child:Scaffold(
//         body: Query(options:QueryOptions(
//             document: r"""
//               query getR($_id:ID!){
//                 getUserRoasterslist(_id:$_id){
//                   _id
//                   user
//                   setno
//                   start_station_code
//                   end_station_code
//                   sign_on
//                   sign_off
//                   duty_hrs
//                   distance
//                   ndh
//                   actual_sign_off
//                   actual_sign_on
//                   actual_duty_hrs
//                   duty_date
//                 }
//               }""",
//            variables:<String,dynamic>{"_id":"${widget.uid}"}),
//           builder:(  QueryResult result, {Refetch refetch,FetchMore fetchMore,}) {

//                 if(result.loading)return Roaster(getR: [],);

                

//                 getR=result.data["getUserRoasterslist"];

//                 return Roaster(getR:getR,uid:widget.uid);
                              
                          
//           }
//         ),
//   ),);
// }
// }

// class Roaster extends StatefulWidget {
//   final List getR;final String uid;
//   const Roaster({Key key, this.getR, this.uid}) : super(key: key);
//   @override
//   _RoasterState createState() => _RoasterState();
// }

// class _RoasterState extends State<Roaster> {

//   String sidate,searchLabel="SEARCH ROASTER";
//   List getSetforRoaster,trainListR;
//   String v,vv; String az,stime="",etime="",dhrs="",kms="",nDH="",scode="",ecode="";
//   @override
//   Widget build(BuildContext context) {
//     var screenWidth=MediaQuery.of(context).size.width;
//     var screenHeight=MediaQuery.of(context).size.height;
//     return Scaffold(
//           body: Stack(children: [
//               Positioned(top:0,child: Container(height: screenHeight,width: screenWidth,child: roasterBody()),),
  
//               Align(alignment: Alignment.bottomCenter,child: footer1(
//                 context:context,
//                 w1: ()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>Profile(),transitionDuration: Duration(seconds: 0))),
//                 w2: ()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>Tower(),transitionDuration: Duration(seconds: 0))),
//                 w3: ()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>ChatScreen(),transitionDuration: Duration(seconds: 0))),
//                 w4: ()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>SaveScreen(),transitionDuration: Duration(seconds: 0))),
               
//               )),

//               Positioned(bottom:15,left:100,right:100,child: footer2(
//                 context: context,
//                 w:()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>SearchResult(),transitionDuration: Duration(seconds: 0))),
               
//               )),
//             ],
//           ),
//     );
// }

// Widget roasterBody(){
//     var screenWidth=MediaQuery.of(context).size.width;
//     var screenHeight=MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Color(0xFF011627),extendBodyBehindAppBar: false,
//       appBar: new AppBar(automaticallyImplyLeading: false,title:topRow(context),elevation: 0,backgroundColor: Color(0xFF011627),),
//       body: Container(height: screenHeight,width: screenWidth,decoration: BoxDecoration(color: Color(0XFFFdFFFC),
//         borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40),)),
//     child: Column( children: [
              
//               Padding(padding: const EdgeInsets.all(15),child: head("Roaster"),),

//               setSearch(),
            
//               Expanded(child: ListView.builder(itemCount: widget.getR.length,
//               itemBuilder: (context,i){
//                 var a=DateTime.parse("${widget.getR[i]["duty_date"]}").toLocal();
//                 return  GestureDetector(
//                   onTap: (){showDialog(context: context,
//                       builder: (context) => AlertDialog(backgroundColor: Colors.white,contentPadding: EdgeInsets.all(5),
//                         content: Container(height: 400,width:screenWidth,child: Copy(rid:widget.getR[i]["_id"])),
//                         title:Center(child: Text('    Roaster Details    '.toUpperCase(),
//                           style: const TextStyle(color: Colors.white,fontSize: 17,fontFamily: "Norwester",backgroundColor: Color(0xFF011627),),)),
//                         actions: [FlatButton(onPressed: ()=>Navigator.pop(context), child: Text("Close"))],));},

//                  child:DateTime(a.year,a.month,a.day).compareTo(DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,))==0
                      
//                     ? roasterlist("   ongoing   ", widget.getR[i]["setno"], widget.getR[i]["actual_sign_on"],
//                         widget.getR[i]["actual_sign_off"], widget.getR[i]["user"], widget.getR[i]["_id"], a,Colors.green[800])
          
//                     : (DateTime(a.year,a.month,a.day).compareTo(DateTime.now())==1
                    
//                       ? roasterlist(" upcoming ", widget.getR[i]["setno"], widget.getR[i]["actual_sign_on"],
//                           widget.getR[i]["actual_sign_off"], widget.getR[i]["user"], widget.getR[i]["_id"], a,Colors.red[900])

//                       :roasterlist("completed", widget.getR[i]["setno"], widget.getR[i]["actual_sign_on"],
//                         widget.getR[i]["actual_sign_off"], widget.getR[i]["user"], widget.getR[i]["_id"], a,Color(0XFF47525E)))
//                 );},)),
//                 SizedBox(height:80),
              
    
    
//     ],)),);
//   }
 
// Widget roasterlist(String label,setname,signon,signoff,userid,roasterid,DateTime datename,Color zz) {
//   return Column(crossAxisAlignment: CrossAxisAlignment.end,children: [
                        
//       Text("  $label  ".toUpperCase(),style: TextStyle(color:zz,backgroundColor:Colors.red.withOpacity(0.42) ,
//         fontSize: 18,fontFamily: "Norwester"),),



//       Container(height: 60,color:Colors.red.withOpacity(0.42),padding: EdgeInsets.only(left:10,right:10),
//         child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
//             Column(mainAxisAlignment: MainAxisAlignment.spaceAround,crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//                 tl("SET",setname),
//                 tl("DATE",datename.year.toString()+"-"+datename.month.toString()+"-"+datename.day.toString())],),
//             Row(children: [
//                 Column(mainAxisAlignment: MainAxisAlignment.spaceAround,crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                     tl("SIGN ON",signon),
//                     tl("SIGN OFF",signoff),],),
//                 SizedBox(width:5),
//                 Column(mainAxisAlignment: MainAxisAlignment.spaceAround,crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   GestureDetector(child: Icon(Icons.edit,size:15),onTap: (){var snh,snm,sfh,sfm;
//                       showTimePicker(context: context, initialTime: TimeOfDay.now(),confirmText: "Add Sign On").then((value1) {
//                         snh=value1.hour;
//                         snm=value1.minute;
//                         showTimePicker(context: context, initialTime: TimeOfDay.now(),confirmText: "Add Sign Off").then((value2){
//                           sfh=value2.hour;
//                           sfm=value2.minute;
//                           Navigator.push(context, 
//                           MaterialPageRoute(builder: (_)=>Mut1(snh:snh,snm:snm,sfh:sfh,uID:userid,sfm:sfm,id:roasterid)));});});},),

//                   GestureDetector(child: Icon(Icons.edit,size:15),onTap: (){var snh,snm,sfh,sfm;
//                     showTimePicker(context: context, initialTime: TimeOfDay.now(),confirmText: "Add Sign On").then((value1) {
//                       snh=value1.hour;
//                       snm=value1.minute;
//                       showTimePicker(context: context, initialTime: TimeOfDay.now(),confirmText: "Add Sign Off").then((value2){
//                         sfh=value2.hour;
//                         sfm=value2.minute;
//                         Navigator.push(context, 
//                         MaterialPageRoute(builder: (_)=>Mut1(snh:snh,snm:snm,sfh:sfh,uID:userid,sfm:sfm,id:roasterid)));});});},)

                      
//                     ],),],)],),),
//         Container(height: 1,width: double.infinity,color: Color(0XFF47525E),),
//         SizedBox(height:10)],);

// }

// Widget setSearch(){
//    final HttpLink httpLink=HttpLink(uri: "https://servicemanag.herokuapp.com",);
//     final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
//       GraphQLClient(link: httpLink,cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject,),),);
//     return GraphQLProvider(      
//       client: client,
//       child:Query(
//         // ignore: deprecated_member_use
//         options:QueryOptions(
//           document: r"""
//             query getS{
//               getAllSets{
//                 _id
//                 setno
//                 start_station_code
//                 end_station_code
//                 sign_on
//                 sign_off
//                 duty_hrs
//                 distance
//                 ndh
//               }
//             }""",
//            ),
         
//         builder:(  QueryResult result, {Refetch refetch,FetchMore fetchMore,}) {
//           if(result.loading)return Center(child: SearchResult(getSet: [],));
//           if(result.hasException)return Center(child: Text("Exc"));
//           getSetforRoaster=result.data["getAllSets"];
//             return roasterSearch(getSetforRoaster);
                        
                    
//         }
//       ),);
// }
// Widget roasterSearch(List xz){
//    var screenWidth=MediaQuery.of(context).size.width;
//   return  GFSearchBar(
//         searchBoxInputDecoration: InputDecoration(
//         enabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid,color: const Color(0xFF9A1518),),
//           borderRadius: BorderRadius.all(Radius.circular(50))),
//         disabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid,color: const Color(0xFF9A1518),),
//           borderRadius: BorderRadius.all(Radius.circular(50))),
//         contentPadding: EdgeInsets.only(left:25),focusColor: Color(0xFF9A1518).withOpacity(0.44),
//         labelText: searchLabel,
//         labelStyle: TextStyle(color: Color(0XFF011627),fontFamily: "Roboto",fontSize: 13,fontWeight: FontWeight.bold),
//         hintText: "Enter Set No To search Your Roaster",hintStyle: TextStyle(color: Color(0XFF011627),fontFamily: "Roboto",fontSize: 11),
//         fillColor: Colors.white.withOpacity(0.44),filled:true,
//         focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),
//           borderSide: BorderSide(color: const Color(0xFF9A1518),style:BorderStyle.solid )),
//         suffixIcon: Icon(Icons.search,color: Color(0XFFBFF95F62),size: 30,),
//         border: new OutlineInputBorder(borderSide: BorderSide(style:BorderStyle.none ,),borderRadius: BorderRadius.all(Radius.circular(50)))),

//         searchList: xz,

//         searchQueryBuilder: (query, xz) {
//             return xz.where((item) =>item["setno"].toUpperCase().contains(query.toUpperCase())).toList();},

//         overlaySearchListItemBuilder: (item){
//           return new Container(width: double.infinity,decoration: BoxDecoration(color: Color(0XFF011627).withOpacity(0.1)),
//             child:Padding(padding: const EdgeInsets.all(10),
//               child: Row(crossAxisAlignment:CrossAxisAlignment.start,mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                 children: [
//                    RichText(
//                     text: TextSpan(text: "Set: ",style: TextStyle(color: Color(0XFF47525E),fontFamily: "Norwester",fontSize: 13,),
//                     children: <TextSpan>[
//                       TextSpan(text: item["setno"],style: TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 13),),
//                     ]
//                     )),
//                   Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       RichText(
//                     text: TextSpan(text: "Departure  : ",style: TextStyle(color: Color(0XFF47525E),fontFamily: "Norwester",fontSize: 12),
//                     children: <TextSpan>[
//                       TextSpan(text: item["start_station_code"],style: TextStyle(color: Color(0XFFF95F62),fontWeight: FontWeight.w900,fontFamily: "Roboto",fontSize: 13),),
//                     ]
//                     )),
//                     RichText(
//                     text: TextSpan(text: "Destination: ",style: TextStyle(color: Color(0XFF47525E),fontFamily: "Norwester",fontSize: 12),
//                     children: <TextSpan>[
//                       TextSpan(text: item["end_station_code"],style: TextStyle(color: Color(0XFFF95F62),fontWeight: FontWeight.w900,fontFamily: "Roboto",fontSize: 13),),
//                     ]
//                     )),

//                       ],
//                   ),

//                 ],
//               ),),);},

//         onItemSelected: (item) {
//           setState(() {
//              az=item["setno"];
//          // azbool=false;
//           dhrs=item["duty_hrs"];
//           stime=item["sign_on"];
//            etime=item["sign_off"];
//             kms=item["distance"];
//              nDH=item["ndh"];
//              ecode=item["start_station_code"];
//              scode=item["end_station_code"];
//           });
//           v=item["setno"];
         
//           showDialog(context: context,
//                       builder: (context) => Padding(padding:const EdgeInsets.fromLTRB(10, 5, 10,0),
//     child:
//      Scaffold(
//       body: Center(
//         child: Padding(padding: const EdgeInsets.fromLTRB(15, 0, 15,0),
//                         child: Container(height: 600,width: screenWidth,
//                         decoration: BoxDecoration(color: Color(0XFF505FE1).withOpacity(0.23),borderRadius: BorderRadius.circular(15),),
//                           child: Column(children: [
//                             frow(),
//                              trainset(),
//                             raisedButtons(v,widget.uid),
//                       ],),),),
//       ),
//     )));
  
//         },);
// }

//  Widget trainset() {
//       final HttpLink httpLink=HttpLink(uri: "https://servicemanag.herokuapp.com",);
//     final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
//       GraphQLClient(link: httpLink,cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject,),),);
//     return GraphQLProvider(      
//       client: client,
//       child:Query(
//         // ignore: deprecated_member_use
//         options:QueryOptions(
//           document: r"""
//             query getS($details:String!){
//               getTrainsbySetno(details:$details){
//                 _id
//                 setno
//                 train_no
//                 start_station_code
//                 end_station_code
//                 start_on
//                 change_on
//                 halts_at
//                 train_type
//               }
//             }""",
//          variables:<String,dynamic>{"details":"$az"}),
//         builder:(  QueryResult result, {Refetch refetch,FetchMore fetchMore,}) {

//           // if(result.data=="")return Text("a");
//             if(result.loading)return srow([]);
//             trainListR=result.data["getTrainsbySetno"];
//           //  stime=item["sign_on"];
//           //           etime=item["sign_off"];
//           //           dhrs=item["duty_hrs"];kms=item["distance"];nDH=item["ndh"];
//           //           scode=item["start_station_code"];
//           //           ecode=item["end_station_code"];


//             return srow(trainListR);
            
         
//         }
//       ),);
//   }
//   srow(List<dynamic> zz) {
//    return Padding(padding:const EdgeInsets.fromLTRB(10, 5, 10,0),
//     child: Container(height: 250,width: MediaQuery.of(context).size.width,decoration: BoxDecoration(color: Color(0XFFFDFFFC).withOpacity(0.6),
//     borderRadius: BorderRadius.circular(20),),
//     child: Padding(padding: const EdgeInsets.only(top:8.0),
// child: Row(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment:CrossAxisAlignment.start,children: [
//   Padding(padding: const EdgeInsets.only(left:5.0),
//     child: Container(width: 80,
//       child: Column(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment:CrossAxisAlignment.center,children: [
//         Text('train no'.toUpperCase(),style: TextStyle(decoration: TextDecoration.underline,
//           color: Color(0XFF47525E),fontSize: 12,fontFamily: "Roboto2",fontWeight: FontWeight.w800),),
//         SizedBox(height: 5,),
//           Expanded(
//                           child: ListView.builder(
//   itemCount: zz.length,
//   itemBuilder: (context,i){
//     return Column(
//       children: [
//         Row(children: [
//                    Text(zz[i]["train_type"],style: TextStyle(color: Color(0XFF9A1518),fontFamily: "Roboto",fontSize: 11,)),
//                    SizedBox(width: 8,),
//                    Text(zz[i]["train_no"],style: TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11,),),],),
//                    SizedBox(height: 20,),
//       ],
//     );
               

// }),
//           ),
//                     ],),),),   
//   SizedBox(width:3),
//   Dash(direction:Axis.vertical,dashColor: Color(0XFF505FE1),length: 240,),SizedBox(width:3),
//   Container(width: 55,
//   child: Column(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment:CrossAxisAlignment.center,children: [
//       Text('Start'.toUpperCase(),style: TextStyle(decoration: TextDecoration.underline,
//         color: Color(0XFF47525E),fontSize: 12,fontFamily: "Roboto2",fontWeight: FontWeight.w800),),
//       SizedBox(height: 5,),
//       Expanded(child: ListView.builder(
//         itemCount: zz.length,
//         itemBuilder: (context,i){
//         return Row(mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment:CrossAxisAlignment.center,children: [
//         Column(children: [
//           Text(zz[i]["start_station_code"].toUpperCase(),style:TextStyle(color: Color(0XFFF95F62),fontFamily: "Roboto",fontWeight:FontWeight.bold,fontSize: 11),),
//           Text(zz[i]["start_on"].toUpperCase(),style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11),),
//           SizedBox(height: 5),

//                 ],),],);
//       }))
      
          
//          ],),),           
//     Dash(direction:Axis.vertical,dashColor: Color(0XFF505FE1),length: 240,),
//     Container(width: 75,
//   child: Column(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment:CrossAxisAlignment.center,children: [
//       Text('change'.toUpperCase(),style: TextStyle(decoration: TextDecoration.underline,
//         color: Color(0XFF47525E),fontSize: 12,fontFamily: "Roboto2",fontWeight: FontWeight.w800),),
//       SizedBox(height: 5,),
//       Expanded(child: ListView.builder(
//         itemCount: zz.length,
//         itemBuilder: (context,i){
//         return Row(mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment:CrossAxisAlignment.center,children: [
//         Column(children: [
//           Text(zz[i]["end_station_code"],style:TextStyle(color: Color(0XFFF95F62),fontFamily: "Roboto",fontWeight:FontWeight.bold,fontSize: 11),),
//           Text(zz[i]["change_on"],style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11),),
//           SizedBox(height: 5,),
//                 ],),],);
//       }))
      
          
//          ],),),                 
//               SizedBox(width:2),Dash(direction:Axis.vertical,dashColor: Color(0XFF505FE1),length: 240,),
//             Spacer(),
//     ],),)),);
//  }

//  Widget raisedButtons(String az,uid) {
//   return Padding(
//     padding: const EdgeInsets.fromLTRB(10,5,10,0),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         FlatButton(color: Color(0xFF8FB339),minWidth: 160,child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [
//                 Icon(Icons.add, size: 20, color: Color(0XFFFDFFFC)),SizedBox(width: 3),
//                 Text('Add To Roaster', style: const TextStyle(color: Color(0XFFFDFFFC),fontSize: 11)),],),
//                 onPressed:() {
//                   _showCalender(az,uid);
                 

//                   }),

//        FlatButton(color: Color(0xFFF95F62),minWidth: 160,child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [
//                Image.asset('images/notibell.png', height: 20),SizedBox(width: 3),
//                Text('SET REMAINDER', style: const TextStyle(color: Color(0XFFFDFFFC),fontSize: 11)),],),
//                onPressed: () {
//                 //  showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now()).then((value){
//                 //   int a=value.year;
//                 //   int b=value.month;
//                 //   int c=value.day;
//                 //   showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {
//                 //     int d=value.hour;
//                 //     int e=value.minute;
//                 //     scheduleNotification(a, b, c, d, e,"Set No"+az,"Set"+az+"will start after 10 minutes");
//                 //   });
                  

//                 // });
//                },
               
//                ),

//       ],
//     ),
//   );
// }
//  _showCalender(String az,uid) {
//     showDialog(
//       context: context,
//       builder: (context) => Container(height: 500,width: double.infinity,
//         child: AlertDialog(
//           backgroundColor: Colors.white,
//           contentPadding: EdgeInsets.all(5),
          
//           content: RunM1(az:az,uid:uid),
//           title:Center(child: Text('    Calender    ',
//             style: const TextStyle(color: Colors.white,fontSize: 17,fontFamily: "Norwester",backgroundColor: Color(0xFF011627),),)),
//           actions: [
//             FlatButton(onPressed: (){
//               Navigator.pop(context);
//               }, child: Text("Close"))
//           ],
//         ),
//       )
//     );
//  } 

// frow() {
//   return  Padding(
//   padding:const EdgeInsets.fromLTRB(10, 10, 1,0),
//   child: Column(mainAxisAlignment: MainAxisAlignment.end,
//     children: [
//       Container(height: 60,width:0.75*(MediaQuery.of(context).size.width),decoration: BoxDecoration(
//         color: Color(0XFFFDFFFC).withOpacity(0.6),borderRadius: BorderRadius.circular(10),),
//     child: Padding(padding: const EdgeInsets.only(top: 5),
//       child: Row(children: [
//               Padding(padding: const EdgeInsets.only(left:5.0),
//                 child: Column(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment:CrossAxisAlignment.start,
//                 children: [
//                 Text('Sign on'.toUpperCase(),style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11,fontWeight:FontWeight.bold),),
//                 Text(stime,style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11),),
//                 Text(scode.toUpperCase(),style:TextStyle(color: Color(0XFFF95F62),fontFamily: "Roboto",fontWeight:FontWeight.bold,fontSize: 12),),],),),           
//               SizedBox(width:5),
//               Dash(direction:Axis.vertical,dashColor: Color(0XFF505FE1),length: 50,),SizedBox(width:4),
//               Column(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment:CrossAxisAlignment.start,
//                 children: [
//                 Text('Sign off'.toUpperCase(),style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11,fontWeight:FontWeight.bold),),
//                 Text(etime,style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11),),
//                 Text(ecode.toUpperCase(),style:TextStyle(color: Color(0XFFF95F62),fontFamily: "Roboto",fontWeight:FontWeight.bold,fontSize: 12),),],),           
//                 SizedBox(width:5),Dash(direction:Axis.vertical,dashColor: Color(0XFF505FE1),length: 50,),SizedBox(width:4),
//               Column(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment:CrossAxisAlignment.start,
//                 children: [
//                 Text('duty hrs'.toUpperCase(),style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11,fontWeight:FontWeight.bold),),
//                 Text(dhrs,style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11),),],),           
//               SizedBox(width:5),Dash(direction:Axis.vertical,dashColor: Color(0XFF505FE1),length: 50,),SizedBox(width:4),
//               Column(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment:CrossAxisAlignment.start,
//                 children: [
//                 Text('kms'.toUpperCase(),style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11,fontWeight:FontWeight.bold),),
//                 Text(kms.toUpperCase(),style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11),),],),           
//               SizedBox(width:5),Dash(direction:Axis.vertical,dashColor: Color(0XFF505FE1),length: 50,),SizedBox(width:4),
//               Column(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment:CrossAxisAlignment.start,
//                 children: [
//                 Text('ndh'.toUpperCase(),style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11,fontWeight:FontWeight.bold),),
//                 Text(nDH.toUpperCase(),style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11),),],),],),)),
//               SizedBox(height: 5),
//               Container(width:70,height: 45,
//                 decoration: BoxDecoration(color: Color(0XFFFDFFFC).withOpacity(0.6),borderRadius: BorderRadius.circular(10),),
//                   child: Center(child:Text(az,style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 15,fontWeight:FontWeight.bold),),),
//               )
//         ],
//       ),
//     );
// }
// Widget tl(String a,b){
//   return  RichText(
//                     text: TextSpan(text: a+": ",style: TextStyle(color: Color(0XFF47525E),fontFamily: "Norwester",fontSize: 13,),
//                     children: <TextSpan>[
//                       TextSpan(text: b,style: TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 13,fontWeight: FontWeight.w800),)
//                     ]
//                     ));
// }

  
// }

// class Mut1 extends StatefulWidget {
//   final int  snh,snm,sfh,sfm;final String id,uID;

//   const Mut1({Key key, this.id, this.snh, this.snm, this.sfh, this.sfm,this.uID}) : super(key: key);
//   @override
//   _Mut1State createState() => _Mut1State();
// }

// class _Mut1State extends State<Mut1> {
//   int a,b;
//   @override
//   Widget build(BuildContext context) {
//     final HttpLink httpLink=HttpLink(uri: "https://servicemanag.herokuapp.com",);
//     final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
//       GraphQLClient(link: httpLink,cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject,),),);
//     return GraphQLProvider(
//       client: client,
//       child: Scaffold(
//       body: Mutation(
//         options:MutationOptions(
//           document: r"""
//             mutation UpdateRoaster($_id:ID!,$actual_sign_on:String!,$actual_sign_off:String!){
//               UpdateRoaster(roasterInput:{_id:$_id,actual_sign_on:$actual_sign_on,actual_sign_off:$actual_sign_off}){
               
//                 actual_sign_on
//                 actual_sign_off
                
                
//               }
//             }""",),
//         builder:(  RunMutation insert,QueryResult result) {
//           return Container(child: AlertDialog(
//             title: Text("Confirmation".toUpperCase()),
//             content: Text("Are you sure want to update?"),
//             actions: [
//             FlatButton(onPressed:()=>Navigator.pop(context), child: Text("Cancel")),
//             FlatButton( onPressed: () {
//                 insert(<String,dynamic>{
//                    "_id":widget.id,
//                    "actual_sign_on":"${widget.snh}:${widget.snm}",
//                    "actual_sign_off":"${widget.sfh}:${widget.sfm}"
//                   });
//                 print(34);
//                 print("${widget.id}");
//                 print("${widget.snh}:${widget.snm}");
//                 print("${widget.sfh}:${widget.sfm}");
           
//                 Navigator.pop(context);
//               }, 
//               child: Text("Confirm"))],
//               ));
//         },
//       ),),);
//   }
// }

// class Copy extends StatefulWidget {
//   final String rid;

//   const Copy({Key key, this.rid}) : super(key: key);
//   @override
//   _CopyState createState() => _CopyState();
// }

// class _CopyState extends State<Copy> {
//   List zz;
//   @override
//   Widget build(BuildContext context) {
//      final HttpLink httpLink=HttpLink(uri: "https://servicemanag.herokuapp.com",);
//     final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
//       GraphQLClient(link: httpLink,cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject,),),);
//     return GraphQLProvider(
//       client: client,
//       child: Query(
//         options:QueryOptions(
//           document: r"""
//             query getid($_id:ID!){
//               getUserRoasterDetails(_id:$_id){
//                 _id
//                 duty_date
//                 setno                
//                 sign_on
//                 actual_sign_on
//                 sign_off
//                 actual_sign_off
//                 duty_hrs
//                 actual_duty_hrs
//                 distance
//                 ndh
//                 start_station_code
//                 end_station_code
//                 Roasterdetails{
//                   roaster
//                   train_type
//                   route_code
//                   start_on
//                   change_on
//                   actual_start_on
//                   actual_change_on
//                   halts_at
//                   train_no
//                   start_station_code
//                   end_station_code

//                 }
//               }
//             }""",
//           variables:<String,dynamic>{"_id":"${widget.rid}"} ),
//         builder:(  QueryResult result, {Refetch refetch,FetchMore fetchMore,}) {

//           if(result.loading)return Text("");

//           zz=result.data["getUserRoasterDetails"]["Roasterdetails"];

//         return  Container(height: 300,width: MediaQuery.of(context).size.width,
//           decoration: BoxDecoration(color: Color(0XFF505FE1).withOpacity(0.23),borderRadius: BorderRadius.circular(15),),
//           child: Padding(padding:const EdgeInsets.fromLTRB(5, 10, 5,0),
//             child: Column(crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Container(height: 60,width:0.75*(MediaQuery.of(context).size.width),
//               decoration: BoxDecoration(color: Color(0XFFFDFFFC).withOpacity(0.6),borderRadius: BorderRadius.circular(10),),
//               child: Padding(padding: const EdgeInsets.only(top: 5),
//                 child: Row(
//                   children: [
//                   Padding(padding: const EdgeInsets.only(left:5.0),child: frowlist("sign on",result.data["getUserRoasterDetails"]["actual_sign_on"],
//                     result.data["getUserRoasterDetails"]["start_station_code"]),),  

//                   SizedBox(width:5),Dash(direction:Axis.vertical,dashColor: Color(0XFF505FE1),length: 50,),SizedBox(width:4),
//                   frowlist("sign off",result.data["getUserRoasterDetails"]["actual_sign_off"],
//                   result.data["getUserRoasterDetails"]["end_station_code"]),

//                   SizedBox(width:5),Dash(direction:Axis.vertical,dashColor: Color(0XFF505FE1),length: 50,),SizedBox(width:4),
//                   frowlist("duty hrs",result.data["getUserRoasterDetails"]["actual_duty_hrs"],""),

//                   SizedBox(width:5),Dash(direction:Axis.vertical,dashColor: Color(0XFF505FE1),length: 50,),SizedBox(width:4),
//                   frowlist("kms",result.data["getUserRoasterDetails"]["distance"],""),

//                   SizedBox(width:5),Dash(direction:Axis.vertical,dashColor: Color(0XFF505FE1),length: 50,),SizedBox(width:4),
//                   frowlist("ndh",result.data["getUserRoasterDetails"]["ndh"],""),],),)),

//               SizedBox(height: 5,),
//               Container(width:70,height: 45,
//               decoration: BoxDecoration(color: Color(0XFFFDFFFC).withOpacity(0.6),borderRadius: BorderRadius.circular(10),),
//               child: Center(child:Text(result.data["getUserRoasterDetails"]["setno"],
//               style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 15,fontWeight:FontWeight.bold),),),),
//               SizedBox(height: 5,),


//               Container(height: 250,width: MediaQuery.of(context).size.width,decoration: BoxDecoration(color: Color(0XFFFDFFFC).withOpacity(0.6),
//               borderRadius: BorderRadius.circular(20),),child: Padding(padding: const EdgeInsets.only(top:8.0),
//                 child: Row(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment:CrossAxisAlignment.start,children: [
//                   Padding(padding: const EdgeInsets.only(left:5.0),
//                     child: Container(width: 80,
//                       child: Column(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment:CrossAxisAlignment.center,children: [
//                         Text('train no'.toUpperCase(),style: TextStyle(decoration: TextDecoration.underline,
//                           color: Color(0XFF47525E),fontSize: 12,fontFamily: "Roboto2",fontWeight: FontWeight.w800),),
//                         SizedBox(height: 5,),
//                           Expanded(
//                             child: ListView.builder(
//                               itemCount: zz.length,
//                               itemBuilder: (context,i){
//                                 return Column(
//                                     children: [
//                                       Row(children: [
//                                         Text(zz[i]["train_type"],style: TextStyle(color: Color(0XFF9A1518),fontFamily: "Roboto",fontSize: 11,)),
//                                         SizedBox(width: 8,),
//                                         Text(zz[i]["train_no"],style: TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11,),),],),
//                                         SizedBox(height: 20,),
//                                     ],
//                                       );}),),],),),),   
//                           SizedBox(width:3),
//                           Dash(direction:Axis.vertical,dashColor: Color(0XFF505FE1),length: 240,),SizedBox(width:3),
//                           Container(width: 55,
//                           child: Column(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment:CrossAxisAlignment.center,children: [
//                                     Text('Start'.toUpperCase(),style: TextStyle(decoration: TextDecoration.underline,
//                                       color: Color(0XFF47525E),fontSize: 12,fontFamily: "Roboto2",fontWeight: FontWeight.w800),),
//                                     SizedBox(height: 5,),
//                                     Expanded(child: ListView.builder(
//                                       itemCount: zz.length,
//                                       itemBuilder: (context,i){
//                                       return Row(mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment:CrossAxisAlignment.center,children: [
//                                       Column(children: [
//                                         Text(zz[i]["start_station_code"].toUpperCase(),style:TextStyle(color: Color(0XFFF95F62),fontFamily: "Roboto",fontWeight:FontWeight.bold,fontSize: 11),),
//                                         Text(zz[i]["actual_start_on"].toUpperCase(),style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11),),
//                                         SizedBox(height: 5),

//                                               ],),],);}))],),),           
//                           Dash(direction:Axis.vertical,dashColor: Color(0XFF505FE1),length: 240,),
//                           Container(width: 75,
//                     child: Column(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment:CrossAxisAlignment.center,children: [
//                               Text('change'.toUpperCase(),style: TextStyle(decoration: TextDecoration.underline,
//                                 color: Color(0XFF47525E),fontSize: 12,fontFamily: "Roboto2",fontWeight: FontWeight.w800),),
//                               SizedBox(height: 5,),
//                               Expanded(child: ListView.builder(
//                                 itemCount: zz.length,
//                                 itemBuilder: (context,i){
//                                 return Row(mainAxisAlignment:MainAxisAlignment.center,crossAxisAlignment:CrossAxisAlignment.center,children: [
//                                 Column(children: [
//                                   Text(zz[i]["end_station_code"],style:TextStyle(color: Color(0XFFF95F62),fontFamily: "Roboto",fontWeight:FontWeight.bold,fontSize: 11),),
//                                   Text(zz[i]["change_on"],style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11),),
//                                   SizedBox(height: 5,),
//                                         ],),],);
//                               }))
                              
                                  
//                                   ],),),                 
//                                       SizedBox(width:2),Dash(direction:Axis.vertical,dashColor: Color(0XFF505FE1),length: 240,),
//                                     Spacer(),
//   ],),))],),),);}),);
// }
//   Widget frowlist(String a,b,c) {
//     return Column(mainAxisAlignment:MainAxisAlignment.start,crossAxisAlignment:CrossAxisAlignment.start,
//             children: [
//             Text(a.toUpperCase(),style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11,fontWeight:FontWeight.bold),),
//             Text(b,style:TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 11),),
//             Text(c.toUpperCase(),style:TextStyle(color: Color(0XFFF95F62),fontFamily: "Roboto",fontWeight:FontWeight.bold,fontSize: 12),),],);         
            
//   }
// }
  