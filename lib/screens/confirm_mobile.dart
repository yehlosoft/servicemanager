import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:train_service/widgets/widgets.dart';
import '../pages/searchresult.dart';
import 'new_password.dart';

class ConfirmMobile extends StatefulWidget {
  @override
  _ConfirmMobileState createState() => _ConfirmMobileState();
}

class _ConfirmMobileState extends State<ConfirmMobile> {
  TextEditingController mobileController=TextEditingController();
  TextEditingController otp = new TextEditingController();
  String mnum;
  String but="SEND CODE";
  String colr = "green";
  String verificationId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("images/train.jpg",),fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(Color(0XFFFDFFFC).withOpacity(0.37), BlendMode.dstATop))),
        child: Padding(padding: const EdgeInsets.only(left:55.0,right: 55,top:150),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                logo(105,105),
                title(25),
                SizedBox(height:20),
                brownText("recover your password",16),
                SizedBox(height:10),
                Container(height: 36,
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    controller:mobileController ,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none,color: Color(0XFF011627).withOpacity(0.44)),),
                        disabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none,color: Color(0XFF011627).withOpacity(0.44)),),
                        contentPadding:const EdgeInsets.only(left:15),focusColor: Color(0XFF011627).withOpacity(0.44),
                        labelText: "  Enter Mobile Number",labelStyle: const TextStyle(color: Color(0XFFFDFFFC),fontFamily: "Roboto",fontSize: 12),
                        hintText: "+91981452488",hintStyle: const TextStyle(color: Color(0XFF011627),fontFamily: "Roboto",fontSize: 14),
                        fillColor: Color(0XFF011627).withOpacity(0.44),filled: true,
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: const Color(0XFF011627).withOpacity(0.44),style:BorderStyle.none )),
                        prefixIcon: Container(color: Color(0XFF011627),height: 52,width: 45,
                          child: Center(child: Image(image: AssetImage("images/mobile.png"),height: 25,color: Colors.white,)),),
                        border: new OutlineInputBorder(borderSide:new BorderSide(color: Color(0XFF011627).withOpacity(0.44)),)),
                    // validator: (input)=>(input.length > 10 || input.length < 10)?"Enter a Valid Number":null,
                    // onSaved: (input)=>_mobilenum=input,
                  ),
                ),
                SizedBox(height:15),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 36,
                      width: 0.35*MediaQuery.of(context).size.width,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller:otp ,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none,color: Color(0XFF011627).withOpacity(0.44)),),
                            disabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none,color: Color(0XFF011627).withOpacity(0.44)),),
                            contentPadding: const EdgeInsets.only(left:15),focusColor: Color(0XFF011627).withOpacity(0.44),
                            labelText: "  Enter OTP",labelStyle: const TextStyle(color: Color(0XFFFDFFFC),fontFamily: "Roboto",fontSize: 12),
                            //  hintText: "",hintStyle: const TextStyle(color: Color(0XFF011627),fontFamily: "Roboto",fontSize: 14),
                            fillColor: Color(0XFF011627).withOpacity(0.44),filled: true,
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: const Color(0XFF011627).withOpacity(0.44),
                                style:BorderStyle.none )),

                            prefixIcon: Container(color: Color(0XFF011627),height: 52,width: 45,
                              child: Center(child: Image(image: AssetImage("images/otp.png"),height: 25,color: Colors.white,)),),
                            border: new OutlineInputBorder(borderSide:new BorderSide(color: Color(0XFF011627).withOpacity(0.44)),)),),),
                    //
                    // Container(
                    //     height: 36,
                    //     width: 0.35*MediaQuery.of(context).size.width,
                    //     child:greenButText("send otp", SearchResult(), context,12)),
                    Container(
                        height: 36,
                        width: 0.35 * MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: FlatButton(color: Color(0xFF8FB339), height: 40,
                            child: Center(child: Text(but,
                                style: TextStyle(color: Color(0XFFFDFFFC),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold))),
                            onPressed: () {
                              print("Send OTP Triggered");
                              print(mobileController.text);
                              verifyPhone(mobileController.text);
                            }
                        )
                    ),
                  ],
                ),
                SizedBox(height:15),
                Padding(padding: const EdgeInsets.only(left:15.0,right: 15,bottom: 10),
                    child: Container(width:MediaQuery.of(context).size.width,
                      child: FlatButton(color: Color(0xFFF95F62),height: 40,
                          child: Text('verify otp'.toUpperCase(),style: const TextStyle(color: Color(0XFFFDFFFC),
                              fontSize: 14,fontFamily: "Roboto",fontWeight: FontWeight.bold)),
                          onPressed: () {
                            _verifyOtp(otp.text);
                          }
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future <void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential credential) async{
      User user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
      if(user!= null)
      {
        Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => Aaa(a: mobileController.text), transitionDuration: Duration(seconds: 0)));
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
      setState(() {
        colr = "red";
        but = "RESEND OTP";
      });
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
      Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => Aaa(a: mobileController.text), transitionDuration: Duration(seconds: 0)));
    }

  }


}

class Aaa extends StatefulWidget {
  final String a;

  const Aaa({Key key, this.a}) : super(key: key);
  @override
  _AaaState createState() => _AaaState();
}

class _AaaState extends State<Aaa> {
  String checknum,pid;
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink=HttpLink(uri: "https://servicemanag.herokuapp.com",);
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(link: httpLink,cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject,),),);
    return GraphQLProvider(
      client: client,
      child:
      Scaffold(
        backgroundColor: Colors.red,
        body: Query(
          // ignore: deprecated_member_use
            options:QueryOptions(
                document: r"""
              query getmob($mobile:String!){
                UserExist(mobile:$mobile){               
                  _id
                  mobile
                }
              }""",
                variables:<String,dynamic>{"mobile":"${widget.a}"}
            ),

            builder:(  QueryResult result, {Refetch refetch,FetchMore fetchMore,}) {

              if(result.hasException) return Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                  children:[Icon(Icons.wifi_off,),Text("no internet")]);

              if(result.loading)return Center(child: CircularProgressIndicator());

              checknum=result.data["UserExist"]["mobile"];
              pid=result.data["UserExist"]["_id"];
              print(pid);

              if(checknum==widget.a) return RecoverPassword(pid:pid);
              return AlertDialog(title: Text("Error"),content: Text("Wrong Mobile Number"),);

            }
        ),
      ),);
  }
}