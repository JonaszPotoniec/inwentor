import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:inwentor/database/db.dart';
import '../../database/db.dart';
import '../../database/model/container.dart' as containerModel;
import '../../database/model/item.dart';
import 'item_in_container.dart';

class ContentPage extends StatelessWidget {
  final String id;

  ContentPage({required this.id});

  Future<Map<String, dynamic>?> getContainer() async {
    WidgetsFlutterBinding.ensureInitialized();
    final db = DatabaseHelper();
    return db.getContainerWithItems(id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
        future: getContainer(),
        builder: (context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Zawartość"),
                  backgroundColor: Colors.grey[900],
                ),
                body: Column(children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, 4), // changes position of shadow
                          ),
                        ]),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const Text(
                              'Pojemnik nie istnieje',
                              style: TextStyle(
                                  color: Color.fromRGBO(38, 50, 56, 1),
                                  fontSize: 32,
                                  fontWeight: FontWeight.normal),
                              textAlign: TextAlign.center,
                            ),
                            OutlinedButton(
                              child: const Text("Powrót",
                                  style: TextStyle(color: Colors.black)),
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0))),
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                ]),
              );
            }
            print(snapshot.data);

            var container =
                snapshot.data!['container'] as containerModel.Container;
            var items = snapshot.data!['items'] as List<Item>;
            return Scaffold(
              appBar: AppBar(
                title: const Text("Zawartość"),
                backgroundColor: Colors.grey[900],
              ),
              body: Container(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        container.emoji,
                        style: const TextStyle(
                            color: Color.fromRGBO(131, 137, 141, 1),
                            fontSize: 128,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Zawartość pojemnika ${container.name}',
                        maxLines: 1,
                        style: const TextStyle(
                            color: Color.fromRGBO(38, 50, 56, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.from(items.map((item) {
                              return ItemInContainer(
                                  name: item.name,
                                  itemId: item.id,
                                  refresh: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ContentPage(id: id)),
                                        (Route<dynamic> route) =>
                                            route.isFirst);
                                  });
                            })),
                          ),
                        ),
                      ),
                      /*Text(
                    "A",
                    maxLines: 1,
                    style: const TextStyle(
                        color: Color.fromRGBO(38, 50, 56, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 6),*/
                    ],
                  ),
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
