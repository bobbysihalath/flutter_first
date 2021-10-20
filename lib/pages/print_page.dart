import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/utils/pdf_util.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';

class PrintPage extends StatelessWidget {
  const PrintPage({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('text')
      ),
    );
  }
}
