import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/models/transaction_data.dart';
import 'package:flutter_catalog/utils/pdf_util.dart';


class PrintPage extends StatelessWidget {
  const PrintPage({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    List<TransactionData> _data = [
      TransactionData(
        200,
        212
      ),
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
                onPressed: () => PDFHelper.generatePdf(_data, 22222, DateTime.now().toString(), '23434', '34343434'),
              ),
              MaterialButton(
                child: Text('print'),
                onPressed: () {
                  Navigator.pushNamed(context,'/pdf_view');
                },
              ),
            ],
          )
        ),
      ),
    );
  }


}
