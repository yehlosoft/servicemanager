import 'package:flutter/material.dart';
import 'package:train_service/models/duty_records_list.dart';

class Choose extends StatefulWidget {
  @override
  _ChooseState createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {
  int a=1;
   DutyRecordsList demo=DutyRecordsList();
    TextEditingController titleController=TextEditingController();
     TextEditingController setController=TextEditingController();
     
    TextEditingController contentController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var screenHeight=MediaQuery.of(context).size.height;
    return Container(height:  0.45*screenHeight,
      child: Column(
        children: [
          Row(children: [
              Radio(value: 1, groupValue: a, activeColor:  Color(0XFFF95F62),onChanged: (T){setState(() {a=T;});}),
              Text("Editable Records",
             style: const TextStyle(fontFamily: "Roboto",fontSize: 11,color: Color(0XFF47525E),fontWeight: FontWeight.w900,),maxLines: 2,),],),
          Row(children: [
              Radio(value: 2, groupValue: a, activeColor:  Color(0XFFF95F62),onChanged: (T){setState(() {a=T;});}),
              Text("Important Records",
             style: const TextStyle(fontFamily: "Roboto",fontSize: 11,color: Color(0XFF47525E),fontWeight: FontWeight.w900,),maxLines: 2,),],),
          Row(children: [
              Radio(value: 3, groupValue: a, activeColor:  Color(0XFFF95F62),onChanged: (T){setState(() {a=T;});}),
              Text("Unusual Records",
             style: const TextStyle(fontFamily: "Roboto",fontSize: 11,color: Color(0XFF47525E),fontWeight: FontWeight.w900,),maxLines: 2,),],),
          SizedBox(height:15),
          TextField(controller: setController,decoration: InputDecoration(hintText: "   Enter Set No"),),
          SizedBox(height:10),
          TextField(controller: titleController,decoration: InputDecoration(hintText: "   Enter Title",),keyboardType: TextInputType.phone,),
          SizedBox(height:10),
          TextField(controller: contentController,decoration: InputDecoration(hintText: "   Enter Content"),),
          SizedBox(height:50),
          Align(alignment: Alignment.bottomRight,
            child: FlatButton(
              color: Color(0xFF011627),
              onPressed: (){            
                setState(() {
                  demo.title=titleController.text;
                  demo.content=contentController.text;    
                  demo.setno=setController.text;       
                if(a==1){
                  editable_records.insert(0,demo);}
                else if(a==2){
                  important_records.add(demo);} 
                else{
                  unusual_records.add(demo);}   
              });
              Navigator.pop(context);
              titleController.text="";
              setController.text="";
              contentController.text="";},
               child: Text("Add",style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: "Roboto",fontWeight: FontWeight.bold),)),
          )
        ],),
       
          
        
      );
    
}

}