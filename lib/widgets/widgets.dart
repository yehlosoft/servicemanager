import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:train_service/screens/login_page.dart';

final storage=FlutterSecureStorage();
logo(double h,double w) {
    return Center(child: Image(image:const AssetImage("images/comp.png"),color: Color(0XFFFFAC1D1D),height: h,width: w,));
  }

title(double h) {
    return  Padding(padding: const EdgeInsets.only(left:15.0,right: 15,),
      child: Center(child: Text("service manager".toUpperCase(),style: TextStyle(color: Color(0XFFAC1D1D),fontFamily: "Norwester",fontSize: h),)),
    );
  }

brownText(String a,double b) {
    return Text(a.toUpperCase(),style: TextStyle(color: Color(0XFF47525E),fontFamily: "Norwester",fontSize: b),);
  }

greenButText(String a, Widget b,BuildContext context,double c) {
  return  FlatButton(color: Color(0xFF8FB339),height: 40,
      child: Center(child: Text(a.toUpperCase(), style: TextStyle(color: Color(0XFFFDFFFC),fontSize: c,fontWeight: FontWeight.bold))),
          onPressed: ()  =>Navigator.push(context, MaterialPageRoute(builder: (_) =>b) ) );
}


topRow(context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset('images/apps.png',height: 50,color: Colors.white,),
      SizedBox(width:1),
      Image.asset('images/comp.png',height: 35,color: Colors.white,),
      SizedBox(width:10),
      Text('Service Manager',style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Norwester")),
      SizedBox(width:15),
      Align(alignment:Alignment.topRight,child: Image.asset('images/bell.png',color: Color(0xFF8080C5),height: 30,)),
        SizedBox(width:10),
        Align(alignment:Alignment.topRight,
                  child: GestureDetector(
          onTap: (){
            storage.delete(key: "jwt");
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>LoginPage()));

          },
          
          child: Icon(Icons.exit_to_app,color: Colors.red[900],size:25),),
        ),
        SizedBox(width:5),

    ],
  );
}  
Widget texts(String t1,String t2){
    return RichText(
                    text: TextSpan(text: t1+": ",style: TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto2"),
                    children: <TextSpan>[
                      TextSpan(text: t2,style: TextStyle(color: Color(0XFF47525E),fontFamily: "Roboto2"),),
                    ]
                    ));
  }
 
head(String a) {
    return Center(child: Text(a.toUpperCase(),
      style:const TextStyle(color: Color(0XFF47525E),fontWeight: FontWeight.w800,
      fontSize: 18,fontFamily: "Norwester",decoration: TextDecoration.none,)));
  }
 