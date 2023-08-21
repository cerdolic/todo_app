import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '/models/todo.dart';

class Db {
  static const tableName = 'todo';

  static final instance = Db._();
  Db._();

  Database? _database;

  Future<Database> get database async {
    final dbPath = await getDatabasesPath();
    const dbName = 'todo.db';
    final fullPath = join(dbPath, dbName);

    _database = await openDatabase(fullPath, version: 1, onCreate: _createDb);

    return _database!;
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todo(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        creationDate TEXT,
        isChecked INTEGER
      )
    ''');
  }

  Future<void> insertTodo(Todo todo) async {
    final db = await database;
    await db.insert(
      tableName,
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteTodo(Todo todo) async {
    final db = await database;
    await db.delete(
      tableName,
      where: 'id == ?',
      whereArgs: [todo.id],
    );
  }

  Future<List<Todo>> getTodoList() async {
    final db = await database;
    List<Map<String, dynamic>> items = await db.query(
      tableName,
      orderBy: 'id DESC',
    );

    return List.generate(
      items.length,
      (i) => Todo(
        id: items[i]['id'],
        title: items[i]['title'],
        creationDate: DateTime.parse(items[i]['creationDate']),
        isChecked: items[i]['isChecked'] == 1 ? true : false,
      ),
    );
  }
}
