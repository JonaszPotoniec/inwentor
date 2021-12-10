import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model/Item.dart';
import 'model/ItemBarcode.dart';
import 'model/Container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'inwentor.db'),
    onCreate: (db, version) async {
      await  db.execute(
        'CREATE TABLE items(id INTEGER PRIMARY KEY, name TEXT, container_id INTEGER)',
      );
      await db.execute(
        'CREATE TABLE itemBarcodes(id INTEGER PRIMARY KEY, item_id INTEGER, barcode INTEGER)',
      );
      await db.execute(
        'CREATE TABLE containers(id INTEGER PRIMARY KEY, name TEXT, emoji TEXT)',
      );
      return;
    },
    version: 1,
  );


  Future<void> insertItem(Item item) async {
    final db = await database;
    await db.insert("items", item.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }


  Future<List<Item>> items() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('items');
    return List.generate(maps.length, (index) => return Item(id: maps[index]["id"], name: maps[index]["name"], container_id: maps[index]["container_id"]));
  }


  Future<void> deleteItem(int id) async {
    final db = await database;
    await db.delete("items", where: 'id = ?', whereArgs: [id]);
  }

  Future<void> insertItemBarcode(ItemBarcode itemBarcode) async {
    final db = await database;
    await db.insert("itemsBarcode", itemBarcode.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }


  Future<List<ItemBarcode>> itemBarcodes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('itemBarcodes');
    return List.generate(maps.length, (index) => return ItemBarcode(id: maps[index]["id"], item_id: maps[index]["item_id"], barcode: maps[index]["barcode"]));
  }


  Future<void> deleteItemBarcode(int id) async {
    final db = await database;
    await db.delete("itemBarcodes", where: 'id = ?', whereArgs: [id]);
  }


  Future<void> insertContainer(Container container) async {
    final db = await database;
    await db.insert("containers", container.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }


  Future<List<Container>> containers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('containers');
    return List.generate(maps.length, (index) => return Container(id: maps[index]["id"], name: maps[index]["name"], emoji: maps[index]["emoji"]));
  }


  Future<void> deleteItemBarcode(int id) async {
    final db = await database;
    await db.delete("containers", where: 'id = ?', whereArgs: [id]);
  }

}