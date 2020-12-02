import 'package:flutter/material.dart';
import 'package:train_service/models/videolibrary_list.dart';
import 'package:train_service/pages/chat_screen.dart';
import 'package:train_service/pages/profile.dart';
import 'package:train_service/pages/livelocation.dart';
import 'downloads.dart';
import 'package:train_service/pages/searchresult.dart';
import 'package:train_service/pages/webview.dart';
import 'package:train_service/widgets/bottomNavBar.dart';
import 'package:train_service/widgets/widgets.dart';

class VideoLibrary extends StatefulWidget {
  @override
  _VideoLibraryState createState() => _VideoLibraryState();
}

class _VideoLibraryState extends State<VideoLibrary> {
  @override
  Widget build(BuildContext context) {
    var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
          body: Stack(children: [
              Positioned(top:0,child: Container(height: screenHeight,width: screenWidth,child: videoLibraryBody()),),
  
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


  Widget videoLibraryBody() {
     var screenWidth=MediaQuery.of(context).size.width;
    var screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF011627),
      extendBodyBehindAppBar: false,
      appBar: new AppBar(automaticallyImplyLeading: false,title:topRow(context),elevation: 0,backgroundColor: Color(0xFF011627),),
      body: Container(height: screenHeight,width: screenWidth,decoration: BoxDecoration(color: Color(0XFFFdFFFC),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40),)),
            child: Column( children: [
              
              Padding(padding: const EdgeInsets.all(15),child: head("Video library"),),
              Expanded(
                child: ListView.builder(
                  itemCount: vlist.length,
                  itemBuilder: (BuildContext context,int i){
                    String abc=vlist[i].url;
                    return Column(
                      children: [
                    
                        GestureDetector(
                          onTap: ()=> Navigator.push(context, PageRouteBuilder(pageBuilder:(_,__,___)=>WebVBody(abc:abc),transitionDuration: Duration(seconds: 0))),

                                         
                                          child: ListTile(
                            tileColor: Colors.grey[300],
                            leading: Column(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.video_collection,size: 50,),
                              ],
                            ),
                            title: Text(vlist[i].name,style: TextStyle(color: Color(0XFF002C5B),fontSize: 14,fontFamily: "Roboto2",fontWeight: FontWeight.w900),),
                            subtitle: Text("asdfgh"),
                          ),
                        ),
                        SizedBox(height:1),
                      ],
                      
                    );
                  },
                  
                ),
                  )



            ],
            )
        
      ),
    );
  }
}