import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:train_service/pages/chat_screen.dart';
import 'package:train_service/pages/profile.dart';
import 'package:train_service/pages/livelocation.dart';
import 'package:train_service/pages/save.dart';
import 'package:train_service/pages/searchresult.dart';
import 'package:train_service/widgets/bottomNavBar.dart';
import 'package:train_service/widgets/widgets.dart';

class WorkHistory extends StatefulWidget {
  @override
  _WorkHistoryState createState() => _WorkHistoryState();
}

class _WorkHistoryState extends State<WorkHistory> {
  int _value = 1;

  List items = [0, 0, 0, 0];
  @override
  Widget build(BuildContext context) {
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
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
                height: screenHeight,
                width: screenWidth,
                decoration: BoxDecoration(
                    color: Color(0xFF011627),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
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
                        pageBuilder: (_, __, ___) => Search1(),
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
      body: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(
              color: Color(0XFFFdFFFC),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              )),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: head("work history"),
                ),
                DropdownButton(
                  hint: Text("Choose"),
                  value: _value,
                  items: [
                    DropdownMenuItem(
                      child: Text("1st"),
                      value: 1,
                      onTap: () {
                        setState(() {
                          items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
                        });
                      },
                    ),
                    DropdownMenuItem(
                      child: Text("2nd"),
                      value: 2,
                      onTap: () {
                        setState(() {
                          items = [6, 7, 8, 9, 10];
                        });
                      },
                    ),
                    DropdownMenuItem(
                      child: Text("3rd"),
                      value: 3,
                      onTap: () {
                        setState(() {
                          items = [11, 12, 13, 14, 15];
                        });
                      },
                    ),
                    DropdownMenuItem(
                      child: Text("4th"),
                      value: 4,
                      onTap: () {
                        setState(() {
                          items = [16, 26, 36, 45, 45];
                        });
                      },
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.red[100],
                            ),
                            height: 150,
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: AutoSizeText("DATES",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.blueGrey,
                                                fontFamily: "Norwester",
                                              )),
                                        ),
                                        AutoSizeText(
                                            "   " + items[i].toString(),
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.blueGrey,
                                              fontFamily: "Norwester",
                                            )),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        AutoSizeText("SET NO",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.blueGrey,
                                              fontFamily: "Norwester",
                                            )),
                                        AutoSizeText(items[i].toString(),
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.blueGrey,
                                              fontFamily: "Norwester",
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Column(
                                        children: [
                                          AutoSizeText("TYPE",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.blueGrey,
                                                fontFamily: "Norwester",
                                              )),
                                          AutoSizeText(items[i].toString(),
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.blueGrey,
                                                fontFamily: "Norwester",
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                new Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey[100].withOpacity(0.42),
                                  ),
                                  width: double.infinity,
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: AutoSizeText(
                                      "    " + items[i].toString(),
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.blueGrey),
                                    ),
                                  ),
                                ),
                                //SizedBox(height:5),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            height: 1,
                            width: double.infinity,
                          )
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 130)
              ],
            ),
          )),
    );
  }
}
