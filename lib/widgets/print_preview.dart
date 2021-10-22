import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart' as nativePdf;

class PrintHelper {
  static Uint8List imageBytes;

  static genImage() async {
    // List<TransactionData> list=[];
    // await PDFHelper.generatePdf(list);
    final dir = await getExternalStorageDirectory();
    final document =
    await nativePdf.PdfDocument.openFile('${dir.path}/receipt.pdf');
    final page = await document.getPage(1);
    final pageImage = await page.render(
      width: page.width,
      height: page.height,
      format: nativePdf.PdfPageFormat.PNG,
    );
    final bytes = pageImage.bytes;
    imageBytes = bytes;
    await page.close();
  }
}
