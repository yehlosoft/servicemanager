// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:table_calendar/table_calendar.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class RunM1 extends StatefulWidget {
  final String az, uid, scheduleTime;

  const RunM1({this.az, this.uid, this.scheduleTime});
  @override
  _RunM1State createState() => _RunM1State();
}

class _RunM1State extends State<RunM1> {
  CalendarController _controller;
  String a;
  DateTime cs;
  String mz;
  DateTime alarmTime;

  @override
  void initState() {
    _controller = CalendarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    final HttpLink httpLink = HttpLink(
      uri: "https://servicemanag.herokuapp.com",
    );
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: httpLink,
        cache: OptimisticCache(
          dataIdFromObject: typenameDataIdFromObject,
        ),
      ),
    );
    return GraphQLProvider(
      client: client,
      child: Mutation(
          options: MutationOptions(
            document: r"""
            mutation AddtoRoaster($user:ID!,$setno:String!,$duty_date:String!){
              AddtoRoaster(roasterInput:{user:$user,setno:$setno,duty_date:$duty_date}){
                _id
                user
                duty_date
                setno
              }
            }""",
          ),
          builder: (RunMutation insert, QueryResult result) {
            return Container(
              height: 0.45 * screenHeight,
              width: 0.9 * screenWidth,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TableCalendar(
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      headerStyle: HeaderStyle(
                          centerHeaderTitle: true,
                          titleTextStyle:
                              TextStyle(fontSize: 12, fontFamily: "Roboto2"),
                          formatButtonDecoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          formatButtonTextStyle:
                              TextStyle(color: Colors.white)),
                      initialCalendarFormat: CalendarFormat.month,
                      initialSelectedDay: DateTime.now(),
                      calendarStyle: CalendarStyle(
                        todayColor: Colors.blueGrey,
                        highlightToday: true,
                        selectedColor: Colors.blue,
                        selectedStyle:
                            TextStyle(color: Colors.white, fontSize: 14),
                        todayStyle:
                            TextStyle(fontFamily: "Roboto", fontSize: 14),
                      ),
                      onDaySelected: (date, events, event) {
                        setState(() {
                          a = widget.az;
                          cs = DateTime(date.year, date.month, date.day);
                          mz =
                              "${date.year.toString()}-${date.month.toString()}-${date.day.toString()}";
                          int y = int.parse(mz.substring(0, 4));
                          int m = int.parse(mz.substring(5, 7));
                          int d = int.parse(mz.substring(8, 10));
                          int hr =
                              int.parse(widget.scheduleTime.substring(0, 2));
                          int min = int.parse(widget.scheduleTime.substring(3));
                          int sec = 00;
                          alarmTime = DateTime(y, m, d, hr, min, sec);
                          // alarmTime = DateTime(2020, 12, 11, 11, 13, 00);
                          print(alarmTime);
                        });
                      },
                      calendarController: _controller,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: FloatingActionButton(
                        backgroundColor: Colors.red[100],
                        child: Icon(
                          Icons.add,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          insert(<String, dynamic>{
                            "user": widget.uid,
                            "setno": widget.az,
                            "duty_date":
                                "${cs.year.toString()}-${cs.month.toString()}-${cs.day.toString()}",
                          });
                          scheduleAlarm(alarmTime);
                          _onLoading();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  void scheduleAlarm(alartime) async {
    var initializeSettingsAndroid =
        AndroidInitializationSettings("ic_launcher");
    var initializeSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String title, String body, String payload) async {});
    var initializeSettings = InitializationSettings(
        android: initializeSettingsAndroid, iOS: initializeSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializeSettings,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        debugPrint('notification payload:' + payload);
      }
    });
    var scheduleNotificationDateTime = alartime;
    print("Alarm scheduled at: $scheduleNotificationDateTime");
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notification',
      'alarm_notify',
      'channel ID',
      icon: 'ic_launcher',
      sound: RawResourceAndroidNotificationSound('ringtone'),
      largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
    );

    var iosPlatformChannelSpecifics = IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
        0,
        "${widget.az}",
        "Hurry up, 30 minutes left for above set no",
        scheduleNotificationDateTime,
        platformChannelSpecifics);
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: new Row(
              children: [
                new Text("Adding to roaster"),
                SizedBox(
                  width: 25,
                ),
                new CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
    new Future.delayed(new Duration(seconds: 3), () {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context); //pop dialog\
    });
  }
}
