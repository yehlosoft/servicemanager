import 'dart:async';
import 'package:flutter/material.dart';
import 'package:train_service/pages/home_screen.dart';
import 'package:train_service/screens/splashscren.dart';
import 'login_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert'show json,base64,ascii;

final storage=FlutterSecureStorage();

class Insert extends StatelessWidget {
  Future<String> get jwtorEmpty async{
    var jwt=await storage.read(key:"jwt");
    if(jwt==null) return"";
    return jwt;
    }
 

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future: jwtorEmpty,            
        builder: (context, snapshot) {
          print("insert");
          if(!snapshot.hasData) return Center(child: SplashScreen());
          if(snapshot.data != "") {
            var str = snapshot.data;
            var jwt = str.split(".");

            if(jwt.length !=3) {
              return LoginPage();
            } else {
              var payload = json.decode(ascii.decode(base64.decode(base64.normalize(jwt[1]))));
              if(DateTime.fromMillisecondsSinceEpoch(payload["exp"]*1000).isAfter(DateTime.now())) {
                return Home(jwt:str, payload:payload);
              } else {
                return LoginPage();
              }
            }
          } 
            return LoginPage();
          
        }
      
    );
  }
}
