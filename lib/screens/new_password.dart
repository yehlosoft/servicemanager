import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:train_service/screens/login_page.dart';
import 'package:train_service/widgets/widgets.dart';


class RecoverPassword extends StatefulWidget {
  final String pid;

  const RecoverPassword({Key key, this.pid}) : super(key: key);
  @override
  _RecoverPasswordState createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
   HttpLink httpLink = HttpLink(
    uri: "https://servicemanag.herokuapp.com",
  );
  TextEditingController p1=TextEditingController(),p2=TextEditingController();
  @override
  Widget build(BuildContext context) {
    ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: httpLink,
        cache: OptimisticCache(
          dataIdFromObject: typenameDataIdFromObject,
        ),
      ),
    );
    return GraphQLProvider(
      client: client,
      child: Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage("images/train.jpg",),fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(Color(0XFFFDFFFC).withOpacity(0.37), BlendMode.dstATop))),
              child:Mutation(
            options: MutationOptions(
              document: r"""
              mutation ChangePassword($_id:ID!,$newPassword:String!){
                ChangePassword(_id:$_id,newPassword:$newPassword){
                     message
                  
                  
                }
              }""",
            ),
            builder: (RunMutation insert, QueryResult result) {
              return  Padding(padding: const EdgeInsets.only(left:55.0,right: 55,top:150),
                    child: SingleChildScrollView(
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                                      child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        logo(105,105),
                        title(25),
                        SizedBox(height:20),
                        brownText("create new password",18),
                        SizedBox(height:10),
                        Container(height: 40,
                          child: TextField(
                             
                              controller:p1 ,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none,color: Color(0XFF011627).withOpacity(0.44)),),
                                disabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none,color: Color(0XFF011627).withOpacity(0.44)),),
                                contentPadding:const EdgeInsets.only(left:15),focusColor: Color(0XFF011627).withOpacity(0.44),
                                labelText: "Enter Your New Password",labelStyle: TextStyle(color: Color(0XFFFDFFFC),fontFamily: "Roboto",fontSize: 12),
                                fillColor: Color(0XFF011627).withOpacity(0.44),filled: true,
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: const Color(0XFF011627).withOpacity(0.44),style:BorderStyle.none )),
                              
                                prefixIcon: Container(color: Color(0XFF011627),height: 52,width: 48,
                                  child: Center(child: Image(image: AssetImage("images/key.png"),height: 25,color: Colors.white,)),),
                                border: new OutlineInputBorder(borderSide:new BorderSide(color: Color(0XFF011627).withOpacity(0.44)),)),
                              // validator: (input)=>(input.length > 10 || input.length < 10)?"Enter a Valid Number":null,
                              // onSaved: (input)=>_mobilenum=input,
                              ),
                        ),
                        SizedBox(height:20),            
                         Container(height: 40,            
                           child: TextField(
                           
                              controller:p2 ,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none,color: Color(0XFF011627).withOpacity(0.44)),),
                                disabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none,color: Color(0XFF011627).withOpacity(0.44)),),
                                contentPadding: const EdgeInsets.only(left:15),focusColor: Color(0XFF011627).withOpacity(0.44),
                                labelText: "Confirm Your New Password",labelStyle: TextStyle(color: Color(0XFFFDFFFC),fontFamily: "Roboto",fontSize: 12),
                               // hintText: "981452488",hintStyle: TextStyle(color: Color(0XFF011627),fontFamily: "Roboto",fontSize: 14),
                                fillColor: Color(0XFF011627).withOpacity(0.44),filled: true,
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: const Color(0XFF011627).withOpacity(0.44),style:BorderStyle.none )),
                              
                                prefixIcon: Container(color: Color(0XFF011627),height: 52,width: 48,
                                  child: Center(child: Image(image: AssetImage("images/key.png"),height: 25,color: Colors.white,)),),
                                border: new OutlineInputBorder(borderSide:new BorderSide(color: Color(0XFF011627).withOpacity(0.44)),)),
                              // validator: (input)=>(input.length > 10 || input.length < 10)?"Enter a Valid Number":null,
                              // onSaved: (input)=>_mobilenum=input,
                              ),
                         ),
                         SizedBox(height:15),
                         Padding(
                   padding: const EdgeInsets.only(left:15.0,right: 15,bottom: 10),
                      child:  FlatButton(color: Color(0xFF8FB339),height: 40,
      child: Center(child: Text("submit".toUpperCase(), style: TextStyle(color: Color(0XFFFDFFFC),fontSize: 15,fontWeight: FontWeight.bold))),
          onPressed: ()  {
            if(p1.text==p2.text){
              insert(<String, dynamic>{
                                    "_id":"${widget.pid}",
                                    "newPassword":p1.text,
                                   
                                          });
                                          print("${widget.pid}");
                                          print(p1.text);
                                                                                    print("${result.data?.data?.toString()}");

              Navigator.push(context, MaterialPageRoute(builder: (_) =>LoginPage()) );
            }else return AlertDialog(title: Text("Error"),content: Text("Password not matched"),);
          } ))

                              
                  ],
                  ),
                    ),
                );}
              ),
        ),
      ),
    );
  }
}