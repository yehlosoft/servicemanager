import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:train_service/models/duty_records_list.dart';
import 'package:train_service/pages/chat_screen.dart';
import 'package:train_service/pages/profile.dart';
import 'package:train_service/pages/livelocation.dart';
import 'package:train_service/pages/save.dart';
import 'package:train_service/pages/searchresult.dart';
import 'package:train_service/widgets/bottomNavBar.dart';
import 'package:train_service/widgets/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'duty_dialog.dart';

class DutyRecords extends StatefulWidget {
  final String uid;

  const DutyRecords({Key key, this.uid}) : super(key: key);
  @override
  _DutyRecordsState createState() => _DutyRecordsState();
}

class _DutyRecordsState extends State<DutyRecords> {
    int a=1;List getDuty;
    DutyRecordsList demo=DutyRecordsList();
    TextEditingController titleController=TextEditingController();
    TextEditingController contentController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
       backgroundColor: Color(0xFF011627),
      extendBodyBehindAppBar: false,
      appBar: new AppBar(automaticallyImplyLeading: false,title:topRow(context),elevation: 0,backgroundColor: Color(0xFF011627),),
          body: Stack(children: [
              Positioned(top:0,child: 
             Container(height: screenHeight,width: screenWidth,decoration: BoxDecoration(color: Color(0xFF011627),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40),)),
            child: dutyRecordsBody()),),
  
