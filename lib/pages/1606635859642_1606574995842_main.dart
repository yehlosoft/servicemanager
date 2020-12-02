// import 'dart:io';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:flutter/material.dart';
// import 'package:pdf_viewer/PdfPageViewer.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart' as pw;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(title: 'PDF example'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   List<DateTime> days = [];
//   List<DateTime> getDaysInBeteween(DateTime startDate, DateTime endDate) {
//     days = [];
//     for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
//       days.add(DateTime(
//           startDate.year,
//           startDate.month,
//           // In Dart you can set more than. 30 days, DateTime will do the trick
//           startDate.day + i));
//     }
//     return days;
//   }

//   List<String> alldays = [];
//   List<String> allgetDaysInBeteween(List<DateTime> days) {
//     alldays = [];
//     for (int i = 0; i < days.length; i++) {
//       alldays.add(days[i].day.toString() +
//           "-" +
//           days[i].month.toString() +
//           "-" +
//           days[i].year.toString());
//     }
//     setState(() {
//       alldays = alldays;
//     });
//     return alldays;
//   }

//   // ignore: avoid_init_to_null
//   String fromDate = null;
//   // ignore: avoid_init_to_null
//   String toDate = null;
//   String filename;
//   DateTime from, to;
//   String username, sex, dob, age;
//   pw.Document doc = pw.Document(pageMode: PdfPageMode.outlines);

//   writeOnPDF(String first, String last, List<String> alldays) {
//     doc.addPage(
//       pw.MultiPage(
//         orientation: pw.PageOrientation.landscape,
//         pageFormat:
//             PdfPageFormat.a3.copyWith(marginBottom: 0.5 * PdfPageFormat.cm),
//         crossAxisAlignment: pw.CrossAxisAlignment.start,
//         footer: (pw.Context context) {
//           return pw.Container(
//               alignment: pw.Alignment.centerRight,
//               margin: const pw.EdgeInsets.only(top: 0.5 * PdfPageFormat.cm),
//               child: pw.Text(
//                   'Page ${context.pageNumber} of ${context.pagesCount}',
//                   style: pw.Theme.of(context)
//                       .defaultTextStyle
//                       .copyWith(color: PdfColors.grey)));
//         },
//         build: (pw.Context context) => <pw.Widget>[
//           pw.Row(
//               mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//               children: [
//                 pw.Container(
//                   child: pw.Paragraph(
//                     text: 'C. R. P. P/By/$first/$last/40.000 Forms',
//                   ),
//                 ),
//                 pw.Container(
//                   child: pw.Header(
//                     level: 0,
//                     text: 'Central Railway',
//                   ),
//                 ),
//                 pw.SizedBox(width: 70),
//                 pw.Container(
//                   child: pw.Paragraph(
//                     text: 'T. 46 F',
//                   ),
//                 ),
//               ]),
//           pw.Padding(padding: const pw.EdgeInsets.all(5)),
//           pw.Paragraph(
//               text:
//                   'Mr/Ms __________________________ Post _______________________ Employee serial no. __________________ By  _______________________ .'),
//           pw.Padding(padding: const pw.EdgeInsets.all(5)),
//           pw.Paragraph(
//               text:
//                   'Statement of work done and Kilometreage earned by ___________________ Rank _________________ Staff No _____________ for the month ending  __________ 20 Rate of Pay Rs________ Rate per 100 Kilometres Rs____________ .'),
//           pw.Padding(padding: const pw.EdgeInsets.all(10)),
//           pw.Container(
//             width: 1200,
//             alignment: pw.Alignment.topLeft,
//             padding: pw.EdgeInsets.all(0 * PdfPageFormat.cm),
//             child: pw.Table.fromTextArray(context: context, data: [
//               <String>[
//                 'From',
//                 'To',
//                 'Depart Date',
//                 'No. of trains',
//                 'Departure',
//                 'Arrival date',
//                 'Arrival Time',
//                 'Hours of duty',
//                 'At out station',
//                 'At home station',
//                 'No. of KM run',
//                 'Rate',
//                 'Amount',
//               ],
//               <String>[
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1',
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1',
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1'
//               ],
//               <String>[
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1',
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1',
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1'
//               ],
//               <String>[
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1',
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1',
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1'
//               ],
//               <String>[
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1',
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1',
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1'
//               ],
//               <String>[
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1',
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1',
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1'
//               ],
//               <String>[
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1',
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1',
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1'
//               ],
//               <String>[
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1',
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1',
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1'
//               ],
//               <String>[
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1',
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1',
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1'
//               ],
//               <String>[
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1',
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1',
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1'
//               ],
//               <String>[
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1',
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1',
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1'
//               ],
//               <String>[
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1',
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1',
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1'
//               ],
//               <String>[
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1',
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1',
//                 '1993',
//                 'PDF 1.0',
//                 'Acrobat 1'
//               ],
//             ]),
//           ),
//           pw.Padding(padding: const pw.EdgeInsets.all(10)),
//           pw.Paragraph(
//               text:
//                   'The entries in this statement have been compared with Duty Book and found correct.'),
//           pw.Padding(padding: const pw.EdgeInsets.all(25)),
//           pw.Paragraph(
//               text:
//                   '        Signature of Gaurd or Brakesman                                                                                      Examined and certified                                                                         (Enter full name and designation)'),
//           pw.Paragraph(
//               text:
//                   'When off duty, on leave or on medical certificate, this should be noted against th date. When off in the regular course of duty or the whole 24 hours (midnight to midnight) no entry should be made.'),
//           pw.Padding(padding: const pw.EdgeInsets.all(5)),
//           pw.Paragraph(
//               text:
//                   'When on relieving special or waiting duty or temporarily of their own districts, or working ballast trains, the number of hours or days as the case may be, must be shown as well as the equivalent in Kilometres.'),
//         ],
//       ),
//     );
//   }

