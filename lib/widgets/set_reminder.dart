import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class NotificationManager {
  var _flutterLocalNotificationsPlugin;
  NotificationManager() {
    _flutterLocalNotificationsPlugin=new FlutterLocalNotificationsPlugin();
    initNotification();
  }
  getNot() {
    return _flutterLocalNotificationsPlugin;
  }


  void initNotification() {
    
    var androidInitialize= new AndroidInitializationSettings('app_icon');
    var initializationSettings= new InitializationSettings(android:androidInitialize );
    _flutterLocalNotificationsPlugin=new FlutterLocalNotificationsPlugin();
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: notificationSelected);

  }


  void _showNotification(int id,String title,String body, int hour, int minute) async{
    var androidDetails= new AndroidNotificationDetails("id", "Train Service", "hello user",importance: Importance.max,ticker: "Service Manager");
    var generalNotoficationsDetails= new NotificationDetails(android:androidDetails );
    // var scheduledTime= DateTime.now().add(Duration(seconds: 4));
    // _flutterLocalNotificationsPlugin.schedule(1, "title", "body", scheduledTime, generalNotoficationsDetails);
    var time= new Time(hour,minute,0);
    await _flutterLocalNotificationsPlugin.schedule(id, title, body, time, generalNotoficationsDetails);



  }
  Future notificationSelected(String payload) async {
    print("clicked");
    return Future.value(0);

  }
  Future onDidReceiveNotification(int id,String title,String body,String payload) async {
    print("clicked");
    return Future.value(1);

  }
  void removeReminder(int notid) {
    _flutterLocalNotificationsPlugin.cancel(notid);
  } 

}

class SetReminder extends StatefulWidget {
  final NotificationManager manager;
  SetReminder({this.manager});
  @override
  _SetReminderState createState() => _SetReminderState();
}

class _SetReminderState extends State<SetReminder> {
  static final _formKey = new GlobalKey<FormState>();
  String _title;
  String _detail;
 
  @override
  void initState() {
    
    super.initState();
   
   
  }
 
  Map<String,dynamic> encodeMap(Map<DateTime,dynamic> map) {
    Map<String,dynamic> newMap ={};
    map.forEach((key, value) {
      newMap[key.toString()]=map[key];
    });
    return newMap;
  }

  Map<DateTime,dynamic> decodeMap(Map<String,dynamic> map) {
    Map<DateTime,dynamic> newMap ={};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)]=map[key];
    });
    return newMap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            _buildForm(),
            RaisedButton(
              child: Text("reminder"),
              onPressed: () {
                
                _submit(widget.manager);
                
              },
              
            ),
          ],
        ),
      ),
      
    );
  }
  Form _buildForm() {
    TextEditingController t1=TextEditingController();
    TextEditingController t2=TextEditingController();
    TextStyle labelsStyle =
        TextStyle(fontWeight: FontWeight.w400, fontSize: 25);
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: t1,
            style: TextStyle(fontSize: 25),
            decoration: InputDecoration(
              labelText: 'Title',
              labelStyle: labelsStyle,

            ),
            validator: (input) => (input.length < 1) ? 'Name is short' : null,
            onSaved: (input)=>_title=input,
            
          ),
          TextFormField(
            controller: t2,
            style: TextStyle(fontSize: 25),
            decoration: InputDecoration(
              labelText: 'Details',
              labelStyle: labelsStyle,
            ),
           validator: (input) => (input.length > 50) ? 'Dose is long' : null,
            onSaved: (input)=>_detail=input,
           
          )
        ],
      ),
    );
  }

  void _submit(NotificationManager manager) async {
        if (_formKey.currentState.validate()) {
      // form is validated
      _formKey.currentState.save();
      

    showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) async{
      int hour=value.hour;
      int minute=value.minute;
      manager._showNotification(1, _title, _detail, hour, minute);
     
            print('a');
           
            Navigator.pop(context);
    });
     
  }
  }
}
