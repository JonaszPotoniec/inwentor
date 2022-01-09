import 'package:flutter/material.dart';
import 'package:inwentor/database/db.dart';
import '../../database/db.dart';

class ItemPage extends StatelessWidget {
  final String name;
  final String containerEmoji;
  final String itemId;

  ItemPage(
      {required this.name, required this.containerEmoji, required this.itemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Odnajdowanie"),
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
                  Text(
                    name,
                    maxLines: 1,
                    style: const TextStyle(
                        color: Color.fromRGBO(38, 50, 56, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Szukaj pudełka z logo:",
                    maxLines: 1,
                    style: TextStyle(
                        color: Color.fromRGBO(38, 50, 56, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    containerEmoji,
                    style: const TextStyle(
                        color: Color.fromRGBO(131, 137, 141, 1),
                        fontSize: 128,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
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
        OutlinedButton(
          child: const Text("Usuń przedmiot",
              style: TextStyle(color: Colors.black)),
          onPressed: () async {
            WidgetsFlutterBinding.ensureInitialized();
            final db = DatabaseHelper();
            await db.deleteItem(itemId);
            Navigator.pop(context);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0))),
          ),
        ),
      ]),
    );
  }
}

class Stateless {}
