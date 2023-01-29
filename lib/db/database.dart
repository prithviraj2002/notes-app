import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/note-model.dart';

class DatabaseHelper{
  static Future<Database> _getDb() async{
    return openDatabase(join(await getDatabasesPath(), 'notes'),
      onCreate: (db,version) async {
        await db.query(
            "CREATE TABLE Note(id INTEGER PRIMARY KEY, title TEXT NOT NULL, description TEXT NOT NULL)"
        );
      },
      version: 1
    );
  }

  static Future<int> addNote(Note note) async{
    final db = await _getDb();
    return await db.insert(
        'note',
        note.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<int> updateNote(Note note) async{
    final db = await _getDb();
    return await db.update(
        'note',
      note.toJson(),
      where: 'id = ?',
      whereArgs: [note.id],
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<int> delNote(Note note) async{
    final db = await _getDb();
    return await db.delete(
      'note',
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

   static Future<List<Note>?> getnotes() async{
    final db = await _getDb();
    final List<Map<String, dynamic>> maps = await db.query('note');

    if(maps.isEmpty){
      return null;
    }
    
    return List.generate(maps.length, (index) => Note.fromJson(maps[index]));
  }
}