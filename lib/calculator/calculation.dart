import 'package:flutter/material.dart';
import 'package:train_service/widgets/widgets.dart';

class Calculation extends StatefulWidget {
  final String a,fixed,input,uta;
  const Calculation({Key key, this.a, this.fixed, this.input, this.uta}) : super(key: key);
  @override
  _CalculationState createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {
  var output,z;int a;
  TextEditingController icont=TextEditingController();
  TextEditingController rate;
  @override
  Widget build(BuildContext context) {
    var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    rate = TextEditingController(text:"${widget.fixed}");
    return Scaffold(
      backgroundColor: Color(0xFF011627),extendBodyBehindAppBar: false,
        appBar: new AppBar(automaticallyImplyLeading: false,
          title: Row(children: [
            GestureDetector(child: Icon(Icons.arrow_back),onTap: () => Navigator.pop(context),),
            topRow(context)]),
          elevation: 0,backgroundColor: Color(0xFF011627),),
        body: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(color: Color(0XFFFdFFFC),borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40),)),
            child: Padding(padding: const EdgeInsets.only(left:55.0,right: 55.0,top:75),
              child: Expanded(
                child: ListView(
                  children: [
                    Center(child: Text("${widget.a}".toUpperCase(),style:const TextStyle(color: Color(0XFF47525E),fontWeight: FontWeight.w800,
                      fontSize: 18,fontFamily: "Norwester",decoration: TextDecoration.none,)),),

                    // Align(alignment:Alignment.bottomRight,
                    //   child: Container(width:70,height:30,color: Colors.blue[400],child: Center(child: Text("hello ${widget.fixed}",
                    //   style:TextStyle(
                    //     fontSize: 16.0,
                    //     fontWeight: FontWeight.bold,
                    //     fontFamily: "Roboto",
                    //     color:Color(0XFFFDFFFC)
                    //   ),
                    //   )))),
                    SizedBox(
                      height:0.1*MediaQuery.of(context).size.width,
                    ),
                    brownText("${widget.a} Calculator", 16),
                    SizedBox(
                      height:10.0,
                    ),
                    Container(height: 36,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller:icont ,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none,color: Color(0XFF011627).withOpacity(0.44)),),
                            disabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none,color: Color(0XFF011627).withOpacity(0.44)),),
                            contentPadding:const EdgeInsets.only(left:15),focusColor: Color(0XFF011627).withOpacity(0.44),
                            labelText: "  Enter Your ${widget.input}".toUpperCase(),labelStyle: const TextStyle(color: Color(0XFFFDFFFC),fontFamily: "Roboto",fontSize: 12),
                            hintStyle: const TextStyle(color: Color(0XFF011627),fontFamily: "Roboto",fontSize: 14),
                            fillColor: Color(0XFF011627).withOpacity(0.44),filled: true,
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: const Color(0XFF011627).withOpacity(0.44),style:BorderStyle.none )),
                            prefixIcon: Container(color: Color(0XFF011627),height: 52,width: 45,
                              child: Center(child: Icon(Icons.money,color: Colors.white,)),),
                            border: new OutlineInputBorder(borderSide:new BorderSide(color: Color(0XFF011627).withOpacity(0.44)),)),
                        // validator: (input)=>(input.length > 10 || input.length < 10)?"Enter a Valid Number":null,
                        // onSaved: (input)=>_mobilenum=input,
                      ),
                    ),
                    // Text("Please Enter your ${widget.input}".toUpperCase(),
                    // style: TextStyle(
                    //   fontFamily: "Roboto",
                    //   fontSize: 16,
                    //   fontWeight: FontWeight.bold,
                    // ),
                    //
                    // ),

                    // TextField(
                    //   controller: icont,
                    //   keyboardType: TextInputType.number,
                    //   decoration: InputDecoration(hintText: "Enter ${widget.input}"),
                    // ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 36,
                          width: 0.35*MediaQuery.of(context).size.width,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            enabled:false,
                            controller:rate,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none,color: Color(0XFF011627).withOpacity(0.44)),),
                                disabledBorder: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.none,color: Color(0XFF011627).withOpacity(0.44)),),
                                contentPadding: const EdgeInsets.only(left:15),focusColor: Color(0XFF011627).withOpacity(0.44),
                                labelText: "Rate",labelStyle: const TextStyle(color: Color(0XFFFDFFFC),fontFamily: "Roboto",fontSize: 12),
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
                                child: Center(child: Text("Calculate",
                                    style: TextStyle(color: Color(0XFFFDFFFC),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold))),
                                onPressed: () {
                                  if(widget.a=="da"){
                                    z= double.parse(icont.text);
                                    setState(() {
                                      output=((z+0.3*z)*0.17).round();

                                    });
                                  }else if(widget.a=="hra"){
                                    z= double.parse(icont.text);
                                    setState(() {
                                      output=((z+0.3*z)*0.24).round();

                                    });
                                  }else if(widget.a=="tran all"){
                                    z= double.parse(icont.text);
                                    setState(() {
                                      output=((z+0.17*z)).round();

                                    });
                                  }else if(widget.a=="adl all"){
                                    z= double.parse(icont.text);
                                    setState(() {
                                      output=((z+0.17*z)).round();

                                    });
                                  }else if(widget.a=="nda"){
                                    z= double.parse(icont.text);
                                    setState(() {
                                      output=(((z+(z+0.3*z)*0.17))/200);

                                    });
                                  }else if(widget.a=="mileage"){
                                    z= double.parse(icont.text);
                                    setState(() {
                                      output=z*525;

                                    });
                                  }
                                  else{
                                    setState(() {
                                      output="0.000000";
                                    });
                                  }
                                }
                            )
                        ),
                      ],
                    ),
                    // FlatButton(color: Color(0xFFF95F62),height: 40,
                    //   child: Text('verify otp'.toUpperCase(),style: const TextStyle(color: Color(0XFFFDFFFC),
                    //       fontSize: 14,fontFamily: "Roboto",fontWeight: FontWeight.bold)),
                    // onPressed: (){
                    //   if(widget.a=="da"){
                    //      z= double.parse(icont.text);
                    //     setState(() {
                    //       output=((z+0.3*z)*0.17).round();
                    //
                    //     });
                    //   }else if(widget.a=="hra"){
                    //      z= double.parse(icont.text);
                    //     setState(() {
                    //       output=((z+0.3*z)*0.24).round();
                    //
                    //     });
                    //   }else if(widget.a=="tran all"){
                    //      z= double.parse(icont.text);
                    //     setState(() {
                    //       output=((z+0.17*z)).round();
                    //
                    //     });
                    //   }else if(widget.a=="adl all"){
                    //      z= double.parse(icont.text);
                    //     setState(() {
                    //       output=((z+0.17*z)).round();
                    //
                    //     });
                    //   }else if(widget.a=="nda"){
                    //      z= double.parse(icont.text);
                    //     setState(() {
                    //       output=(((z+(z+0.3*z)*0.17))/200);
                    //
                    //     });
                    //  }else if(widget.a=="mileage"){
                    //     z= double.parse(icont.text);
                    //     setState(() {
                    //       output=z*525;
                    //
                    //     });
                    //  }
                    //   else{
                    //     setState(() {
                    //       output="0.000000";
                    //     });
                    //   }
                    //
                    //
                    // },),
                    SizedBox(
                      height:25.0
                    ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Text("Your Total ${widget.a} is Rs ".toUpperCase(),
                       style:TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 16.0,
                         fontFamily: "Roboto",
                       )
                       ),
                       Text(output==null?"0":output.toString(),
                       style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontSize: 16.0,
                         fontFamily: "Roboto"
                       ),
                       ),
                     ],
                   ),


                ],),
              ),
            ),
          ),
    );
  }
}