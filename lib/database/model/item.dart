import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Item {
  final String id;
  final String name;
  final String container_id;

  Item({
    required this.id,
    required this.name,
    required this.container_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'container_id': container_id,
    };
  }

  @override
  String toString() {
    return 'Item{id: $id, name: $name, container_id: $container_id}';
  }
}
