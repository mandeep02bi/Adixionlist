import 'package:doctor/Data/model/certificate_model.dart';
import 'package:doctor/Data/model/invoice_model.dart';
import 'package:doctor/Data/model/medicine_model.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MedicineDatabase {
  static final MedicineDatabase instance = MedicineDatabase._init();
  static Database? _database;

  MedicineDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('medicines.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 4,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
  if (oldVersion < 2) {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS certificate(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        date TEXT
      )
    ''');
  }
  if (oldVersion < 3) {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS invoice(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        patient_id TEXT,
        name TEXT,
        title TEXT,
        item TEXT,
        amount INTEGER,
        total INTEGER,
        age INTEGER,
        is_paid INTEGER,
        date TEXT
      )
    ''');
  }
  if (oldVersion < 4) {
    try {
      final columns = await db.rawQuery('PRAGMA table_info(medicines)');
      final hasType = columns.any((col) => col['name'] == 'type');
      if (!hasType) {
        await db.execute(
          'ALTER TABLE medicines ADD COLUMN type TEXT DEFAULT "medicine"',
        );
      }
    } catch (e) {
      debugPrint('DB upgrade error: $e');
    }
  }
}
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS medicines (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        medicine_name TEXT NOT NULL,
        qty TEXT NOT NULL,
        frequency TEXT NOT NULL,
        route_form TEXT NOT NULL,
        no_of_days TEXT NOT NULL,
        instruction TEXT NOT NULL,
        type TEXT DEFAULT "medicine" 
      )
    ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS certificate(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        date TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS invoice(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        patient_id TEXT,
        name TEXT,
        title TEXT,
        item TEXT,
        amount INTEGER,
        total INTEGER,
        age INTEGER,
        is_paid INTEGER,
        date TEXT
      )
    ''');
  }

  // Insert
  Future<int> insertMedicine(MedicineModel medicine) async {
    final db = await instance.database;
    return await db.insert('medicines', medicine.toMap());
  }

  Future<List<MedicineModel>> getAllMedicines() async {
    final db = await instance.database;
    final result = await db.query(
      'medicines',
      where: 'type = ? OR type IS NULL', 
      whereArgs: ['medicine'],
      orderBy: 'id DESC',
    );
    return result.map((map) => MedicineModel.fromMap(map)).toList();
  }

  // Get All Lab Tests
  Future<List<MedicineModel>> getAllLabTests() async {
    final db = await database;
    final result = await db.query(
      'medicines',
      where: 'type = ?',
      whereArgs: ['lab'],
      orderBy: 'id DESC',
    );
    return result.map((e) => MedicineModel.fromMap(e)).toList();
  }

  // Delete
  Future<int> deleteMedicine(int id) async {
    final db = await instance.database;
    return await db.delete('medicines', where: 'id = ?', whereArgs: [id]);
  }

  // Clear All Medicines Drafts
  Future<int> clearAllMedicines() async {
    final db = await instance.database;
    return await db.delete('medicines', where: 'type = ? OR type IS NULL', whereArgs: ['medicine']);
  }

  // Clear All Lab Tests Drafts
  Future<int> clearAllLabTests() async {
    final db = await instance.database;
    return await db.delete('medicines', where: 'type = ?', whereArgs: ['lab']);
  }

  // Close DB
  Future close() async {
    final db = await instance.database;
    db.close();
  }

  static Future<int> insertCertificate(CertificateModel data) async {
    final db = await instance.database;
    return db.insert('certificate', data.toMap());
  }

  /// INSERT
  static Future<int> insertInvoice(InvoiceModel data) async {
    final db = await instance.database;
    return db.insert('invoice', data.toMap());
  }

  /// GET ALL
  static Future<List<InvoiceModel>> getAllInvoices() async {
    final db = await instance.database;
    final res = await db.query('invoice', orderBy: 'id DESC');

    return res.map((e) => InvoiceModel.fromMap(e)).toList();
  }

  static Future<List<CertificateModel>> getAllCertificates() async {
    final db = await instance.database;
    final res = await db.query('certificate', orderBy: 'id DESC');

    return res.map((e) => CertificateModel.fromMap(e)).toList();
  }
}