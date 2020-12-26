import 'package:flutter/material.dart';

footer1({context,Function w1,Function w2,Function w3,Function w4}){
  var screenWidth=MediaQuery.of(context).size.width;
  return Container(height: 60,color: Color(0xFF9A1518),
      child: Row(crossAxisAlignment: CrossAxisAlignment.end,mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
        Column(mainAxisAlignment: MainAxisAlignment.center,children: [GestureDetector(onTap:w1,child: Container(width:0.2*screenWidth,
              child: _unselectedImage("images/acc.png",30),),)],),

        Column(mainAxisAlignment: MainAxisAlignment.center,children: [GestureDetector(onTap: w2,child: Container(width:0.2*screenWidth,
              child: _unselectedImage("images/tower.png",30),),)],),

        Column(mainAxisAlignment: MainAxisAlignment.center,children: [Container(width:0.2*screenWidth,)],),

        Column(mainAxisAlignment: MainAxisAlignment.center,children: [GestureDetector(onTap: w3,child: Container(width:0.2*screenWidth,
              child: _unselectedImage("images/comment.png",30),),)],),

        Column(mainAxisAlignment: MainAxisAlignment.center,children: [GestureDetector(onTap: w4,child: Container(width:0.2*screenWidth,
              child: _unselectedImage("images/save.png",30),),)],),
  

      ],),);
}

footer2({context,Function w}) {
  var screenWidth=MediaQuery.of(context).size.width;
  return GestureDetector(onTap:w,
      child: Container(width:0.2*screenWidth,
        child: CircleAvatar(radius: 45,backgroundColor: Colors.white,
        child: CircleAvatar(backgroundColor: Color(0XFF9D9C98).withOpacity(0.17),radius: 35,
            child: _selectedImage("images/search.png"))),),
  );
}


Widget  _selectedImage(String a) {
    return Image.asset(a,height: 40,color: Color(0XFF8080C5),);
}

Widget _unselectedImage(String a,double b) {
  return Image.asset(a,height: b,color:Color(0XFFFDFFFC),);
}
