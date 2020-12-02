import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';

class PdffullPageViewer extends StatelessWidget {
  final String path, filename;

  const PdffullPageViewer({Key key, this.path, this.filename});

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(backgroundColor: Color(0xFF011627),
        title: Text("$filename",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Norwester")),
      ),
      path: path,
    );
  }
}
