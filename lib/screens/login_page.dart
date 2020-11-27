import 'package:flutter/material.dart';
import 'package:train_service/pages/home_screen.dart';
import '../widgets/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'dart:convert'show json,base64,ascii;

import 'confirm_mobile.dart';


final storage=FlutterSecureStorage();

class LoginPage extends StatefulWidget {
  
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mobileController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  var jwt;
  String mobile1,password1;
  
  @override

  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(height: _height,width: _width,
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("images/train.jpg",),fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(Color(0XFFFDFFFC).withOpacity(0.37), BlendMode.dstATop))),
            child: Padding(padding: const EdgeInsets.only(left:60.0,right: 60,top:150),
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                              child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    logo(105,105),
                    title(25),
                    SizedBox(height: 20,),
                    brownText('log in',18),
                    SizedBox(height:15),
                   
                    Container(height: 40,
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        controller:mobileController ,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none,color: Color(0XFF011627).withOpacity(0.44)),),
                          disabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none,color: Color(0XFF011627).withOpacity(0.44)),),
                          contentPadding: const EdgeInsets.only(left:15),focusColor: Color(0XFF011627).withOpacity(0.44),
                          labelText: "   Enter Your Mobile Number",labelStyle: TextStyle(color: Color(0XFFFDFFFC),fontFamily: "Roboto",fontSize: 12),
                        //  hintText: "981452488",hintStyle: TextStyle(color: Color(0XFF011627),fontFamily: "Roboto",fontSize: 14),
                          fillColor: Color(0XFF011627).withOpacity(0.44),filled: true,
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: const Color(0XFF011627).withOpacity(0.44),
                          style:BorderStyle.none )),
                          prefixIcon: Container(color: Color(0XFF011627),height: 52,width: 48,
                            child: Center(child: Image(image: AssetImage("images/mobile.png"),height: 30,color: Colors.white,)),),
                          border: new OutlineInputBorder(borderSide:new BorderSide(color: Color(0XFF011627).withOpacity(0.44)),)),
                        //onSaved: (input)=>_mobilenum=input,
                      ),
                    ),
                    SizedBox(height:15),
                    Container(height: 40,
                      child: TextField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        controller:passwordController ,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none,color: Color(0XFF011627).withOpacity(0.44)),),
                          disabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none,color: Color(0XFF011627).withOpacity(0.44)),),
                          contentPadding: const EdgeInsets.only(left:15),focusColor: Color(0XFF011627).withOpacity(0.44),
                          labelText: "   Enter Your Password",labelStyle: TextStyle(color: Color(0XFFFDFFFC),fontFamily: "Roboto",fontSize: 12),
                          fillColor: Color(0XFF011627).withOpacity(0.44),filled: true,
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: const Color(0XFF011627).withOpacity(0.44),
                            style:BorderStyle.none )),
                          prefixIcon: Container(color: Color(0XFF011627),height: 52,width: 48,
                            child: Center(child: Image(image: AssetImage("images/key1.png"),height: 30,color: Colors.white,)),),
                          border: new OutlineInputBorder(borderSide:new BorderSide(color: Color(0XFF011627).withOpacity(0.44)),)),
                        // onSaved: (input)=>_pass=input,
                        ),
                    ),
                    
                          
                        
                    SizedBox(height:15),
                    Align(alignment:Alignment.centerRight,
                      child:GestureDetector(
                        child: Text("forgot Password?",
                        style: TextStyle(color: Color(0XFF011627),fontFamily: "Roboto2",fontSize: 10,fontWeight: FontWeight.bold),),
                        onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (_) =>ConfirmMobile() ) ),
                        ),),
                    SizedBox(height: 10,),
                    Container(height: 45,
                      child: Padding(padding: const EdgeInsets.only(left:15.0,right: 15,bottom: 10),
                        child: FlatButton(color: Color(0xFF8FB339),height: 40,
      child: Center(child: Text("submit".toUpperCase(), style: TextStyle(color: Color(0XFFFDFFFC),fontSize: 14,fontWeight: FontWeight.bold))),
          onPressed: ()async{
            setState((){
                 mobile1=mobileController.text;
             password1=passwordController.text;
           
            });
Navigator.push(context,
  PageRouteBuilder(pageBuilder:(_,__,___)=>GraphApi(mobile1:mobile1,password1:password1),transitionDuration: Duration(seconds: 0)));        
                  
          }
           
           
          
         
             ),),
                    ),
          ],),
              ),
        ),    
      
    )
     );
  }
}




class GraphApi extends StatefulWidget {
  final String mobile1,password1;
  GraphApi({this.mobile1,this.password1});
  @override
  _GraphApiState createState() => _GraphApiState();
}

class _GraphApiState extends State<GraphApi> {
  var jwt;
 
  

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink=HttpLink(uri: "https://servicemanag.herokuapp.com",);
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(link: httpLink,cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject,),),);
    return GraphQLProvider(
      
      client: client,
      child: Scaffold(
        
    
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("images/train.jpg",),fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(Color(0XFFFDFFFC).withOpacity(0.37), BlendMode.dstATop))),
          
        child: Query(
          // ignore: deprecated_member_use
          options:QueryOptions(
            document: r"""
              query getid($mobile:String!,$password:String!){
                login(mobile:$mobile,password:$password){
                
                  token
                  tokenExpiration
                }
              }""",
            variables:<String,dynamic>{"mobile":"${widget.mobile1}","password":"${widget.password1}"} ),
          builder:(  QueryResult result, {
  Refetch refetch,
  FetchMore fetchMore,
}) {
              
               if(result.loading)return Center(child: CircularProgressIndicator(),);
                if(result.data==null)return AlertDialog(title: Text("Error"),content: Text("No Account Found"),);
               jwt=result.data["login"]["token"];
               
             
              
             if(jwt!=null){
               var avz=jwt.split(".");
              
               var payload = json.decode(ascii.decode(base64.decode(base64.normalize(avz[1]))));
                storage.write(key: "jwt", value: jwt);
                if(DateTime.fromMillisecondsSinceEpoch(payload["exp"]*1000).isAfter(DateTime.now())) {
                  return Home(jwt:jwt, payload:payload);
                } else return AlertDialog(title: Text("Error"),content: Text("No Account Found"),);
                
                
                }
                // storage.write(key: "jwt", value: jwt);
                // return First(jwt:jwt,);
              
              
           
          }
        ),
      ),
    ),
      
    );
  }
}

