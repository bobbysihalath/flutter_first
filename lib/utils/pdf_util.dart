import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;


class PDFHelper {
  static DateFormat formater = DateFormat('dd-MM-yyyy hh:mm');
  static final today = new DateTime.now();
  static final nextSevenDay = today.add(const Duration(days: 7));
  static final formatNum = NumberFormat("#,###");

  static Future<void> generatePdf(List<TransactionData> trx, int ism,
      String date, String billNum, String member) async {
    final font = await rootBundle.load("assets/front/NotoSans-Regular.ttf");
    final ttf = pw.Font.ttf(font);
    var customdate = date.substring(0, 10);
    var year = customdate.substring(0, 4);
    var month =
        customdate.substring(customdate.length - 5, customdate.length - 3);
    var day = customdate.substring(customdate.length - 2, customdate.length);
    print('date: ' + day + ' month: ' + month + ' year: ' + year);
    final newDate = day + '-' + month + '-' + year;
    print('newDate: ' + newDate);
    final fontNumber = await rootBundle.load("assets/front/NotoSans-Regular.ttf");
    final ttfNumber = pw.Font.ttf(fontNumber);
    var total = 0;
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.undefined,
        build: (context) {
          return pw.Column(children: [
            pw.Center(
              child: pw.Column(
                children: [
                  txtLaosValue(ttf, 'ກະຊວງການເງິນ', 26.0, false),
                  txtLaosValue(
                      ttf, 'ບໍລິສັດ ລັດວິສາຫະກິດ ຫວຍພັດທະນາ', 26.0, false),
                  txtLaosValue(ttf, 'ຕົວແທນນະຄອນຫລວງເລກ 4', 26.0, false),
                  txtLaosValue(ttf, 'ນະຄອນປາກເຊ', 26.0, false),
                  txtLaosValue(
                      ttf, 'ງວດທີ: $ism | ອອກວັນທີ: $newDate', 20.0, false),
                  txtLaosValue(
                      ttf,
                      'ເລກບິນ: ${billNum.substring(billNum.length - 4, billNum.length)}',
                      26.0,
                      false),
                  txtLaosValue(ttf, '__________________________', 26.0, false),
                  txtLaosValue(
                      ttf, 'ເລກ     ຈຳນວນ     ເລກ     ຈຳນວນ', 26.0, false),
                  txtLaosValue(ttf, '__________________________', 26.0, false),
                ],
              ),
            ),
            pw.Container(
              width: 350,
              alignment: pw.Alignment.topLeft,
              child: pw.Column(
                // mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: List.generate(trx.length, (i) {
                  //Calculate total amount
                  total += trx[i].sale;
                  return pw.Center(
                      child: pw.Row(children: [
                    //Column1
                    if (i % 2 == 0)
                      txtEnglish(
                          '[${trx[i].lek}]=', PdfColors.black, ttfNumber),
                    if (i % 2 == 0)
                      txtEnglish(
                          formatNum.format(trx[i].sale).toString() + ' | ',
                          PdfColors.black,
                          ttfNumber),
                    //Column2
                    if (i % 2 == 0 && i + 1 < trx.length)
                      txtEnglish(
                          '[${trx[i + 1].lek}]=', PdfColors.black, ttfNumber),
                    if (i % 2 == 0 && i + 1 < trx.length)
                      txtEnglish(formatNum.format(trx[i + 1].sale).toString(),
                          PdfColors.black, ttfNumber),
                    //Invisible
                    if (i == trx.length - 1 && i % 2 == 0)
                      txtEnglish('----', PdfColors.white, ttfNumber),
                    if (i == trx.length - 1 && i % 2 == 0)
                      txtEnglish('----', PdfColors.white, ttfNumber),
                  ]));
                }),
              ),
            ),
            pw.Center(
              child: pw.Column(children: [
                txtLaosValue(ttf, '__________________________', 26.0, false),
                txtLaosValue(
                    ttf,
                    'ລວມເງິນທັງໝົດ: ${formatNum.format(total)} ກີບ',
                    26.0,
                    false),
                txtLaosValue(ttf, 'ຜູ້ຂາຍ: ' + member, 26.0, false),
                txtLaosValue(
                    ttf, 'ເວລາພິມ: ${formater.format(today)}', 23.0, false),
                txtLaosValue(ttf, 'ເບີໂທຕິດຕໍ່: 020 9558 8945', 26.0, false),
                txtLaosValue(
                    ttf,
                    'ໝົດກຳນົດຮັບລາງວັນ: ${formater.format(nextSevenDay).substring(0, 10)}',
                    26.0,
                    false),
                txtLaosValue(ttf, 'ຂໍໃຫ້ທ່ານໂຊກດີ:', 26.0, false),
              ]),
            ),
          ]);
        },
      ),
    );
    await savePDF(pdf);
  }

  static savePDF(pdf) async {
    try {
      final dir = await getExternalStorageDirectory();
      final file = File('${dir.path}/receipt.pdf');
      await file.writeAsBytes(await pdf.save());
      print('file save');
    } catch (e) {
      print('error: ' + e.toString());
    }
  }

  static pw.Text txtLaosValue(pw.Font ttf, text, size, bool blod) {
    return pw.Text(
      text,
      style: pw.TextStyle(
        font: ttf,
        fontSize: size,
        fontWeight: blod ? pw.FontWeight.bold : pw.FontWeight.normal,
      ),
    );
  }

  static pw.Text txtEnglish(data, color, pw.Font ttf) {
    return pw.Text(
      data.toString(),
      style: pw.TextStyle(
        fontSize: 28,
        color: color,
        font: ttf,
        fontWeight: pw.FontWeight.bold,
      ),
    );
  }
}

class TransactionData {
  int sale;
  int lek;
}
