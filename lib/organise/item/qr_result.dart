import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart' as emojiPicker;
import 'package:flutter/rendering.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:screenshot/screenshot.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'main.dart';

class QrResultState extends State<QrResult> {
  String containerName;

  ScreenshotController screenshotController = ScreenshotController();

  QrResultState({
    required this.containerName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generowanie kodu"),
        backgroundColor: Colors.grey[900],
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 40, left: 10, right: 10, bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10),
              child: Text(
                containerName,
                textAlign: TextAlign.left,
              ),
            ),
            Screenshot(
              controller: screenshotController,
              child: PrettyQr(
                data: containerName,
                typeNumber: 3,
                size: 320,
                errorCorrectLevel: QrErrorCorrectLevel.M,
                roundEdges: true,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              spreadRadius: -1,
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ]),
                      child: OutlinedButton(
                        onPressed: () async {
                          final doc = pw.Document();
                          final screenshot =
                              await screenshotController.capture();
                          final image = pw.MemoryImage(screenshot!);

                          doc.addPage(pw.Page(build: (pw.Context context) {
                            return pw.Center(child: pw.Image(image)); // Center
                          })); // Page
                          Printing.layoutPdf(
                              onLayout: (PdfPageFormat format) async =>
                                  doc.save());
                        },
                        child: const Text("Drukuj",
                            style: TextStyle(color: Colors.black)),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0))),
                        ),
                      )),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            spreadRadius: -1,
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]),
                    child: OutlinedButton(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Dodaj kolejny przedmiot",
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.center),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const OrganiseItemPage()));
                      },
                      //shape: RoundedRectangleBorder(
                      //    borderRadius: BorderRadius.circular(10)),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class QrResult extends StatefulWidget {
  final String containerName;

  const QrResult({Key? key, required this.containerName}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  QrResultState createState() => QrResultState(
        containerName: containerName,
      );
}
