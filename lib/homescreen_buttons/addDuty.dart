import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:train_service/widgets/widgets.dart';

class AddDuty extends StatefulWidget {
  final String did,drid;

  const AddDuty({ this.did, this.drid}) ;
  @override
  _AddDutyState createState() => _AddDutyState();
}

class _AddDutyState extends State<AddDuty> {
   String rec="Editable Records";int option=1;
     HttpLink httpLink=HttpLink(uri: "https://servicemanag.herokuapp.com",);
    TextEditingController contentController=TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;

     ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(link: httpLink,cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject,),),);
      return GraphQLProvider(
      client: client,
      child: Scaffold(
        backgroundColor: Color(0xFF011627),extendBodyBehindAppBar: false,
      appBar: new AppBar(automaticallyImplyLeading: false,title:Row(children: [ 
        GestureDetector(child: Icon(Icons.arrow_back),onTap: ()=>Navigator.pop(context),),
        
        topRow(context)]),elevation: 0,backgroundColor: Color(0xFF011627),),
      body: Container(height: screenHeight,width: screenWidth,decoration: BoxDecoration(color: Color(0XFFFdFFFC),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40),)),
    
             
                child: Mutation(
          options:MutationOptions(
            document: r"""
                mutation AddDutyRecord($user:ID!,$roaster:ID!,$recordtype:String!,$recordtext:String!){
                  AddDutyRecord(recordInput:{user:$user,roaster:$roaster,recordtype:$recordtype,recordtext:$recordtext}){
                   
                    
                    recordtype
                    recordtext
                    
                    
                  }
                }""",),
          builder:(  RunMutation insert,QueryResult result) {
            return Column(
                children: [
                  Padding(padding: const EdgeInsets.all(15),child: head("duty records"),),
                 
                  DropdownButton(
                    hint: Text(" Choose Records "),
                    
                    items: [
                    DropdownMenuItem(
                      child:Text("Editable Records",
             style: const TextStyle(fontFamily: "Roboto",fontSize: 11,color: Color(0XFF47525E),fontWeight: FontWeight.w900,),maxLines: 2,),
             value: 1,onTap: () {
               setState(() {
                 rec="EDITABLE";
               });
          },),
                DropdownMenuItem(
                      child:Text("Important Records",
             style: const TextStyle(fontFamily: "Roboto",fontSize: 11,color: Color(0XFF47525E),fontWeight: FontWeight.w900,),maxLines: 2,),
             value: 1,onTap: () {
               setState(() {
                 rec="IMPORTANT";
               });
          },),
                DropdownMenuItem(
                      child:Text("Unusual Records",
             style: const TextStyle(fontFamily: "Roboto",fontSize: 11,color: Color(0XFF47525E),fontWeight: FontWeight.w900,),maxLines: 2,),
             value: 1,onTap: () {
               setState(() {
                 rec="UNUSUAL";
               });
          },),
                    
                  ], onChanged: (value){
                    setState(() {
                      option=value;
                    });
                  }),
          //          Row(children: [
          //       Radio(value: 1, groupValue: option, activeColor:  Color(0XFFF95F62),onChanged: (T){setState(() {option=T;});}),
          //       Text("Editable Records",
          //    style: const TextStyle(fontFamily: "Roboto",fontSize: 11,color: Color(0XFF47525E),fontWeight: FontWeight.w900,),maxLines: 2,),],),
          // Row(children: [
          //       Radio(value: 2, groupValue: option, activeColor:  Color(0XFFF95F62),onChanged: (T){setState(() {option=T;rec="Important Records";});}),
          //       Text("Important Records",
          //    style: const TextStyle(fontFamily: "Roboto",fontSize: 11,color: Color(0XFF47525E),fontWeight: FontWeight.w900,),maxLines: 2,),],),
          // Row(children: [
          //       Radio(value: 3, groupValue: option, activeColor:  Color(0XFFF95F62),onChanged: (T){setState(() {option=T;rec="Unusual Records";});}),
          //       Text("Unusual Records",
          //    style: const TextStyle(fontFamily: "Roboto",fontSize: 11,color: Color(0XFF47525E),fontWeight: FontWeight.w900,),maxLines: 2,),],),
         SizedBox(height:15),
          TextField(controller: contentController,decoration: InputDecoration(hintText: "   Enter text"),),
          SizedBox(height:50),
          FlatButton( onPressed: () {
                        insert(<String,dynamic>{
                           "user":"${widget.did}",
                           "roaster":"${widget.drid}",
                           "recordtype":rec,
                        "recordtext":contentController.text,
                         });
                        // print("$did       $drid             $rec           ${contentController.text}");
                        
                   
                        Navigator.pop(context);
                      }, 
                      child: Text("Add To Duty Records",style: TextStyle(color: Color(0XFFFDFFFC)),),color: Color(0xFF8FB339),),
                     // Text("${result.data?.data?.toString()}")



                 
                ],
            );
          },
        ),
              ),
      ),);
                      
          
         

                           
               
  }
}