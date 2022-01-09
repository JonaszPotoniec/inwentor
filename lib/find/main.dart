import 'package:flutter/material.dart';
import 'item/item_entry.dart';
import '../database/db.dart';

class _FindPageState extends State<FindPage> {
  var items = [];
  final db = DatabaseHelper();
  TextEditingController itemNameInput = TextEditingController();

  @override
  void initState() {
    super.initState();
    items = [];
    search('');
  }

  void search(String searchText) async {
    db.findItems(searchText).then((value) {
      setState(() {
        items = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Odnajdowanie"),
        backgroundColor: Colors.grey[900],
      ),
      body: Center(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                  controller: itemNameInput,
                  decoration: InputDecoration(
                      labelText: 'Czego szukasz?',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onChanged: search),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: List.from(items.map((item) {
                      return ItemEntry(
                        name: item['ItemName'],
                        containerEmoji: item['containerEmoji'],
                        itemId: item['itemId'],
                        refresh: () {
                          search(itemNameInput.text.toString());
                        },
                      );
                    })),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FindPage extends StatefulWidget {
  const FindPage({Key? key}) : super(key: key);

  @override
  _FindPageState createState() => _FindPageState();
}
