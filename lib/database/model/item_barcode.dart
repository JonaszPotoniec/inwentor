import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ItemBarcode {
  final String id;
  final String item_id;
  final String barcode;

  ItemBarcode({
    required this.id,
    required this.item_id,
    required this.barcode,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'item_id': item_id,
      'barcode': barcode,
    };
  }

  @override
  String toString() {
    return 'ItemBarcode{id: $id, item_id: $item_id, barcode: $barcode}';
  }
}
