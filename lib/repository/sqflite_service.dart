import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbNoteService{
   static Database? _database;
   static String table_name='product';
   static String database_name='product.db';
   static String column_id='_id';
   static String column_image='image';
   static String column_product_name='product_name';
   static String column_product_qty='product_qty';
   static String column_product_price='product_price';

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,database_name);

    // Open/create the database at a given path
    var userDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return userDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $table_name ($column_id INTEGER PRIMARY KEY AUTOINCREMENT,$column_image TEXT,$column_product_name TEXT,$column_product_price TEXT,$column_product_qty TEXT)");
  }

  Future<int> insertProduct(Map<String,dynamic> map) async {
    Database db = await database;
    var result = await db.insert(table_name, map);
    return result;
  }

  Future<int> updateProduct(Map<String,dynamic> map, int id) async {
    Database db = await database;
    var result = await db.update(table_name, map, where: '$column_id=?', whereArgs: [id]);
    return result;
  }

  Future<int> deleteProduct(int id) async {
    Database db = await database;
    var result = await db.delete(table_name, where: '$column_id=?',whereArgs: [id]);
    return result;
  }

  Future selectProduct() async {
    Database db = await database;
    var result = await db.query(table_name);
    return result;
  }
}