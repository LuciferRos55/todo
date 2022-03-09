import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import './todo_model.dart';

class DatabaseConnect{
  Database? _database;
  Future<Database> get database async{
    final dbpath = await getDatabasesPath();

    const dbname = 'todo.db';
    // data/data/todo.db
    final path = join(dbpath,dbname);

    _database = await openDatabase(path, version: 1, onCreate: _createDB);

    return _database!;
  }

  Future<void> _createDB(Database db, int version) async{
    await db.execute('''
    CREATE TABLE todo(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      creationDate TEXT,
      isChecked INTEGER
    )
    ''');
  }

  //ADDD
  Future<void> insertTodo(Todo todo) async{
    final  db = await database; //connectdb
    await db.insert('todo',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace, //replace duplicate
    );
  }
  //DELETE based on id
  Future<void> deleteTodo(Todo todo) async{
      final db = await database;
      await db.delete('todo',
      where: 'id == ?',
      whereArgs: [todo.id],
      );
  }
  //FETCH
  Future<List<Todo>> getTodo() async{
    final db = await database;
    //query and save todo as list of maps
    List<Map<String, dynamic>> item = await db.query(
      'todo',
      orderBy: 'id DESC', //lastest todo on top by desc order
    );

    return List.generate(
      item.length,
          (i) => Todo(
            id: item[i]['id'],
            title: item[i]['title'],
            creationDate: DateTime.parse( item[i]['creationDate']),
            isChecked: item[i]['isChecked'] == 1? true : false,
          ),
    );
  }
}