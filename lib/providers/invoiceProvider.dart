import 'package:my_reciepts/models/invoiceModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class InvoiceProvider {
  static Database db;
  static final InvoiceProvider _instance = InvoiceProvider._internal();
  Future<Database> database;

  factory InvoiceProvider() {
    return _instance;
  }
  InvoiceProvider._internal() {
    initDatabase();
  }

  initDatabase() async {
    String path = join(await getDatabasesPath(), 'invoices.db');
    // print(path);
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''create table $tableInvoice (
          $columnId integer primary key autoincrement,
          $columnEmail varchar(50) not null,
          $columnTotal varchar(50) not null
        )''');
    });
  }

  Future<List<Invoice>> invoices() async {
    List<Map> maps = await db.query(
      tableInvoice,
    );

    return List.generate(maps.length, (i) {
      return Invoice(
        id: maps[i]['id'],
        email: maps[i]['email'],
        total: maps[i]['total'],
      );
    });
  }

  Future<Invoice> insert(Invoice invoice) async {
    invoice.id = await db.insert(tableInvoice, invoice.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return invoice;
  }

  Future<Invoice> show(int id) async {
    List<Map> maps = await db.query(tableInvoice,
        columns: [columnId, columnEmail, columnTotal],
        where: '$columnId = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return Invoice.fromMap(maps.first);
    }

    return null;
  }

  Future<int> delete(int id) async {
    return await db
        .delete(tableInvoice, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Invoice invoice) async {
    return await db.update(tableInvoice, invoice.toMap(),
        where: '$columnId = ?', whereArgs: [invoice.id]);
  }

  Future close() async => db.close();
}
