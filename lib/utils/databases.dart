import 'package:keep_notes/constants/imports.dart';
import 'package:sqflite/sqflite.dart';

// a toplevel  instance
// it can be acceessed from everty part of the  app or project
Database? DB;

class DatabaseNotes {
  Future<void> createDatabase() async {
    // get the db name
    String dbName = "/Keepnotes.db";
    // get the platform(android, ios,macos,web,windows,linux,etc) dbPath
    String platformPath = await getDatabasesPath();
    // get the databasePath
    String dbPath = platformPath + dbName;
    // open the database
    openDatabase(dbPath, onCreate: (db, version) {
      print('db created');
    },
        onOpen: (db) {
      print('db opened');
      // init the database
      DB = db;
      createTables();
    }, version: 1);
  }

  Future<void> createTables() async {
    try {
      DB!.execute(''' CREATE TABLE ${DatabaseConst.noteTable} (${DatabaseConst.noteId} INTEGER PRIMARY KEY AUTOINCREMENT, ${DatabaseConst.noteTitle} TEXT, ${DatabaseConst.noteDescription} TEXT, ${DatabaseConst.noteDateTime} TEXT)''').whenComplete(
          () => print('${DatabaseConst.noteTable} table created  '));
    } on Exception catch (e) {
      print(' ${DatabaseConst.noteTable} table error  $e');
      // TODO
    }
   ///^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  }
}
