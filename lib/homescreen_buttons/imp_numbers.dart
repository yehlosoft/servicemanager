import 'package:flutter/material.dart';
import 'package:getflutter/components/search_bar/gf_search_bar.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:train_service/pages/chat_screen.dart';
import 'package:train_service/pages/profile.dart';
import 'package:train_service/pages/livelocation.dart';
import 'package:train_service/pages/save.dart';
import 'package:train_service/pages/searchresult.dart';
import 'package:train_service/widgets/bottomNavBar.dart';
import 'package:train_service/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class AA extends StatefulWidget {
  @override
  _AAState createState() => _AAState();
}

class _AAState extends State<AA> {
  List aa=List<dynamic>();
  @override
  void initState(){
    super.initState();

  }
  

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink=HttpLink(uri: "https://servicemanag.herokuapp.com",);
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(link: httpLink,cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject,),),);
    return GraphQLProvider(
      client: client,
      child: Scaffold(
      body: Query(
        // ignore: deprecated_member_use
        options:QueryOptions(
          document: r"""
            query getdept{
              getAllDepartments{               
                _id
                department
              }
            }""",
          //variables:<String,dynamic>{"mobile":"${widget.mobile1}","password":"${widget.password1}"}
           ),
         
        builder:(  QueryResult result, {Refetch refetch,FetchMore fetchMore,}) { 
if(result.hasException)return Column(
                                      mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                                      children:[Icon(Icons.wifi_off,),Text("no internet")]);
          if(result.loading)return ImportantNumbers(aa:[],);
          aa=result.data["getAllDepartments"];

            return ImportantNumbers(aa:aa,);
                    
         
        }
      ),),);
  }
}



class ImportantNumbers extends StatefulWidget {
  final List<dynamic> aa;
  const ImportantNumbers({Key key, this.aa, }) : super(key: key);
  @override
  _ImportantNumbersState createState() => _ImportantNumbersState();
}

class _ImportantNumbersState extends State<ImportantNumbers> {
  String did,sid;
  bool dbool=true,sbool=true;
  static List<String> initially;
  String searchHint="Enter Station Name to Search";
  String searchLabel1="Select Department";
  String searchLabel2="Select Station";
  List sa;
  List cname;
  @override
  void initState(){
    super.initState();
        sa=initially;
    cname=initially;
  }
  
  @override
  Widget build(BuildContext context) {
    var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
          body: Stack(children: [
              Positioned(top:0,child: Container(height: screenHeight,width: screenWidth,child: importantNumbersBody()),),
  
              Align(alignment: Alignment.bottomCenter,child: footer1(
                context:context,
                w1: ()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>Profile(),transitionDuration: Duration(seconds: 0))),
                w2: ()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>Tower(),transitionDuration: Duration(seconds: 0))),
                w3: ()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>ChatScreen(),transitionDuration: Duration(seconds: 0))),
                w4: ()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>SaveScreen(),transitionDuration: Duration(seconds: 0))),
               
              )),

              Positioned(bottom:15,left:100,right:100,child: footer2(
                context: context,
                w:()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>Search1(),transitionDuration: Duration(seconds: 0))),
               
              )),
            ],
          ),
    );
}

 Widget importantNumbersBody() {
     var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF011627),extendBodyBehindAppBar: false,
      appBar: new AppBar(automaticallyImplyLeading: false,title:topRow(context),elevation: 0,backgroundColor: Color(0xFF011627),),
      body: Container(height: screenHeight,width: screenWidth,decoration: BoxDecoration(color: Color(0XFFFdFFFC),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40),)),
            child: Padding(padding: const EdgeInsets.only(left:10.0,right: 10),
              child: Column(children: [

                Padding(padding: const EdgeInsets.all(15),child: head("Important numbers"),),

                _deptSearch(),
                
                setFetch(),

                nameandcontacts(),

                Expanded(child: (dbool==false&&sbool==false)
                  ?fetchContacts()
                  :display1("Select First","Select First")),


              ],),
        ),
      ),
    );
        
  }



