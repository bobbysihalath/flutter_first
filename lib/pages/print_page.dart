import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/utils/pdf_util.dart';
import 'package:flutter_catalog/widgets/print_preview.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart';

class PrintPage extends StatelessWidget {
  const PrintPage({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    List<TransactionData> _data = [
      TransactionData(
        200,
        200
      ),
      TransactionData(
          200,
          200
      ),
      TransactionData(
          200,
          200
      )
    ];
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              MaterialButton(
                child: Text('save to pdf'),
                onPressed: () => PDFHelper.testPDF(),
              ),
              MaterialButton(
                child: Text('print'),
                onPressed: () => PrintHelper.genImage(),
              ),
            ],
          )
        ),
      ),
    );
  }


}
