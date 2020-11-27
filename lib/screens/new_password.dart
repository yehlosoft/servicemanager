import 'package:flutter/material.dart';
import 'package:train_service/pages/home_screen.dart';
import 'package:train_service/widgets/widgets.dart';


class RecoverPassword extends StatefulWidget {
  @override
  _RecoverPasswordState createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
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
                    brownText("create new password",18),
                    SizedBox(height:10),
                    Container(height: 40,
                      child: TextField(
                         // keyboardType: TextInputType.phone,
                          //controller:mobile ,
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
                        //  keyboardType: TextInputType.number,
                          //controller:mobile ,
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
                  child:  greenButText("submit", Home(), context,12)
                          ),
              ],
              ),
                ),
            ),
      ),
    );
  }
}