Widget _deptSearch() {
  return  GFSearchBar(
        searchBoxInputDecoration: InputDecoration(
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid,color: const Color(0xFF9A1518),),
          borderRadius: BorderRadius.all(Radius.circular(50))),
        disabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid,color: const Color(0xFF9A1518),),
          borderRadius: BorderRadius.all(Radius.circular(50))),
        contentPadding: EdgeInsets.only(left:25),focusColor: Color(0xFF9A1518).withOpacity(0.44),
        labelText: searchLabel1,
        labelStyle: TextStyle(color: Color(0XFF011627),fontFamily: "Roboto",fontSize: 16,fontWeight: FontWeight.bold),
        hintText: searchHint,hintStyle: TextStyle(color: Color(0XFF011627),fontFamily: "Roboto",fontSize: 12),
        fillColor: Colors.white.withOpacity(0.44),filled:true,
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),
          borderSide: BorderSide(color: const Color(0xFF9A1518),style:BorderStyle.solid )),
        suffixIcon: Icon(Icons.search,color: Color(0XFFBFF95F62),size: 30,),
        border: new OutlineInputBorder(borderSide: BorderSide(style:BorderStyle.none ,),borderRadius: BorderRadius.all(Radius.circular(50)))),

        searchList: widget.aa,

        searchQueryBuilder: (query, searchItems) {
            return widget.aa.where((item) =>item["department"].toUpperCase().contains(query.toUpperCase())).toList();},

        overlaySearchListItemBuilder: (item){
          return new Container(width: double.infinity,decoration: BoxDecoration(color: Color(0XFF011627).withOpacity(0.1)),
            child:Padding(padding: const EdgeInsets.all(10),
              child: Text(item["department"],style: TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 15),),),);},

        onItemSelected: (item) {
          setState(() {
         // searchLabel1 = item["department"];
          did=item["_id"];
          print("$did");
          dbool=false;
          });
        },);
}

Widget setFetch(){
  final HttpLink httpLink=HttpLink(uri: "https://servicemanag.herokuapp.com",);
  final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
    GraphQLClient(link: httpLink,cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject,),),);
  return GraphQLProvider(
    client: client,
    child:Query(
        options:QueryOptions(
          document: r"""
            query getdept{
              getAllStations{               
                station_name
                _id
                
              }
            }""",),
          builder:(  QueryResult result, {Refetch refetch,FetchMore fetchMore,}) { 
          
          if(result.loading) return _setSearch([]);

          sa=result.data["getAllStations"];
          
          return _setSearch(sa);
                        
                    
        }
  ),);
}

