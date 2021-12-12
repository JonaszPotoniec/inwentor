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
import 'package:uuid/uuid.dart';
import '../../database/model/item.dart';
import '../../database/model/item_barcode.dart';
import '../../database/db.dart';

class QrResultState extends State<QrResult> {
  String containerName;
  String type;
  String containerID;
  String? itemBarcode;
  var uuid = const Uuid().v4();

  ScreenshotController screenshotController = ScreenshotController();

  void onStart() async {
    WidgetsFlutterBinding.ensureInitialized();
    final db = DatabaseHelper();

    Item item = Item(id: uuid, name: containerName, container_id: containerID);
    await db.insertItem(item);

    if (itemBarcode != null) {
      ItemBarcode itemBarcode = ItemBarcode(
          id: const Uuid().v4(),
          item_id: item.id,
          barcode: this.itemBarcode as String);
      db.insertItemBarcode(itemBarcode);
    }
  }

  QrResultState(
      {required this.containerName,
      required this.type,
      required this.containerID,
      this.itemBarcode}) {
    onStart();
  }

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
            type == 'qr'
                ? Screenshot(
                    controller: screenshotController,
                    child: PrettyQr(
                      data: uuid,
                      typeNumber: 3,
                      size: 320,
                      errorCorrectLevel: QrErrorCorrectLevel.M,
                      roundEdges: true,
                    ),
                  )
                : Container(),
            Row(
              children: [
                type == 'qr'
                    ? Expanded(
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
                              onPressed: () async {
                                final doc = pw.Document();
                                final screenshot =
                                    await screenshotController.capture();
                                final image = pw.MemoryImage(screenshot!);

                                doc.addPage(
                                    pw.Page(build: (pw.Context context) {
                                  return pw.Center(
                                      child: pw.Image(image)); // Center
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
                                        borderRadius:
                                            BorderRadius.circular(8.0))),
                              ),
                            )),
                      )
                    : Container(),
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
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text("Dodaj kolejny przedmiot",
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.center),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrganiseItemPage(
                                    containerID: containerID)));
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

// ignore: must_be_immutable
class QrResult extends StatefulWidget {
  final String containerName;
  final String type;
  final String containerID;
  String? itemBarcode;

  QrResult(
      {Key? key,
      required this.containerName,
      required this.type,
      required this.containerID,
      this.itemBarcode})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  QrResultState createState() => QrResultState(
        containerName: containerName,
        type: type,
        containerID: containerID,
        itemBarcode: itemBarcode,
      );
}
