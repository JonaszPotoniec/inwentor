import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model/item.dart';
import 'model/item_barcode.dart';
import 'model/container.dart' as container_model;

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper.internal();

  factory DatabaseHelper() => instance;
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database as Database;
    }

    _database = await openDatabase(
      join(await getDatabasesPath(), 'inwentor.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE items(id TEXT PRIMARY KEY, name TEXT, container_id TEXT)',
        );
        await db.execute(
          'CREATE TABLE itemBarcodes(id TEXT PRIMARY KEY, item_id TEXT, barcode TEXT)',
        );
        await db.execute(
          'CREATE TABLE containers(id TEXT PRIMARY KEY, name TEXT, emoji TEXT)',
        );
        return;
      },
      version: 1,
    );

    return _database as Database;
  }

  DatabaseHelper.internal();

  Future<void> insertItem(Item item) async {
    final db = await database;
    await db.insert("items", item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Item>> items() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('items');
    return List.generate(
        maps.length,
        (index) => Item(
            id: maps[index]["id"],
            name: maps[index]["name"],
            container_id: maps[index]["container_id"]));
  }

  Future<void> deleteItem(String id) async {
    final db = await database;
    await db.delete("items", where: 'id = ?', whereArgs: [id]);
  }

  Future<void> insertItemBarcode(ItemBarcode itemBarcode) async {
    final db = await database;
    await db.insert("itemsBarcode", itemBarcode.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ItemBarcode>> itemBarcodes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('itemBarcodes');
    return List.generate(
        maps.length,
        (index) => ItemBarcode(
            id: maps[index]["id"],
            item_id: maps[index]["item_id"],
            barcode: maps[index]["barcode"]));
  }

  Future<void> deleteItemBarcode(String id) async {
    final db = await database;
    await db.delete("itemBarcodes", where: 'id = ?', whereArgs: [id]);
  }

  Future<void> insertContainer(container_model.Container container) async {
    final db = await database;
    await db.insert("containers", container.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<container_model.Container>> containers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('containers');
    return List.generate(
        maps.length,
        (index) => container_model.Container(
            id: maps[index]["id"],
            name: maps[index]["name"],
            emoji: maps[index]["emoji"]));
  }

  Future<void> deleteContainer(String id) async {
    final db = await database;
    await db.delete("containers", where: 'id = ?', whereArgs: [id]);
  }
}
