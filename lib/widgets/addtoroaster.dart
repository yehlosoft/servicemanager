// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:train_service/models/roaster_list.dart';


class RunM1 extends StatefulWidget {
   final String az,uid;
 

  const RunM1({ this.az, this.uid}) ;
  @override
  _RunM1State createState() => _RunM1State();
}

class _RunM1State extends State<RunM1> {
   CalendarController _controller;
   String a;DateTime cs; String mz;

  RoasterListM listR=RoasterListM();
  @override
  void initState() {
    _controller=CalendarController();
    super.initState();

  }
  

  @override
  Widget build(BuildContext context) {
   
    var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    final HttpLink httpLink=HttpLink(uri: "https://servicemanag.herokuapp.com",);
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(link: httpLink,cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject,),),);
    return GraphQLProvider(
      
      client: client,
      child: Mutation(
        options:MutationOptions(
          document: r"""
            mutation AddtoRoaster($user:ID!,$setno:String!,$duty_date:String!){
              AddtoRoaster(roasterInput:{user:$user,setno:$setno,duty_date:$duty_date}){
                _id
                user
                duty_date
                setno
              }
            }""",),
        builder:(  RunMutation insert,QueryResult result) {
          return Container(
            height: 0.45*screenHeight,
            width: 0.9*screenWidth,
            child: SingleChildScrollView(
                  child: Column(children: [
              TableCalendar(
                startingDayOfWeek: StartingDayOfWeek.sunday,
                headerStyle: HeaderStyle(centerHeaderTitle: true,titleTextStyle: TextStyle(fontSize: 12,fontFamily: "Roboto2"),
                    formatButtonDecoration: BoxDecoration(color: Colors.purple,borderRadius: BorderRadius.all(Radius.circular(50))),
                    formatButtonTextStyle: TextStyle(color:Colors.white) ),
                initialCalendarFormat: CalendarFormat.month,
                initialSelectedDay: DateTime.now(),
                calendarStyle: CalendarStyle(
                  todayColor: Colors.blueGrey,
                  highlightToday: true,
                  selectedColor: Colors.blue,
                  selectedStyle: TextStyle(color: Colors.white,fontSize: 14),
                  
                  todayStyle: TextStyle(fontFamily: "Roboto",fontSize: 14),),
                onDaySelected: (date,events,event) {
    
                  setState(() {
                   // _selectedEvent=events;
                   
                    a=widget.az;
                    cs=DateTime(date.year,date.month,date.day);
                    //listR.ce=DateTime(date.year,date.month,date.day,widget.en.hour,widget.en.minute);
                    // listR.start=widget.st;
                    // listR.end=widget.en;
                    mz="${date.year.toString()}-${date.month.toString()}-${date.day.toString()}";
                  });
                },
                calendarController: _controller,),
                
        Align(
            alignment: Alignment.topRight,
            child: FloatingActionButton(backgroundColor: Colors.red[100],
              child: Icon(Icons.add,color: Colors.red,),
              onPressed: () {
                 insert(<String,dynamic>{
                  "user": widget.uid,
                  "setno": widget.az,
                  "duty_date": "${cs.year.toString()}-${cs.month.toString()}-${cs.day.toString()}",
                  
                  });
                  print(34);
                  print("${widget.uid}");
                  print("${a}");
                  print("$mz");
                  print("${cs.year.toString()}-${cs.month.toString()}-${cs.day.toString()}");
                 Navigator.pop(context);
                  Navigator.pop(context); Navigator.pop(context);
              },
            ),),
  ],),),);}),);
  }
}
