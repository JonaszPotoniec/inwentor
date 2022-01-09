import 'package:emoji_picker_flutter/emoji_picker_flutter.dart' as emojiPicker;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:decorated_icon/decorated_icon.dart';

import 'item_page.dart';

class ItemEntry extends StatelessWidget {
  ItemEntry(
      {required this.name,
      required this.containerEmoji,
      required this.itemId,
      required this.refresh});

  final String name;
  final String containerEmoji;
  final String itemId;
  final Function refresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.only(left: 0.0, right: 0.0, top: 10.0, bottom: 10.0),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(35), boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          spreadRadius: 0,
          blurRadius: 4,
          offset: Offset(0, 4), // changes position of shadow
        ),
      ]),
      child: RawMaterialButton(
        fillColor: Colors.grey[300],
        splashColor: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  name,
                  maxLines: 1,
                  style: const TextStyle(
                      color: Color.fromRGBO(38, 50, 56, 1),
                      fontSize: 24,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 6),
                Text(
                  'Pudełko: ' + containerEmoji,
                  style: const TextStyle(
                      color: Color.fromRGBO(131, 137, 141, 1),
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ItemPage(
                        name: name,
                        containerEmoji: containerEmoji,
                        itemId: itemId,
                      ))).then((value) {
            refresh();
          });
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
