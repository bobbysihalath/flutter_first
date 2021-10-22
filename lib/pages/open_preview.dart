import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart' as nativePdf;
import 'package:path_provider/path_provider.dart';

class OpenPageView extends StatelessWidget {
  const OpenPageView({Key key}) : super(key: key);

  Future<nativePdf.PdfDocument> _getDocument() async {
    if (await nativePdf.hasSupport()) {
      final dir = await getExternalStorageDirectory();
      final document =
          await nativePdf.PdfDocument.openFile('${dir.path}/receipt.pdf');
      return document;
    }

    throw Exception(
      'PDF Rendering does not '
      'support on the system of this version',
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    final storage = Map<int, nativePdf.PdfPageImage>();

    return MaterialApp(
      title: 'PDF View example',
      color: Colors.white,
      home: Scaffold(
        body: FutureBuilder(
          future: _getDocument(),
          builder: (context, AsyncSnapshot<nativePdf.PdfDocument> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            return PageView(
              children: <Widget>[
                ImageLoader(
                  storage: storage,
                  document: snapshot.data,
                  pageNumber: 1,
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 2.0,
          color: Colors.green,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.print, color: Colors.white),
                SizedBox(width: 4),
                Text(
                  'ພິມໃບບິນ',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageLoader extends StatelessWidget {
  ImageLoader({
    Key key,
    this.storage,
    this.document,
    this.pageNumber,
  }) : super(key: key);

  final Map<int, nativePdf.PdfPageImage> storage;
  final nativePdf.PdfDocument document;
  final int pageNumber;
  static Uint8List imageBytes;


  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: _renderPage(),
        builder: (context, AsyncSnapshot<nativePdf.PdfPageImage> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error'),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Image(
            image: MemoryImage(snapshot.data.bytes),
          );
        },
      );

  Future<nativePdf.PdfPageImage> _renderPage() async {

    if (storage.containsKey(pageNumber)) {
      return storage[pageNumber];
    }
    final page = await document.getPage(pageNumber);
    final pageImage = await page.render(
      width: page.width * 2,
      height: page.height * 2,
      format: nativePdf.PdfPageFormat.PNG,
    );
    final bytes = pageImage.bytes;
    imageBytes = bytes;
    await page.close();
    return pageImage;
  }
}
