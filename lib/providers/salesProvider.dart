import 'package:my_reciepts/models/salesModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class SalesProvider {
  static Database db;
  static final SalesProvider _instance = SalesProvider._internal();
  Future<Database> database;

  factory SalesProvider() {
    return _instance;
  }
  SalesProvider._internal() {
    initDatabase();
  }

  initDatabase() async {
    String path = join(await getDatabasesPath(), 'sales.db');
    // print(path);
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''create table $tableSales (
          $columnId integer primary key autoincrement,
          $columnItemName varchar(50) not null,
          $columnTotal varchar(50) not null
        )''');
    });
  }

  Future<List<Sales>> sales() async {
    List<Map> maps = await db.query(
      tableSales,
    );

    return List.generate(maps.length, (i) {
      return Sales(
        id: maps[i]['id'],
        itemName: maps[i]['email'],
        total: maps[i]['total'],
      );
    });
  }

  Future<Sales> insert(Sales sale) async {
    sale.id = await db.insert(tableSales, sale.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return sale;
  }

  Future<Sales> show(int id) async {
    List<Map> maps = await db.query(tableSales,
        columns: [columnId, columnItemName, columnTotal],
        where: '$columnId = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return Sales.fromMap(maps.first);
    }

    return null;
  }

  Future<int> delete(int id) async {
    return await db
        .delete(tableSales, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Sales sale) async {
    return await db.update(tableSales, sale.toMap(),
        where: '$columnId = ?', whereArgs: [sale.id]);
  }

  Future close() async => db.close();
}
