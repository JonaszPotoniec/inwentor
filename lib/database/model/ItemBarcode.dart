import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ItemBarcode {
  final int id;
  final int item_id;
  final int barcode;

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
