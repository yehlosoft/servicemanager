import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:getflutter/components/search_bar/gf_search_bar.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:train_service/pages/chat_screen.dart';
import 'package:train_service/pages/profile.dart';
import 'package:train_service/pages/livelocation.dart';
import 'package:train_service/pages/save.dart';
import 'package:train_service/pages/searchresult.dart';
import 'package:train_service/widgets/bottomNavBar.dart';
import 'package:train_service/widgets/widgets.dart';
import 'package:train_service/widgets/addtoroaster.dart';
import 'addDuty.dart';

class RoasterF extends StatefulWidget {
  final String uid;
  const RoasterF({this.uid});

  @override
  _RoasterFState createState() => _RoasterFState();
}

class _RoasterFState extends State<RoasterF> {
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
                getUserRoasterslist(_id:$_id){
                  _id
                  user
                  setno
                  start_station_code
                  end_station_code
                  sign_on
                  sign_off
                  duty_hrs
                  distance
                  ndh
                  actual_sign_off
                  actual_sign_on
                  actual_duty_hrs
                  duty_date
                }
              }""", variables: <String, dynamic>{"_id": "${widget.uid}"}),
            builder: (
              QueryResult result, {
              Refetch refetch,
              FetchMore fetchMore,
            }) {
              if (result.loading)
                return Center(child: CircularProgressIndicator());

              getR = result.data["getUserRoasterslist"];

              return Roaster(getR: getR, uid: widget.uid);
            }),
      ),
    );
  }
}

class Roaster extends StatefulWidget {
  final List getR;
  final String uid;
  const Roaster({Key key, this.getR, this.uid}) : super(key: key);
  @override
  _RoasterState createState() => _RoasterState();
}

class _RoasterState extends State<Roaster> {
  String sidate, searchLabel = "SEARCH ROASTER";
  int option = 1;
  List getSetforRoaster, trainListR;
  String v, vv;
  String az,
      stime = "",
      etime = "",
      dhrs = "",
      kms = "",
      nDH = "",
      scode = "",
      ecode = "";
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.indigo.withAlpha(50),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
                height: screenHeight, width: screenWidth, child: roasterBody()),
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

  Widget roasterBody() {
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
                child: head("Roaster"),
              ),
              setSearch(),
              Expanded(
                  child: ListView.builder(
                itemCount: widget.getR.length,
                itemBuilder: (context, i) {
                  var a = DateTime.parse("${widget.getR[i]["duty_date"]}")
                      .toLocal();
                  return GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  backgroundColor: Colors.white,
                                  contentPadding: EdgeInsets.all(5),
                                  content: Container(
                                      height: 400,
                                      width: screenWidth,
                                      child: Copy(rid: widget.getR[i]["_id"])),
                                  title: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Color(0xFF011627),
                                      ),
                                      alignment: Alignment.center,
                                      height: 30,
                                      width: 180,
                                      child: Text(
                                        '    Roaster Details    '.toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontFamily: "Roboto",
                                        ),
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    FlatButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text("Close"))
                                  ],
                                ));
                      },
                      child: DateTime(a.year, a.month, a.day)
                                  .compareTo(DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day,
                              )) ==
                              0
                          ? Column(
                              children: [
                                roasterlist(
                                    "   ongoing   ",
                                    widget.getR[i]["setno"],
                                    widget.getR[i]["actual_sign_on"],
                                    widget.getR[i]["actual_sign_off"],
                                    widget.getR[i]["user"],
                                    widget.getR[i]["_id"],
                                    a,
                                    Colors.green[800]),
                                Container(
                                  height: 1.5,
                                  width: double.infinity,
                                  color: Color(0XFF8080C5).withOpacity(0.19),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: GestureDetector(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => AddDuty(
                                                  did: widget.uid,
                                                  drid: widget.getR[i]
                                                      ["_id"]))),
                                      child: Text(" Add to Duty Records  ",
                                          style: TextStyle(
                                              backgroundColor:
                                                  Colors.red[100]))),
                                ),
                                SizedBox(height: 5)
                              ],
                            )
                          : (DateTime(a.year, a.month, a.day)
                                      .compareTo(DateTime.now()) ==
                                  1
                              ? Column(
                                  children: [
                                    roasterlist(
                                        " upcoming ",
                                        widget.getR[i]["setno"],
                                        widget.getR[i]["actual_sign_on"],
                                        widget.getR[i]["actual_sign_off"],
                                        widget.getR[i]["user"],
                                        widget.getR[i]["_id"],
                                        a,
                                        Colors.red[900]),
                                    Container(
                                      height: 1.5,
                                      width: double.infinity,
                                      color:
                                          Color(0XFF8080C5).withOpacity(0.19),
                                    ),
                                    SizedBox(height: 10)
                                  ],
                                )
                              : Column(
                                  children: [
                                    roasterlist(
                                        "completed",
                                        widget.getR[i]["setno"],
                                        widget.getR[i]["actual_sign_on"],
                                        widget.getR[i]["actual_sign_off"],
                                        widget.getR[i]["user"],
                                        widget.getR[i]["_id"],
                                        a,
                                        Color(0XFF47525E)),
                                    Container(
                                      height: 1.5,
                                      width: double.infinity,
                                      color:
                                          Color(0XFF8080C5).withOpacity(0.19),
                                    ),
                                    SizedBox(height: 5)
                                  ],
                                )));
                },
              )),
              SizedBox(height: 80),
            ],
          )),
    );
  }

  Widget roasterlist(String label, setname, signon, signoff, userid, roasterid,
      DateTime datename, Color zz) {
    var abc = signon.split(".");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.only(top: 10.0),
          color: Color(0xfff4f5f9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Status : ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  color: Colors.red.withOpacity(0.42),
                ),
                alignment: Alignment.center,
                height: 25,
                width: 100,
                child: GestureDetector(
                  onTap: () {
                    print(zz);
                  },
                  child: Text(
                    "   $label  ".toUpperCase(),
                    style: TextStyle(
                      color: zz,
                      fontSize: 18,
                      fontFamily: "Norwester",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 70,
          color: Color(0XFFf4f5f9).withOpacity(0.6),
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    tl("SET", setname),
                    tl(
                        "DATE",
                        datename.year.toString() +
                            "-" +
                            datename.month.toString() +
                            "-" +
                            datename.day.toString())
                  ],
                ),
              ),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      tl("SIGN ON", signon),
                      tl("SIGN OFF", signoff),
                    ],
                  ),
                  SizedBox(width: 5),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Icon(Icons.edit, size: 15),
                        ),
                        onTap: () {
                          var snh, snm, sfh, sfm;
                          showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  confirmText: "Add Sign On")
                              .then((value1) {
                            snh = value1.hour;
                            snm = value1.minute;
                            showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                    confirmText: "Add Sign Off")
                                .then((value2) {
                              sfh = value2.hour;
                              sfm = value2.minute;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Mut1(
                                          snh: snh,
                                          snm: snm,
                                          sfh: sfh,
                                          uID: userid,
                                          sfm: sfm,
                                          id: roasterid)));
                            });
                          });
                        },
                      ),
                      SizedBox(height: 5)
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget setSearch() {
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
      child: Query(
          // ignore: deprecated_member_use
          options: QueryOptions(
            document: r"""
            query getS{
              getAllSets{
                _id
                setno
                start_station_code
                end_station_code
                sign_on
                sign_off
                duty_hrs
                distance
                ndh
              }
            }""",
          ),
          builder: (
            QueryResult result, {
            Refetch refetch,
            FetchMore fetchMore,
          }) {
            if (result.loading) return roasterSearch([]);
            if (result.hasException) return Center(child: Text("Exc"));
            getSetforRoaster = result.data["getAllSets"];
            return roasterSearch(getSetforRoaster);
          }),
    );
  }

  Widget roasterSearch(List xz) {
    var screenWidth = MediaQuery.of(context).size.width;
    return GFSearchBar(
      searchBoxInputDecoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: const Color(0xFF9A1518),
              ),
              borderRadius: BorderRadius.all(Radius.circular(50))),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: const Color(0xFF9A1518),
              ),
              borderRadius: BorderRadius.all(Radius.circular(50))),
          contentPadding: EdgeInsets.only(left: 25),
          focusColor: Color(0xFF9A1518).withOpacity(0.44),
          labelText: searchLabel,
          labelStyle: TextStyle(
              color: Color(0XFF011627),
              fontFamily: "Roboto",
              fontSize: 13,
              fontWeight: FontWeight.bold),
          hintText: "Enter Set No To search Your Roaster",
          hintStyle: TextStyle(
              color: Color(0XFF011627), fontFamily: "Roboto", fontSize: 11),
          fillColor: Colors.white.withOpacity(0.44),
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(
                  color: const Color(0xFF9A1518), style: BorderStyle.solid)),
          suffixIcon: Icon(
            Icons.search,
            color: Color(0XFFBFF95F62),
            size: 30,
          ),
          border: new OutlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.none,
              ),
              borderRadius: BorderRadius.all(Radius.circular(50)))),
      searchList: xz,
      searchQueryBuilder: (query, xz) {
        return xz
            .where((item) =>
                item["setno"].toUpperCase().contains(query.toUpperCase()))
            .toList();
      },
      overlaySearchListItemBuilder: (item) {
        return new Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Color(0XFF011627).withOpacity(0.1)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    text: TextSpan(
                        text: "Set: ",
                        style: TextStyle(
                          color: Color(0XFF47525E),
                          fontFamily: "Norwester",
                          fontSize: 13,
                        ),
                        children: <TextSpan>[
                      TextSpan(
                        text: item["setno"],
                        style: TextStyle(
                            color: Color(0XFF47525E),
                            fontFamily: "Roboto",
                            fontSize: 13),
                      ),
                    ])),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: "Departure  : ",
                            style: TextStyle(
                                color: Color(0XFF47525E),
                                fontFamily: "Norwester",
                                fontSize: 12),
                            children: <TextSpan>[
                          TextSpan(
                            text: item["start_station_code"],
                            style: TextStyle(
                                color: Color(0XFFF95F62),
                                fontWeight: FontWeight.w900,
                                fontFamily: "Roboto",
                                fontSize: 13),
                          ),
                        ])),
                    RichText(
                        text: TextSpan(
                            text: "Destination: ",
                            style: TextStyle(
                                color: Color(0XFF47525E),
                                fontFamily: "Norwester",
                                fontSize: 12),
                            children: <TextSpan>[
                          TextSpan(
                            text: item["end_station_code"],
                            style: TextStyle(
                                color: Color(0XFFF95F62),
                                fontWeight: FontWeight.w900,
                                fontFamily: "Roboto",
                                fontSize: 13),
                          ),
                        ])),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      onItemSelected: (item) {
        setState(() {
          az = item["setno"];
          // azbool=false;
          dhrs = item["duty_hrs"];
          stime = item["sign_on"];
          etime = item["sign_off"];
          kms = item["distance"];
          nDH = item["ndh"];
          ecode = item["start_station_code"];
          scode = item["end_station_code"];
        });
        v = item["setno"];
        Navigator.push(context, MaterialPageRoute(builder: (_) => adr()));
      },
    );
  }

  Widget adr() {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color(0xFF011627),
        extendBodyBehindAppBar: false,
        appBar: new AppBar(
          automaticallyImplyLeading: false,
          title: Row(children: [
            GestureDetector(
              child: Icon(Icons.arrow_back),
              onTap: () => Navigator.pop(context),
            ),
            topRow(context)
          ]),
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
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: head("Search Result"),
                  ),
                  Container(
                    height: 500,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0XFF505FE1).withOpacity(0.23),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        frow(),
                        trainset(),
                        raisedButtons(v, widget.uid),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget trainset() {
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
      child: Query(
          // ignore: deprecated_member_use
          options: QueryOptions(document: r"""
            query getS($details:String!){
              getTrainsbySetno(details:$details){
                _id
                setno
                train_no
                start_station_code
                end_station_code
                start_on
                change_on
                halts_at
                train_type
              }
            }""", variables: <String, dynamic>{"details": "$az"}),
          builder: (
            QueryResult result, {
            Refetch refetch,
            FetchMore fetchMore,
          }) {
            // if(result.data=="")return Text("a");
            if (result.loading) return srow([]);
            trainListR = result.data["getTrainsbySetno"];
            //  stime=item["sign_on"];
            //           etime=item["sign_off"];
            //           dhrs=item["duty_hrs"];kms=item["distance"];nDH=item["ndh"];
            //           scode=item["start_station_code"];
            //           ecode=item["end_station_code"];

            return srow(trainListR);
          }),
    );
  }

  srow(List<dynamic> zz) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Container(
          height: 250,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0XFFFDFFFC).withOpacity(0.6),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Container(
                    width: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'train no'.toUpperCase(),
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color(0XFF47525E),
                              fontSize: 12,
                              fontFamily: "Roboto2",
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: zz.length,
                              itemBuilder: (context, i) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(zz[i]["train_type"],
                                            style: TextStyle(
                                              color: Color(0XFF9A1518),
                                              fontFamily: "Roboto",
                                              fontSize: 11,
                                            )),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          zz[i]["train_no"],
                                          style: TextStyle(
                                            color: Color(0XFF47525E),
                                            fontFamily: "Roboto",
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 3),
                Dash(
                  direction: Axis.vertical,
                  dashColor: Color(0XFF505FE1),
                  length: 240,
                ),
                SizedBox(width: 3),
                Container(
                  width: 55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Start'.toUpperCase(),
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color(0XFF47525E),
                            fontSize: 12,
                            fontFamily: "Roboto2",
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: zz.length,
                              itemBuilder: (context, i) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          zz[i]["start_station_code"]
                                              .toUpperCase(),
                                          style: TextStyle(
                                              color: Color(0XFFF95F62),
                                              fontFamily: "Roboto",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11),
                                        ),
                                        Text(
                                          zz[i]["start_on"].toUpperCase(),
                                          style: TextStyle(
                                              color: Color(0XFF47525E),
                                              fontFamily: "Roboto",
                                              fontSize: 11),
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                  ],
                                );
                              }))
                    ],
                  ),
                ),
                Dash(
                  direction: Axis.vertical,
                  dashColor: Color(0XFF505FE1),
                  length: 240,
                ),
                Container(
                  width: 75,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'change'.toUpperCase(),
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color(0XFF47525E),
                            fontSize: 12,
                            fontFamily: "Roboto2",
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: zz.length,
                              itemBuilder: (context, i) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          zz[i]["end_station_code"],
                                          style: TextStyle(
                                              color: Color(0XFFF95F62),
                                              fontFamily: "Roboto",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 11),
                                        ),
                                        Text(
                                          zz[i]["change_on"],
                                          style: TextStyle(
                                              color: Color(0XFF47525E),
                                              fontFamily: "Roboto",
                                              fontSize: 11),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }))
                    ],
                  ),
                ),
                SizedBox(width: 2),
                Dash(
                  direction: Axis.vertical,
                  dashColor: Color(0XFF505FE1),
                  length: 240,
                ),
                Spacer(),
              ],
            ),
          )),
    );
  }

  Widget raisedButtons(String az, uid) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FlatButton(
              color: Color(0xFF8FB339),
              minWidth: 160,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.add, size: 20, color: Color(0XFFFDFFFC)),
                  SizedBox(width: 3),
                  Text('Add To Roaster',
                      style: const TextStyle(
                          color: Color(0XFFFDFFFC), fontSize: 11)),
                ],
              ),
              onPressed: () {
                _showCalender(az, uid);
              }),
          FlatButton(
            color: Color(0xFFF95F62),
            minWidth: 160,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('images/notibell.png', height: 20),
                SizedBox(width: 3),
                Text('SET REMAINDER',
                    style: const TextStyle(
                        color: Color(0XFFFDFFFC), fontSize: 11)),
              ],
            ),
            onPressed: () {
              //  showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now()).then((value){
              //   int a=value.year;
              //   int b=value.month;
              //   int c=value.day;
              //   showTimePicker(context: context, initialTime: TimeOfDay.now()).then((value) {
              //     int d=value.hour;
              //     int e=value.minute;
              //     scheduleNotification(a, b, c, d, e,"Set No"+az,"Set"+az+"will start after 10 minutes");
              //   });

              // });
            },
          ),
        ],
      ),
    );
  }

  _showCalender(String az, uid) {
    showDialog(
        context: context,
        builder: (context) => Container(
              height: 500,
              width: double.infinity,
              child: AlertDialog(
                backgroundColor: Colors.white,
                contentPadding: EdgeInsets.all(5),
                content: RunM1(az: az, uid: uid),
                title: Center(
                    child: Text(
                  '    Calender    ',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontFamily: "Norwester",
                    backgroundColor: Color(0xFF011627),
                  ),
                )),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text("Close"))
                ],
              ),
            ));
  }

  frow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 1, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              height: 60,
              width: 0.75 * (MediaQuery.of(context).size.width),
              decoration: BoxDecoration(
                color: Color(0XFFFDFFFC).withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sign on'.toUpperCase(),
                            style: TextStyle(
                                color: Color(0XFF47525E),
                                fontFamily: "Roboto",
                                fontSize: 11,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            stime,
                            style: TextStyle(
                                color: Color(0XFF47525E),
                                fontFamily: "Roboto",
                                fontSize: 11),
                          ),
                          Text(
                            scode.toUpperCase(),
                            style: TextStyle(
                                color: Color(0XFFF95F62),
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 5),
                    Dash(
                      direction: Axis.vertical,
                      dashColor: Color(0XFF505FE1),
                      length: 50,
                    ),
                    SizedBox(width: 4),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign off'.toUpperCase(),
                          style: TextStyle(
                              color: Color(0XFF47525E),
                              fontFamily: "Roboto",
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          etime,
                          style: TextStyle(
                              color: Color(0XFF47525E),
                              fontFamily: "Roboto",
                              fontSize: 11),
                        ),
                        Text(
                          ecode.toUpperCase(),
                          style: TextStyle(
                              color: Color(0XFFF95F62),
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(width: 5),
                    Dash(
                      direction: Axis.vertical,
                      dashColor: Color(0XFF505FE1),
                      length: 50,
                    ),
                    SizedBox(width: 4),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'duty hrs'.toUpperCase(),
                          style: TextStyle(
                              color: Color(0XFF47525E),
                              fontFamily: "Roboto",
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          dhrs,
                          style: TextStyle(
                              color: Color(0XFF47525E),
                              fontFamily: "Roboto",
                              fontSize: 11),
                        ),
                      ],
                    ),
                    SizedBox(width: 5),
                    Dash(
                      direction: Axis.vertical,
                      dashColor: Color(0XFF505FE1),
                      length: 50,
                    ),
                    SizedBox(width: 4),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'kms'.toUpperCase(),
                          style: TextStyle(
                              color: Color(0XFF47525E),
                              fontFamily: "Roboto",
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          kms.toUpperCase(),
                          style: TextStyle(
                              color: Color(0XFF47525E),
                              fontFamily: "Roboto",
                              fontSize: 11),
                        ),
                      ],
                    ),
                    SizedBox(width: 5),
                    Dash(
                      direction: Axis.vertical,
                      dashColor: Color(0XFF505FE1),
                      length: 50,
                    ),
                    SizedBox(width: 4),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ndh'.toUpperCase(),
                          style: TextStyle(
                              color: Color(0XFF47525E),
                              fontFamily: "Roboto",
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          nDH.toUpperCase(),
                          style: TextStyle(
                              color: Color(0XFF47525E),
                              fontFamily: "Roboto",
                              fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
          SizedBox(height: 5),
          Container(
            width: 70,
            height: 45,
            decoration: BoxDecoration(
              color: Color(0XFFFDFFFC).withOpacity(0.6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                az,
                style: TextStyle(
                    color: Color(0XFF47525E),
                    fontFamily: "Roboto",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget tl(String a, b) {
    return RichText(
        text: TextSpan(
            text: a + ": ",
            style: TextStyle(
              color: Color(0XFF47525E),
              fontFamily: "Norwester",
              fontSize: 13,
            ),
            children: <TextSpan>[
          TextSpan(
            text: b,
            style: TextStyle(
                color: Color(0XFF47525E),
                fontFamily: "Roboto",
                fontSize: 13,
                fontWeight: FontWeight.w800),
          )
        ]));
  }
}

class Mut1 extends StatefulWidget {
  final int snh, snm, sfh, sfm;
  final String id, uID;

  const Mut1(
      {Key key, this.id, this.snh, this.snm, this.sfh, this.sfm, this.uID})
      : super(key: key);
  @override
  _Mut1State createState() => _Mut1State();
}

class _Mut1State extends State<Mut1> {
  int a, b;
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
        body: Mutation(
          options: MutationOptions(
            document: r"""
            mutation UpdateRoaster($_id:ID!,$actual_sign_on:String!,$actual_sign_off:String!){
              UpdateRoaster(roasterInput:{_id:$_id,actual_sign_on:$actual_sign_on,actual_sign_off:$actual_sign_off}){
               
                actual_sign_on
                actual_sign_off
                
                
              }
            }""",
          ),
          builder: (RunMutation insert, QueryResult result) {
            return Container(
                child: AlertDialog(
              title: Text("Confirmation".toUpperCase()),
              content: Text("Are you sure want to update?"),
              actions: [
                FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel")),
                FlatButton(
                    onPressed: () {
                      insert(<String, dynamic>{
                        "_id": widget.id,
                        "actual_sign_on": "${widget.snh}:${widget.snm}",
                        "actual_sign_off": "${widget.sfh}:${widget.sfm}"
                      });
                      print(34);
                      print("${widget.id}");
                      print("${widget.snh}:${widget.snm}");
                      print("${widget.sfh}:${widget.sfm}");

                      Navigator.pop(context);
                    },
                    child: Text("Confirm"))
              ],
            ));
          },
        ),
      ),
    );
  }
}

class Copy extends StatefulWidget {
  final String rid;

  const Copy({Key key, this.rid}) : super(key: key);
  @override
  _CopyState createState() => _CopyState();
}

class _CopyState extends State<Copy> {
  List zz;
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
      child: Query(
          options: QueryOptions(document: r"""
            query getid($_id:ID!){
              getUserRoasterDetails(_id:$_id){
                _id
                duty_date
                setno                
                sign_on
                actual_sign_on
                sign_off
                actual_sign_off
                duty_hrs
                actual_duty_hrs
                distance
                ndh
                start_station_code
                end_station_code
                Roasterdetails{
                  roaster
                  train_type
                  route_code
                  start_on
                  change_on
                  actual_start_on
                  actual_change_on
                  halts_at
                  train_no
                  start_station_code
                  end_station_code

                }
              }
            }""", variables: <String, dynamic>{"_id": "${widget.rid}"}),
          builder: (
            QueryResult result, {
            Refetch refetch,
            FetchMore fetchMore,
          }) {
            if (result.loading) return Text("");

            zz = result.data["getUserRoasterDetails"]["Roasterdetails"];

            return Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0XFF505FE1).withOpacity(0.23),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                        height: 60,
                        width: 0.75 * (MediaQuery.of(context).size.width),
                        decoration: BoxDecoration(
                          color: Color(0XFFFDFFFC).withOpacity(0.6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: frowlist(
                                    "sign on",
                                    result.data["getUserRoasterDetails"]
                                        ["actual_sign_on"],
                                    result.data["getUserRoasterDetails"]
                                        ["start_station_code"]),
                              ),
                              SizedBox(width: 5),
                              Dash(
                                direction: Axis.vertical,
                                dashColor: Color(0XFF505FE1),
                                length: 50,
                              ),
                              SizedBox(width: 4),
                              frowlist(
                                  "sign off",
                                  result.data["getUserRoasterDetails"]
                                      ["actual_sign_off"],
                                  result.data["getUserRoasterDetails"]
                                      ["end_station_code"]),
                              SizedBox(width: 5),
                              Dash(
                                direction: Axis.vertical,
                                dashColor: Color(0XFF505FE1),
                                length: 50,
                              ),
                              SizedBox(width: 4),
                              frowlist(
                                  "duty hrs",
                                  result.data["getUserRoasterDetails"]
                                      ["actual_duty_hrs"],
                                  ""),
                              SizedBox(width: 5),
                              Dash(
                                direction: Axis.vertical,
                                dashColor: Color(0XFF505FE1),
                                length: 50,
                              ),
                              SizedBox(width: 4),
                              frowlist(
                                  "kms",
                                  result.data["getUserRoasterDetails"]
                                      ["distance"],
                                  ""),
                              SizedBox(width: 5),
                              Dash(
                                direction: Axis.vertical,
                                dashColor: Color(0XFF505FE1),
                                length: 50,
                              ),
                              SizedBox(width: 4),
                              frowlist(
                                  "ndh",
                                  result.data["getUserRoasterDetails"]["ndh"],
                                  ""),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 70,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Color(0XFFFDFFFC).withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          result.data["getUserRoasterDetails"]["setno"],
                          style: TextStyle(
                              color: Color(0XFF47525E),
                              fontFamily: "Roboto",
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(0XFFFDFFFC).withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Container(
                                  width: 80,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'train no'.toUpperCase(),
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: Color(0XFF47525E),
                                            fontSize: 12,
                                            fontFamily: "Roboto2",
                                            fontWeight: FontWeight.w800),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                            itemCount: zz.length,
                                            itemBuilder: (context, i) {
                                              return Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(zz[i]["train_type"],
                                                          style: TextStyle(
                                                            color: Color(
                                                                0XFF9A1518),
                                                            fontFamily:
                                                                "Roboto",
                                                            fontSize: 11,
                                                          )),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text(
                                                        zz[i]["train_no"],
                                                        style: TextStyle(
                                                          color:
                                                              Color(0XFF47525E),
                                                          fontFamily: "Roboto",
                                                          fontSize: 11,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                ],
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 3),
                              Dash(
                                direction: Axis.vertical,
                                dashColor: Color(0XFF505FE1),
                                length: 240,
                              ),
                              SizedBox(width: 3),
                              Container(
                                width: 55,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Start'.toUpperCase(),
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Color(0XFF47525E),
                                          fontSize: 12,
                                          fontFamily: "Roboto2",
                                          fontWeight: FontWeight.w800),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Expanded(
                                        child: ListView.builder(
                                            itemCount: zz.length,
                                            itemBuilder: (context, i) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        zz[i]["start_station_code"]
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                            color: Color(
                                                                0XFFF95F62),
                                                            fontFamily:
                                                                "Roboto",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 11),
                                                      ),
                                                      Text(
                                                        zz[i]["actual_start_on"]
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                            color: Color(
                                                                0XFF47525E),
                                                            fontFamily:
                                                                "Roboto",
                                                            fontSize: 11),
                                                      ),
                                                      SizedBox(height: 5),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            }))
                                  ],
                                ),
                              ),
                              Dash(
                                direction: Axis.vertical,
                                dashColor: Color(0XFF505FE1),
                                length: 240,
                              ),
                              Container(
                                width: 75,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'change'.toUpperCase(),
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Color(0XFF47525E),
                                          fontSize: 12,
                                          fontFamily: "Roboto2",
                                          fontWeight: FontWeight.w800),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Expanded(
                                        child: ListView.builder(
                                            itemCount: zz.length,
                                            itemBuilder: (context, i) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        zz[i][
                                                            "end_station_code"],
                                                        style: TextStyle(
                                                            color: Color(
                                                                0XFFF95F62),
                                                            fontFamily:
                                                                "Roboto",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 11),
                                                      ),
                                                      Text(
                                                        zz[i]["change_on"],
                                                        style: TextStyle(
                                                            color: Color(
                                                                0XFF47525E),
                                                            fontFamily:
                                                                "Roboto",
                                                            fontSize: 11),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              );
                                            }))
                                  ],
                                ),
                              ),
                              SizedBox(width: 2),
                              Dash(
                                direction: Axis.vertical,
                                dashColor: Color(0XFF505FE1),
                                length: 240,
                              ),
                              Spacer(),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget frowlist(String a, b, c) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          a.toUpperCase(),
          style: TextStyle(
              color: Color(0XFF47525E),
              fontFamily: "Roboto",
              fontSize: 11,
              fontWeight: FontWeight.bold),
        ),
        Text(
          b,
          style: TextStyle(
              color: Color(0XFF47525E), fontFamily: "Roboto", fontSize: 11),
        ),
        Text(
          c.toUpperCase(),
          style: TextStyle(
              color: Color(0XFFF95F62),
              fontFamily: "Roboto",
              fontWeight: FontWeight.bold,
              fontSize: 12),
        ),
      ],
    );
  }
}
