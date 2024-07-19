import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'models/incident.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'incident.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE incidents (
        id INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT,
        date TEXT,
        imagePath TEXT,
        audioPath TEXT
      )
    ''');
  }

  Future<int> insertIncident(Incident incident) async {
    Database db = await database;
    return await db.insert('incidents', incident.toMap());
  }

  Future<List<Incident>> getIncidents() async {
    Database db = await database;
    var result = await db.query('incidents');
    return result.map((data) => Incident.fromMap(data)).toList();
  }

  Future<int> deleteAllIncidents() async {
    Database db = await database;
    return await db.delete('incidents');
  }
}