//   Future savePdf() async {
//     var status = await Permission.storage.status;
//     if (!status.isGranted) {
//       await Permission.storage.request();
//     }
//     new Directory('/storage/emulated/0/Download/Service_manager').create()
//         // The created directory is returned as a Future.
//         .then((Directory directory) {
//       print(directory.path);
//     });
//     File file = File(
//         '/storage/emulated/0/Download/Service_manager/${from.day.toString()}-${from.month.toString()}-${from.month.toString()}---->${to.day.toString()}-${to.month.toString()}-${to.month.toString()}.pdf');
//     file.writeAsBytesSync(doc.save());

//     setState(() {
//       filename =
//           "/storage/emulated/0/Download/Service_manager/${from.day.toString()}-${from.month.toString()}-${from.month.toString()}---->${to.day.toString()}-${to.month.toString()}-${to.month.toString()}.pdf"
//               .substring(45);
//     });
//     print(filename);
//     print("Saved");
//   }

//   List<String> types = ["Mileage", "Overtime", "Night Duty Allowance (NDA)"];
//   String typeValue;

//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;
//     var screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Container(
//         height: screenHeight,
//         width: screenWidth,
//         decoration: BoxDecoration(
//           color: Color(0XFFFdFFFC),
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(40),
//             topRight: Radius.circular(40),
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: screenHeight * 0.165,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   print("from");
//                   showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime(2015),
//                     lastDate: DateTime(2101),
//                   ).then((date) {
//                     setState(() {
//                       String finalDate = date.day.toString() +
//                           "-" +
//                           date.month.toString() +
//                           "-" +
//                           date.year.toString();

//                       fromDate = finalDate;
//                       from = date;
//                     });
//                   });
//                 },
//                 child: Container(
//                   height: screenHeight * 0.05,
//                   width: screenWidth * 0.38,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(25),
//                     color: Colors.grey[300],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         fromDate == null
//                             ? Text(
//                                 "From date",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                 ),
//                               )
//                             : Text(
//                                 "$fromDate",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                         Icon(
//                           Icons.calendar_today,
//                           size: 20,
//                           color: Colors.grey[800],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: screenHeight * 0.01,
//               ),
//               Icon(
//                 Icons.arrow_downward,
//               ),
//               SizedBox(
//                 height: screenHeight * 0.01,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   print("to");
//                   showDatePicker(
//                     context: context,
//                     initialDate: DateTime.now(),
//                     firstDate: DateTime(2015),
//                     lastDate: DateTime(2101),
//                   ).then((date) {
//                     setState(() {
//                       String finalDate = date.day.toString() +
//                           "-" +
//                           date.month.toString() +
//                           "-" +
//                           date.year.toString();

//                       toDate = finalDate;
//                       to = date;
//                     });
//                   });
//                 },
//                 child: Container(
//                   height: screenHeight * 0.05,
//                   width: screenWidth * 0.38,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(25),
//                     color: Colors.grey[300],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 10.0, right: 10.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         toDate == null
//                             ? Text(
//                                 "To date",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                 ),
//                               )
//                             : Text(
//                                 "$toDate",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                         Icon(
//                           Icons.calendar_today,
//                           size: 20,
//                           color: Colors.grey[800],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: screenHeight * 0.02,
//               ),
//               Container(
//                 height: screenHeight * 0.05,
//                 width: screenWidth * 0.58,
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(25),
//                   color: Colors.grey[300],
//                 ),
//                 child: DropdownButton(
//                     value: typeValue,
//                     hint: Text('Choose Records'),
//                     underline: Container(
//                       height: 2,
//                       color: Colors.transparent,
//                     ),
//                     items: types.map((String value) {
//                       return DropdownMenuItem(
//                         value: value,
//                         child: Text(
//                           value,
//                         ),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         typeValue = value;
//                       });
//                     }),
//               ),
//               SizedBox(
//                 height: screenHeight * 0.08,
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           getDaysInBeteween(from, to);
//           allgetDaysInBeteween(days);
//           print(alldays);

//           // for (int i = 0; i < alldays.length; i++) {

//           String fullPath;
//           String firstdate;
//           String lastdate;
//           setState(() {
//             firstdate = from.day.toString() +
//                 "-" +
//                 from.month.toString() +
//                 "-" +
//                 from.year.toString();
//             lastdate = to.day.toString() +
//                 "-" +
//                 to.month.toString() +
//                 "-" +
//                 from.year.toString();
//             fullPath =
//                 '/storage/emulated/0/Download/Service_manager/${from.day.toString()}-${from.month.toString()}-${from.month.toString()}---->${to.day.toString()}-${to.month.toString()}-${to.month.toString()}.pdf';
//           });
//           writeOnPDF(firstdate, lastdate, alldays);
//           // }
//           await savePdf();
//           print("FULL_PATH : $fullPath");
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => PdffullPageViewer(
//                 path: fullPath,
//                 filename: filename,
//               ),
//             ),
//           );
//         },
//         tooltip: 'Increment',
//         child: Icon(Icons.picture_as_pdf),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
