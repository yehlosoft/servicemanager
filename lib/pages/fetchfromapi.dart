import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'dart:convert'show json,base64,ascii;

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
    
      body: Query(
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
      
    );
  }
}

