import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:train_service/models/news_list.dart';
import 'package:train_service/pages/chat_screen.dart';
import 'package:train_service/pages/profile.dart';
import 'package:train_service/pages/livelocation.dart';
import 'package:train_service/pages/downloads.dart';
import 'package:train_service/pages/searchresult.dart';
import 'package:train_service/widgets/bottomNavBar.dart';
import 'package:train_service/widgets/widgets.dart';

class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
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
                height: screenHeight, width: screenWidth, child: NewsBody()),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: footer1(
                context: context,
                w1: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => Profile(),
                        transitionDuration: Duration(seconds: 0))),
                w2: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => Tower(),
                        transitionDuration: Duration(seconds: 0))),
                w3: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => ChatScreen(),
                        transitionDuration: Duration(seconds: 0))),
                w4: () => Navigator.push(
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
                w: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => Search1(),
                        transitionDuration: Duration(seconds: 0))),
              )),
        ],
      ),
    );
  }
}

class NewsBody extends StatefulWidget {
  @override
  _NewsBodyState createState() => _NewsBodyState();
}

class _NewsBodyState extends State<NewsBody> {
  @override
  Widget build(BuildContext context) {
    var dates = DateTime.now();
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
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: head("news"),
                ),
                Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: news_list.length,
                        itemBuilder: (BuildContext context, int i) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Container(
                                height: 0.5 * screenHeight,
                                width: 0.95 * screenWidth,
                                margin: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  // gradient: LinearGradient(colors: [Colors.white, Colors.red[200],],begin: Alignment.topLeft,end: Alignment.bottomRight),
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey[300],
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blue[100],
                                      blurRadius: 4.0,
                                      offset: Offset(2.0, 3.0),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 0.85 * screenWidth,
                                      height: 0.70 * screenHeight,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 10),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                "Date:" +
                                                    dates.year.toString() +
                                                    "/" +
                                                    dates.month.toString() +
                                                    "/" +
                                                    dates.day.toString(),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Center(
                                              child: Text(
                                                news_list[i].title,
                                                style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontSize: 30,
                                                  fontFamily: "Norwester",
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Container(
                                              alignment: Alignment.center,
                                              height: 100,
                                              width: double.infinity,
                                              child: Icon(
                                                Icons.image,
                                                size: 60,
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                "contents 1".toUpperCase(),
                                                style: TextStyle(
                                                  color: Colors.blueGrey,
                                                  fontSize: 20,
                                                  fontFamily: "Norwester",
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              width: 0.85 * screenWidth,
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.vertical,
                                                child: Column(
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "contents 2"
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          color:
                                                              Colors.blueGrey,
                                                          fontSize: 20,
                                                          fontFamily:
                                                              "Norwester",
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15.0),
                                                      child: AutoSizeText(
                                                        news_list[i].content,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontFamily: "Roboto",
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              width: 0.85 * screenWidth,
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "contents 3"
                                                          .toUpperCase(),
                                                      style: TextStyle(
                                                        color: Colors.blueGrey,
                                                        fontSize: 20,
                                                        fontFamily: "Norwester",
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15.0),
                                                    child: Text(
                                                      news_list[i].content,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          );
                        }))
              ],
            ),
          )),
    );
  }
}
