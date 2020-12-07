import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';





class SignUP extends StatefulWidget {
  
  @override
  _SignUPState createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  String verificationId;
  int veri=0;
  TextEditingController _otp = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController mobileController=TextEditingController(),fnc=TextEditingController(),lnc=TextEditingController(),
  ec=TextEditingController(),ugc=TextEditingController(),utyc=TextEditingController(),msc=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  String fromDate="";DateTime from; String finalDate;
  String fname,lname,mail,usert,userg,mob,passw,mains,dates;
   HttpLink httpLink = HttpLink(
    uri: "https://servicemanag.herokuapp.com",
  );
  
  @override

  Widget build(BuildContext context) {
    Color colr ;
    var sheight = MediaQuery.of(context).size.height;
    var swidth = MediaQuery.of(context).size.width;
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
              body: Container(height: sheight,width: swidth,
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage("images/train.jpg",),fit: BoxFit.fill,
                        colorFilter: ColorFilter.mode(Color(0XFFFDFFFC).withOpacity(0.37), BlendMode.dstATop))),
              child: Mutation(
            options: MutationOptions(
              document: r"""
              mutation createUser($first_name:String!,$last_name:String!,$mobile_number:String!,$email:String!,$password:String!,$user_group:String!,$user_type:String!,$main_station:String!,$duty_joined_on:String!){
                createUser(userInput:{first_name:$first_name,last_name:$last_name,mobile_number:$mobile_number,email:$email,password:$password,user_group:$user_group,user_type:$user_type,main_station:$main_station,duty_joined_on:$duty_joined_on}){
                      mobile_number
                  first_name
                  last_name
                  email
                  
                  
                }
              }""",
            ),
            builder: (RunMutation insert, QueryResult result) {
              return Padding(
                                padding: const EdgeInsets.only(top:60.0,left: 40,right:40),

                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    logo(105,105),
                        title(25),
                        SizedBox(height: 20,),
                        brownText('Register',20),
                        
                        Expanded(child: ListView(
                          children:[ 
                            textField(fnc, "First Name"),
                            textField(lnc, "Last Name"),
                            textField(ec, "E-mail"),
                            textField(passwordController, "Password"),
                            textField(mobileController, "Mobile"),
                            textField(ugc, "User Group"),
                            textField(utyc, "User Type"),
                            textField(msc, "Main Station"),
                            SizedBox(
                              height:15.0,
                            ),
                            GestureDetector(
                                onTap: () {
                                  print("from");
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2015),
                                    lastDate: DateTime(2101),
                                  ).then((date) {
                                    setState(() {
                                      finalDate = date.day.toString() +"-" +date.month.toString() +"-" +date.year.toString();
                                      fromDate = finalDate;
                                      from = date;
                                          });
                                        });
                                      },
                                child: Container(
                                  height: 50,
                                  width: 100,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.grey[300],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        fromDate == ""
                                            ? Text(
                                                "Duty Joined On",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              )
                                            : Text(
                                                "$fromDate",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                        Icon(
                                          Icons.calendar_today,
                                          size: 20,
                                          color: Colors.grey[800],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            SizedBox(height: 15),
                            GestureDetector(
                              onTap: () {
                                colr = Color(0xFF8FB339);
                                verifyPhone(mobileController.text);
                              },
                              child:Container(
                                height: 50,
                                width: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Color(0xFF8FB339),
                                ),
                                child:Center(
                                  child:Text("Verify Phone Number",
                                  style:TextStyle(
                                    color:Color(0XFFFDFFFC),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    wordSpacing: 1.1,
                                    letterSpacing: 1.1,
                                  )
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 0.04*MediaQuery.of(context).size.width,
                                ),
                                Container(
                                  height: 36,
                                  width: 0.35*MediaQuery.of(context).size.width,
                                  alignment: Alignment.center,
                                  child:TextField(
                                    keyboardType: TextInputType.number,
                                    controller:_otp ,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none,color: Color(0XFF011627).withOpacity(0.44)),),
                                      disabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none,color: Color(0XFF011627).withOpacity(0.44)),),
                                      contentPadding: const EdgeInsets.only(left:15),focusColor: Color(0XFF011627).withOpacity(0.44),
                                      labelText: "  Enter OTP",labelStyle: const TextStyle(color: Color(0XFFFDFFFC),fontFamily: "Roboto",fontSize: 12),
                                      //  hintText: "",hintStyle: const TextStyle(color: Color(0XFF011627),fontFamily: "Roboto",fontSize: 14),
                                      fillColor: Color(0XFF011627).withOpacity(0.44),filled: true,
                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: const Color(0XFF011627).withOpacity(0.44),
                                          style:BorderStyle.none )),
                                    ),)
                                ),
                                SizedBox(

                                ),
                                Container(
                                    height: 36,
                                    width: 0.20 * MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    child: FlatButton(color: Colors.blue[200], height: 40,
                                        child: Center(child: Text("VERIFY",
                                            style: TextStyle(color: Color(0XFFFDFFFC),
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold))),
                                        onPressed: () {
                                          print("Send OTP Triggered");
                                          print(mobileController.text);
                                          _verifyOtp(_otp.text);
                                        }
                                    )
                                ),
                                SizedBox(
                                  width:0.04*MediaQuery.of(context).size.width,
                                )
                              ],
                            ),
                            SizedBox(
                                height:15.0
                            ),
                            GestureDetector(
                              child: Center(child: Text("submit".toUpperCase(), 
                                style: TextStyle(color:Color(0XFFFDFFFC),fontSize: 14,fontWeight: FontWeight.bold))),
                              onTap: (){
                                  insert(<String, dynamic>{
                                    "first_name":fnc.text,
                                    "last_name":lnc.text,
                                    "mobile_number":mobileController.text,
                                    "email":ec.text,
                                    "password":passwordController.text,
                                    "user_group":ugc.text,
                                    "user_type":utyc.text,
                                    "main_station":msc.text,
                                    "duty_joined_on": fromDate,
                                          });
                                  Navigator.pop(context);
                                }),
                         SizedBox(
                           height:40.0
                         ),
                        ])),
                       

            ],),
              );}
              ),
          ),
      ),    
      
    
     );
  }
  Widget textField(TextEditingController a,String b,){
    return TextField(
                        controller:a ,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none,color: Color(0XFF011627).withOpacity(0.44)),),
                          disabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none,color: Color(0XFF011627).withOpacity(0.44)),),
                          contentPadding: const EdgeInsets.only(left:15),focusColor: Color(0XFF011627).withOpacity(0.44),
                          labelText: b,labelStyle: TextStyle(color: Color(0XFFFDFFFC),fontFamily: "Roboto",fontSize: 12),
                        //  hintText: "981452488",hintStyle: TextStyle(color: Color(0XFF011627),fontFamily: "Roboto",fontSize: 14),
                          fillColor: Color(0XFF011627).withOpacity(0.44),filled: true,
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: const Color(0XFF011627).withOpacity(0.44),
                          style:BorderStyle.none )),
                          // prefixIcon: Container(color: Color(0XFF011627),height: 52,width: 48,
                          //   child: Center(child: Image(image: AssetImage("images/mobile.png"),height: 30,color: Colors.white,)),),
                          border: new OutlineInputBorder(borderSide:new BorderSide(color: Color(0XFF011627).withOpacity(0.44)),)),
                        //onSaved: (input)=>_mobilenum=input,
                      );
  }
  Future <void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential credential) async{
      User user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
      if(user!= null)
      {
        print("Verified");
        setState(() {
          veri=1;
        });
        //Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => Aaa(a: mobileController.text), transitionDuration: Duration(seconds: 0)));
      }
    };

    final PhoneVerificationFailed verificationFailed = (
        FirebaseAuthException authException) {
      print("Exception--------->");
      print("${authException.message}");
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      print("Code is Sent------>");
      print(verId.toString());
    };

    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verId) {
      this.verificationId = verId;
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 30),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout
    );
  }

  Future <void> _verifyOtp(ot) async{
    print("Verify OTP Triggered------>");
    AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: ot);
    User user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
    if(user!= null)
    {
      print("Verified");
      setState(() {
        veri=1;
      });
      //Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => Aaa(a: mobileController.text), transitionDuration: Duration(seconds: 0)));
    }

  }



}