              Align(alignment: Alignment.bottomCenter,child: footer1(
                context:context,
                w1: ()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>Profile(),transitionDuration: Duration(seconds: 0))),
                w2: ()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>Tower(),transitionDuration: Duration(seconds: 0))),
                w3: ()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>ChatScreen(),transitionDuration: Duration(seconds: 0))),
                w4: ()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>SaveScreen(),transitionDuration: Duration(seconds: 0))),
               
              )),

              Positioned(bottom:15,left:100,right:100,child: footer2(
                context: context,
                w:()=> Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder:(_,__,___)=>Search1(),transitionDuration: Duration(seconds: 0))),
               
              )),
            ],
          ),
    );
}

  Widget dutyRecordsBody() {
    var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
     final HttpLink httpLink=HttpLink(uri: "https://servicemanag.herokuapp.com",);
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(link: httpLink,cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject,),),);
    return GraphQLProvider(      
      client: client,
      child:Scaffold(
        // floatingActionButton:  Padding(
        //                 padding: const EdgeInsets.only(right: 20,bottom: 150),
        //                 child: Align(alignment: Alignment.bottomRight,
        //                   child: FloatingActionButton(backgroundColor: Colors.white,
        //                     onPressed: onadd,
        //                   child:Icon(Icons.add_box,size: 40,color: Color(0xFF9A1518),),)),
        //               ),
         backgroundColor: Color(0xFF011627),
        body: Container(
          height: screenHeight,width: screenWidth,
          decoration: BoxDecoration(color: Color(0XFFFdFFFC),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40),)),
          child: Column(
            children: [
               Padding(padding: const EdgeInsets.all(15),child: head("duty records"),),
              Expanded(
                              child: Query(options:QueryOptions(
                    document: r"""
                      query GetAllDutyRecordByUser($_id:ID!){
                        GetAllDutyRecordByUser(_id:$_id){
                          _id
                          user
                          setno
                         duty_date
                         recordtype
                         recordtext
                        }
                      }""",
                   variables:<String,dynamic>{"_id":"${widget.uid}"}),
                  builder:(  QueryResult result, {Refetch refetch,FetchMore fetchMore,}) {

                        if(result.loading)return Center(child: CircularProgressIndicator());

                        

                        getDuty=result.data["GetAllDutyRecordByUser"];


                        return  Column( children: [
                     
                    
                      Expanded(
                        child: ListView.builder(
                          itemCount: getDuty.length,
                          // children:[dutySection("Editable Records",editable_records,),
                          // dutySection("Important Records",important_records,),
                          // dutySection("Unusual Records",unusual_records,),],
                          itemBuilder: (context,i){
                            var datename=DateTime.parse("${getDuty[i]["duty_date"]}").toLocal();
                            return Column(
     children: [
       Container(height: 150,
                 padding: EdgeInsets.all(10),
                 color:Colors.red[100],
                 child: Column(children: [
                   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                        Column(
                          children: [
                             AutoSizeText("DATES",style:TextStyle(fontSize: 15,color: Colors.blueGrey,fontFamily: "Norwester", )),
                           
                            AutoSizeText(datename.year.toString()+"-"+datename.month.toString()+"-"+datename.day.toString(),style:TextStyle(fontSize: 15,color: Colors.blueGrey,fontFamily: "Norwester", )),
                          ],
                        ),
                      Column(
                        children: [
                             AutoSizeText("SET NO",style:TextStyle(fontSize: 15,color: Colors.blueGrey,fontFamily: "Norwester", )),
                         
                          AutoSizeText("${getDuty[i]["setno"]}",style:TextStyle(fontSize: 15,color: Colors.blueGrey,fontFamily: "Norwester", )),
                        ],
                      ),
                          SizedBox(height: 5,),
                           Column(
                             children: [
                            AutoSizeText("TYPE",style:TextStyle(fontSize: 15,color: Colors.blueGrey,fontFamily: "Norwester", )),

                               AutoSizeText("${getDuty[i]["recordtype"]}",style:TextStyle(fontSize: 15,color: Colors.blueGrey,fontFamily: "Norwester", )),
                             ],
                           ),
                      ],),
                      SizedBox(height:5),
                      new Container(height: 80,
                        width: double.infinity,color:Colors.grey[100].withOpacity(0.42),padding: EdgeInsets.only(left:10,right:10),
                        child:AutoSizeText(getDuty[i]["recordtext"],style:TextStyle(fontSize: 11,color: Colors.blueGrey))
                        ),
                        //SizedBox(height:5),
                         
                       
                      ],),
       ),
       Container(color: Colors.white,height: 1,width: double.infinity,)
     ],
   );
                          },
                        ),),
                       


                    ],
                   
    );
                  }
                ),
              ),
              SizedBox(height:140)
            ],
            
          ),
        ),
  ),);
  }

   Widget dutySection(String a,List<DutyRecordsList> _list,){
     int len=_list.length;
    return ExpansionTile(childrenPadding: EdgeInsets.only(left:10,right: 10),
        title: Text(a,style: TextStyle(color: Color(0XFF002C5B),fontFamily: "Roboto2",fontSize: 16,fontWeight: FontWeight.w800,)), 
        subtitle: Text(' ($len)',style: TextStyle(fontSize: 12,fontFamily: "Roboto2",color: Colors.red,fontWeight: FontWeight.w800)),
   children:  _list.map((e) => Column(
     children: [
       Container(
         padding: EdgeInsets.all(10),
         color:Colors.red[100],
         child: Column(children: [
           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
                Align(alignment: Alignment.topLeft,
                  child: AutoSizeText(e.title,style:TextStyle(fontSize: 15,color: Colors.blueGrey,fontFamily: "Norwester", ))),
              Align(alignment: Alignment.topRight,
                  child: AutoSizeText("SET NO : ${e.setno}",style:TextStyle(fontSize: 15,color: Colors.blueGrey,fontFamily: "Norwester", ))),
                  SizedBox(height: 5,), ],),
              new Container(width: double.infinity,color:Colors.grey[100].withOpacity(0.42),padding: EdgeInsets.only(left:10,right:10),
                child:AutoSizeText(e.content,style:TextStyle(fontSize: 11,color: Colors.blueGrey))
                ),
                //SizedBox(height:5),
                 
               
              ],),
       ),
       Container(color: Colors.white,height: 1,width: double.infinity,)
     ],
   )).toList());
  }
onadd() {  
   showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        contentPadding: EdgeInsets.all(5),
        title:Center(child: Text('    Add Duty records    '.toUpperCase(),
          style: const TextStyle(color: Colors.white,fontSize: 17,fontFamily: "Norwester",backgroundColor: Color(0xFF011627),),)),
        content: Choose(),
      )
    );
}


}