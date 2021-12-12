import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart' as emojiPicker;
import 'package:flutter/rendering.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:screenshot/screenshot.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'item/main.dart';
import 'package:uuid/uuid.dart';

import '../database/db.dart';
import '../database/model/container.dart' as container_model;

class QrResultState extends State<QrResult> {
  emojiPicker.Emoji emoji;
  String containerName;
  var uuid = const Uuid().v4();

  ScreenshotController screenshotController = ScreenshotController();

  Future<Image> getImage() async {
    return Image.memory(await screenshotController.captureFromWidget(
        Container(
            padding: const EdgeInsets.all(1),
            width: 18,
            height: 18,
            child: Text(
              emoji.emoji,
              textAlign: TextAlign.center,
            )),
        pixelRatio: 10));
  }

  Future<Image> onStart() async {
    WidgetsFlutterBinding.ensureInitialized();
    final db = DatabaseHelper();
    container_model.Container container = container_model.Container(
        id: uuid, name: containerName, emoji: emoji.emoji);
    await db.insertContainer(container);
    return getImage();
  }

  QrResultState({
    required this.emoji,
    required this.containerName,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Image>(
        future: onStart(),
        builder: (context, AsyncSnapshot<Image> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Generowanie kodu"),
                backgroundColor: Colors.grey[900],
              ),
              body: Container(
                margin: const EdgeInsets.only(
                    top: 40, left: 10, right: 10, bottom: 40),
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
                        data: uuid,
                        image: snapshot.data!.image,
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
                              child: const Text("Dodaj przedmioty",
                                  style: TextStyle(color: Colors.black)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OrganiseItemPage(
                                              containerID: uuid,
                                            )));
                              },
                              //shape: RoundedRectangleBorder(
                              //    borderRadius: BorderRadius.circular(10)),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0))),
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
          } else {
            return const Center(
              child: SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}

class QrResult extends StatefulWidget {
  final emojiPicker.Emoji emoji;
  final String containerName;

  const QrResult({Key? key, required this.emoji, required this.containerName})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  QrResultState createState() => QrResultState(
        emoji: emoji,
        containerName: containerName,
      );
}
