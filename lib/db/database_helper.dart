import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/karyawan.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    _database ??= await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'karyawan.db');

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE karyawan (
        id TEXT PRIMARY KEY,
        nama TEXT,
        tglMasuk TEXT,
        usia INTEGER
      )
    ''');
  }

  // Insert or Update
  Future<void> saveKaryawan(Karyawan k) async {
    final db = await database;
    await db.insert(
      'karyawan',
      k.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get All (Filtered)
  Future<List<Karyawan>> getFilteredKaryawan({
    String? nama,
    String? tglAwal,
    String? tglAkhir,
  }) async {
    final db = await database;

    String where = '1=1';
    List<dynamic> whereArgs = [];

    if (nama != null && nama.isNotEmpty) {
      where += ' AND nama LIKE ?';
      whereArgs.add('%$nama%');
    }
    if (tglAwal != null && tglAwal.isNotEmpty) {
      where += ' AND date(tglMasuk) >= date(?)';
      whereArgs.add(tglAwal);
    }
    if (tglAkhir != null && tglAkhir.isNotEmpty) {
      where += ' AND date(tglMasuk) <= date(?)';
      whereArgs.add(tglAkhir);
    }

    final result = await db.query(
      'karyawan',
      where: where,
      whereArgs: whereArgs,
    );
    return result.map((e) => Karyawan.fromMap(e)).toList();
  }

  // Delete
  Future<void> deleteKaryawan(String id) async {
    final db = await database;
    await db.delete('karyawan', where: 'id = ?', whereArgs: [id]);
  }
}
