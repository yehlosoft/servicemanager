import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';

class PdffullPageViewer extends StatelessWidget {
  final String path, filename;

  const PdffullPageViewer({Key key, this.path, this.filename});

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(
        title: Text("$filename"),
      ),
      path: path,
    );
  }
}
