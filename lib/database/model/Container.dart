import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Container {
  final int id;
  final String name;
  final String emoji;

  Container({
    required this.id,
    required this.name,
    required this.emoji,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'emoji': emoji,
    };
  }

  @override
  String toString() {
    return 'Container{id: $id, name: $name, emoji: $emoji}';
  }
}
