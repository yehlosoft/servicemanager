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
  
  @override
  Widget build(BuildContext context) {
    var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(backgroundColor: Color(0xFF011627),
        extendBodyBehindAppBar: false,
        appBar: new AppBar(
          automaticallyImplyLeading: false,
          title: Row(children: [
            GestureDetector(
              child: Icon(Icons.arrow_back),
              onTap: () => Navigator.pop(context),
            ),
            topRow(context)
          ]),
          elevation: 0,
          backgroundColor: Color(0xFF011627),
        ),
        body: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(
              color: Color(0XFFFdFFFC),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              )),
            child: Padding(
              padding: const EdgeInsets.only(left:10,right:10),
              child: Expanded(
                            child: ListView(
                  children: [
                    Center(
                      child: Text("${widget.a}".toUpperCase(),
      style:const TextStyle(color: Color(0XFF47525E),fontWeight: FontWeight.w800,
      fontSize: 18,fontFamily: "Norwester",decoration: TextDecoration.none,)),
                    ),
                    Align(alignment:Alignment.bottomRight,child: Container(width:70,height:30,color: Colors.purple,child: Center(child: Text("${widget.fixed}")))),
                    Text("${widget.input}".toUpperCase()),
                    TextField(
                      controller: icont,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(hintText: "Enter ${widget.input}"),
                    ),
                    FlatButton(child:Text("Calcuate ${widget.a}".toUpperCase()),
                    color: Colors.green,
                    onPressed: (){
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


                    },),
                   Text(output==null?"0":output.toString()),
                   

                ],),
              ),
            ),
          ),
    );
  }
}