Widget _setSearch(List<dynamic> aaa) {
  return  GFSearchBar(
      searchBoxInputDecoration: InputDecoration(
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid,color: const Color(0xFF9A1518),),
        borderRadius: BorderRadius.all(Radius.circular(50))),
      disabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid,color: const Color(0xFF9A1518),),
        borderRadius: BorderRadius.all(Radius.circular(50))),
      contentPadding: EdgeInsets.only(left:25),
      focusColor: Color(0xFF9A1518).withOpacity(0.44),
      labelText: searchLabel2,
      labelStyle: TextStyle(color: Color(0XFF011627),fontFamily: "Roboto",fontSize: 16,fontWeight: FontWeight.bold),
      hintText: searchHint,
      hintStyle: TextStyle(color: Color(0XFF011627),fontFamily: "Roboto",fontSize: 12),
      fillColor: Colors.white.withOpacity(0.44),filled:true,
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),
        borderSide: BorderSide(color: const Color(0xFF9A1518),style:BorderStyle.solid )),
      suffixIcon: Icon(Icons.search,color: Color(0XFFBFF95F62),size: 30,),
        border: new OutlineInputBorder(borderSide: BorderSide(style:BorderStyle.none ,),borderRadius: BorderRadius.all(Radius.circular(50)))),

      searchList: aaa,

      searchQueryBuilder: (query, searchItems) {
          return aaa.where((item) =>item["station_name"].toString().contains(query.toUpperCase())).toList();},

      overlaySearchListItemBuilder: (item){
        return new Container(width: double.infinity,
          decoration: BoxDecoration(color: Color(0XFF011627).withOpacity(0.1)),child:Padding(padding: const EdgeInsets.all(10),
            child: Text(item["station_name"],style: TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto",fontSize: 15),),),);},

      onItemSelected: (item) {
        setState(() {
       // searchLabel2 = item["station_name"];
        sid=item["_id"];
        sbool=false;
        });
      },);
}

Widget nameandcontacts(){
  var screenWidth=MediaQuery.of(context).size.width;
  return Container(height: 40,width: screenWidth,color: Color(0xFF9A1518),padding: EdgeInsets.only(left:40,right:40),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              Text("Names".toUpperCase(),style: TextStyle(color:Colors.white,fontSize: 12,fontWeight: FontWeight.w800)),
              Row(children: [
                  Icon(Icons.call,color: Colors.white,size: 20),
                  SizedBox(width:10),
                  Text("numbers".toUpperCase(),style: TextStyle(color:Colors.white,fontSize: 12,fontWeight: FontWeight.w800))],),
    ],));
}

Widget fetchContacts(){
  final HttpLink httpLink=HttpLink(uri: "https://servicemanag.herokuapp.com",);
  final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
    GraphQLClient(link: httpLink,cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject,),),);
  return GraphQLProvider(
      client: client,
      child:Query(
        options:QueryOptions(
          document: r"""
            query getcontact($department:ID!,$station:ID!){
              getContactsByDepartmentandStation(ctinput:{department:$department,station:$station}){               
                fullname
                contactNo
                
              }
            }""",
          variables:<String,dynamic>{"department":"$did","station":"$sid"}),
        builder:(  QueryResult result, {Refetch refetch,FetchMore fetchMore,}) {
        
          if(result.loading)return Center(child: CircularProgressIndicator());

          cname=result.data["getContactsByDepartmentandStation"];

          return display2(cname);
            
         
        }
  ),);
}




 
  Widget display2(List<dynamic> aa) {
    int len=aa.length;
    return len==0?display1("Empty","empty")
    : ListView.builder(
      itemCount: aa.length,
      itemBuilder: (BuildContext context,int i){
        return Column(children: [
           new Container(height: 60,color:Color(0XFFFDFFFC).withOpacity(0.6),padding: EdgeInsets.only(left:40,right:40),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                Text(aa[i]["fullname"],
                  style: TextStyle(fontSize: 13,fontFamily: "Roboto",color: Color(0XFF002C5B),fontWeight: FontWeight.bold)),

                GestureDetector(
                    onTap: ()async{
                      String url='tel:${aa[i]["contactNo"]}';
                      if (await canLaunch(url)) {await launch(url);}
                      else {throw "Can't launch call";}
                    },
                  child: Text(aa[i]["contactNo"],style: const TextStyle(fontSize: 13,color: Color(0XFF9A1518),fontFamily: "Roboto2")),)],),),

          Container(height: 1,width: double.infinity,color:Color(0XFF8080C5).withOpacity(0.19),)],);});
  }
  Widget display1(String a,b) {
    return ListTile(
      title:Column(children: [
          new Container(height: 60,color:Color(0XFFFDFFFC).withOpacity(0.6),padding: EdgeInsets.only(left:40,right:40),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                Text(a,style: TextStyle(fontSize: 13,fontFamily: "Roboto",color: Color(0XFF002C5B),fontWeight: FontWeight.bold)),
              
                Text(b,style: const TextStyle(fontSize: 13,color: Color(0XFF9A1518),fontFamily: "Roboto2"))],),),
                      Container(height: 1,width: double.infinity,color:Color(0XFF8080C5).withOpacity(0.19),)],));
  }



}