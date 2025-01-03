import 'package:task_assignment/core/utils/imports.dart';

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            description TEXT NOT NULL,
            assignedEmployee TEXT NOT NULL
          )
        ''');
      },
    );
  }

  @override
  Future<TaskModel> createTask(TaskModel task) async {
    final db = await database;
    final id = await db.insert('tasks', task.toMap());
    return TaskModel(
      id: id,
      name: task.name,
      description: task.description,
      assignedEmployee: task.assignedEmployee,
    );
  }

  @override
  Future<List<TaskModel>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) => TaskModel.fromMap(maps[i]));
  }

  @override
  Future<void> deleteTask(int id) async {
    final db = await database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<bool> editTask(TaskModel task) async {
    Logger.log("task ID ${task.toMap()}");
    final db = await database;
    final rowsAffected = await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
    Logger.log("Updated $rowsAffected");
    return rowsAffected > 0;
  }

  @override
  Future<List<TaskModel>> searchTasks(String query) async {
    final db = await database;
    if (query.isEmpty) {
      final List<Map<String, dynamic>> maps = await db.query('tasks');
      return List.generate(maps.length, (i) => TaskModel.fromMap(maps[i]));
    }

    final List<Map<String, dynamic>> maps = await db.query(
      'tasks',
      where: 'assignedEmployee LIKE ?',
      whereArgs: ['%$query%'],
    );
    return List.generate(maps.length, (i) => TaskModel.fromMap(maps[i]));
  }
}
