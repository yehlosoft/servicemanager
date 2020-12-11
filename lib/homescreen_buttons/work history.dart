import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:train_service/pages/chat_screen.dart';
import 'package:train_service/pages/profile.dart';
import 'package:train_service/pages/livelocation.dart';
import 'package:train_service/pages/downloads.dart';
import 'package:train_service/pages/searchresult.dart';
import 'package:train_service/widgets/bottomNavBar.dart';
import 'package:train_service/widgets/widgets.dart';

class WorkHistory extends StatefulWidget {
  final String uid;
  const WorkHistory({this.uid});
  @override
  _WorkHistoryState createState() => _WorkHistoryState();
}

class _WorkHistoryState extends State<WorkHistory> {
  List<dynamic> getR;

  @override
  Widget build(BuildContext context) {
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
      child: Scaffold(
        body: Query(
            options: QueryOptions(document: r"""
            query getR($_id:ID!){
                workHistory(_id:$_id){
                  _id
                  user
                  duty_date
                  setno
                  actual_sign_on
                  actual_sign_off
                }
            }""", variables: <String, dynamic>{"_id": "${widget.uid}"}),
            builder: (
              QueryResult result, {
              Refetch refetch,
              FetchMore fetchMore,
            }) {
              if (result.hasException)
                return Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.wifi_off,
                        ),
                        Text("no internet")
                      ]),
                );

              // ignore: dead_code
              if (result.loading)
                return Center(child: CircularProgressIndicator());

              getR = result.data["workHistory"];

              return History(getR: getR, uid: widget.uid);
            }),
      ),
    );
  }
}

class History extends StatefulWidget {
  final List getR;
  final String uid;

  const History({Key key, this.getR, this.uid}) : super(key: key);
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
                height: screenHeight,
                width: screenWidth,
                child: workHistoryBody()),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: footer1(
                context: context,
                w1: () => Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => Profile(),
                        transitionDuration: Duration(seconds: 0))),
                w2: () => Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => Tower(),
                        transitionDuration: Duration(seconds: 0))),
                w3: () => Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => ChatScreen(),
                        transitionDuration: Duration(seconds: 0))),
                w4: () => Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => SaveScreen(),
                        transitionDuration: Duration(seconds: 0))),
              )),
          Positioned(
              bottom: 15,
              left: 100,
              right: 100,
              child: footer2(
                context: context,
                w: () => Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => Search1(uid: widget.uid),
                        transitionDuration: Duration(seconds: 0))),
              )),
        ],
      ),
    );
  }

  Widget workHistoryBody() {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF011627),
      extendBodyBehindAppBar: false,
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        title: topRow(context),
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: head("Work history"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: screenWidth * 0.4,
                      height: screenHeight * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        color: Color(0xfff4f5f9),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      size: 30,
                    ),
                    Container(
                      width: screenWidth * 0.4,
                      height: screenHeight * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                        color: Color(0xfff4f5f9),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.getR.length,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      Container(
                        color: Color(0xfff4f5f9),
                        height: 100,
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Duty date: ",
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 15,
                                        fontFamily: "Norwester",
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Text(
                                    widget.getR[i]["duty_date"],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Set no: ",
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 15,
                                        fontFamily: "Norwester",
                                      ),
                                    ),
                                    Text(widget.getR[i]["setno"])
                                  ],
                                ),
                                Text(
                                  "|",
                                  style: TextStyle(
                                      fontSize: 28, color: Colors.grey),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Signin time: ",
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 15,
                                        fontFamily: "Norwester",
                                      ),
                                    ),
                                    Text(widget.getR[i]["actual_sign_on"]),
                                  ],
                                ),
                                Text(
                                  "|",
                                  style: TextStyle(
                                      fontSize: 28, color: Colors.grey),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Sign off time: ",
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 15,
                                        fontFamily: "Norwester",
                                      ),
                                    ),
                                    Text(widget.getR[i]["actual_sign_off"]),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        height: 2,
                        width: double.infinity,
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Future<Null> _refresh_work_history() async {
  Future.delayed(Duration(seconds: 2));
  return null;
}
