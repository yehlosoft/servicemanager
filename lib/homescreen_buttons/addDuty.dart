
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:multi_media_picker/multi_media_picker.dart';
import 'package:train_service/widgets/widgets.dart';

class AddDuty extends StatefulWidget {
  final String did, drid;

  const AddDuty({this.did, this.drid});
  @override
  _AddDutyState createState() => _AddDutyState();
}

class _AddDutyState extends State<AddDuty> {
  bool selectSingleImage = false;
  String rec = "Editable Records";String hintlabel=" Choose Records ";
  int option = 1;
  List<File> _images ;
  int length;

  HttpLink httpLink = HttpLink(
    uri: "https://servicemanag.herokuapp.com",
  );

  TextEditingController contentController = TextEditingController();

  Future getImage() async {
    var images = await MultiMediaPicker.pickImages(source: ImageSource.gallery);
    setState(() {
      _images = images;
      length = _images.length;
      print("List of images : $_images, Length : $length");
    });
  }

  Widget buildImageList() {
    return ListView.builder(
        itemCount: _images.length,
        itemBuilder: (BuildContext context, int i) {
          return Text("hello");
        });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(link: httpLink,cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject,),),);
    return GraphQLProvider(
      client: client,
      child: Scaffold(
       backgroundColor: Color(0xFF011627),extendBodyBehindAppBar: false,
        appBar: new AppBar(automaticallyImplyLeading: false,
          title: Row(children: [
            GestureDetector(child: Icon(Icons.arrow_back),onTap: () => Navigator.pop(context),),
            topRow(context)]),
          elevation: 0,backgroundColor: Color(0xFF011627),),
        body: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: BoxDecoration(color: Color(0XFFFdFFFC),borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40),)),
          child: Mutation(
            options: MutationOptions(
              document: r"""
                mutation AddDutyRecord($user:ID!,$roaster:ID!,$recordtype:String!,$recordtext:String!){
                  AddDutyRecord(recordInput:{user:$user,roaster:$roaster,recordtype:$recordtype,recordtext:$recordtext}){
                    recordtype
                    recordtext
                  }
                }""",
            ),
            builder: (RunMutation insert, QueryResult result) {
              return SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                children: [
                  Padding(padding: const EdgeInsets.all(15),child: head("duty records"),),

                  _dropbut(),
                  
                  SizedBox(height: 25),

                  uploadImage(),

                  SizedBox(height: 25),

                  enterText(),
                  
                  SizedBox(height: 50),

                  but(() {
                      insert(<String, dynamic>{
                        "user": "${widget.did}",
                        "roaster": "${widget.drid}",
                        "recordtype": rec,
                        "recordtext": contentController.text,
                      });
                      Navigator.pop(context);
                    },),
                ],
              ));
            },
          ),
        ),
      ),
    );
  }
  Widget but(Function a){
     var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
                    onTap: a,
                    child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(screenWidth / 2),color: Color(0xFF8FB339),),
                      alignment: Alignment.center,
                      width: screenWidth * 0.4,
                      height: screenHeight * 0.05,
                      child: Text(
                        "Add To Duty Records",
                        style: TextStyle(
                          color: Color(0XFFFDFFFC),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
  }
  Widget enterText(){
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                    ),
                    width: screenWidth * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextField(
                        cursorColor: Colors.black,
                        controller: contentController,
                        decoration: InputDecoration(
                          hintText: "                       Enter duty record",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  );
  }
  Widget uploadImage(){
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 30.0, bottom: 15.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Upload the pictures",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: getImage,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[200],
                          ),
                          alignment: Alignment.center,
                          height: screenHeight * 0.4,
                          width: screenWidth * 0.85,
                          child: _images == null
                              ? Icon(
                                  Icons.add,
                                  size: 45,
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: _images.length,
                                  itemBuilder: (BuildContext context, int i) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: screenHeight * 0.35,
                                        width: screenWidth * 0.75,
                                        child: Image.file(_images[i],fit: BoxFit.fill,),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      ),
                    ],
                  );
  }
  Widget _dropbut(){
    var screenWidth = MediaQuery.of(context).size.width;

    return Padding(padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.grey[400].withAlpha(80),),
                      alignment: Alignment.center,
                      width: screenWidth * 0.4,
                      child: DropdownButton(
                          hint: Text(hintlabel),
                          underline: Container(
                            height: 2,
                            color: Colors.transparent,
                          ),
                          items: [
                            DropdownMenuItem(
                              child: Text(
                                "Editable Records",
                                style: const TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 11,
                                  color: Color(0XFF47525E),
                                  fontWeight: FontWeight.w900,
                                ),
                                maxLines: 2,
                              ),
                              value: 1,
                              onTap: () {
                                setState(() {
                                  rec = "EDITABLE";
                                });
                              },
                            ),
                            DropdownMenuItem(
                              child: Text(
                                "Important Records",
                                style: const TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 11,
                                  color: Color(0XFF47525E),
                                  fontWeight: FontWeight.w900,
                                ),
                                maxLines: 2,
                              ),
                              value: 1,
                              onTap: () {
                                setState(() {
                                  rec = "IMPORTANT";
                                });
                              },
                            ),
                            DropdownMenuItem(
                              child: Text(
                                "Unusual Records",
                                style: const TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 11,
                                  color: Color(0XFF47525E),
                                  fontWeight: FontWeight.w900,
                                ),
                                maxLines: 2,
                              ),
                              value: 1,
                              onTap: () {
                                setState(() {
                                  rec = "UNUSUAL";
                                  
                                });
                              },
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              option = value;
                              hintlabel=rec;
                            });
                          }),
                    ),
                  );
  }
}
