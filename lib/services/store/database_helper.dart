import 'dart:io';
import 'package:math_app_for_kid/models/local/game.dart';
import 'package:math_app_for_kid/models/local/lessons.dart';
import 'package:math_app_for_kid/models/local/lessons_for_test.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _dbName = 'math_app_for_kids.db';
  static final _dbVersion = 1;

  DatabaseHelper._();
  static final DatabaseHelper dbHelper = DatabaseHelper._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
    );
  }

  _onCreate(Database db, int version) async {
    /* CREATE TABLE */
    await db.execute('''
      CREATE TABLE Lessons(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        image TEXT,
        completedGame INTEGER,
        totalGame INTEGER)
        ''');
    await db.execute('''
      CREATE TABLE Gameplays(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        option1 TEXT,
        option2 TEXT,
        option3 TEXT,
        numA INTEGER,
        numB INTEGER,
        operator TEXT,
        result TEXT,
        isComplete BOOL,
        lessonId INTEGER,
        FOREIGN KEY (lessonId)
          REFERENCES Lessons (id))
        ''');

    /* DATA SEED */
    /* LESSON */
    await db.execute('''
      INSERT INTO Lessons (title, image, completedGame, totalGame)
      VALUES('Đếm các số trong phạm vi 10', 'mars.png', 10, 3)
      ''');
    await db.execute('''
      INSERT INTO Lessons (title, image, completedGame, totalGame)
      VALUES('Hình vuông - Hình tròn\nHình tam giác - Hình chữ nhật', 'earth.png', 10, 3)
      ''');
    await db.execute('''
      INSERT INTO Lessons (title, image, completedGame, totalGame)
      VALUES('Nhiều hơn - Ít hơn - Bằng nhau', 'mercury.png', 4, 3)
      ''');
    await db.execute('''
      INSERT INTO Lessons (title, image, completedGame, totalGame)
      VALUES('Phép cộng trong phạm vi 10', 'moon.png', 3, 3)
      ''');
    await db.execute('''
      INSERT INTO Lessons (title, image, completedGame, totalGame)
      VALUES('Phép trừ trong phạm vi 10', 'neptune.png', 5, 3)
      ''');

    /* GAMEPLAY */
    /* COUNTING GAME */
    /* 2 */
    await db.execute('''
      INSERT INTO Gameplays (option1, option2, option3, result, isComplete, lessonId)
      VALUES('6', '7', '2', '2', 0, 1)
      ''');
    /* 1 */
    await db.execute('''
      INSERT INTO Gameplays (option1, option2, option3, result, isComplete, lessonId)
      VALUES('4', '1', '2', '1', 0, 1)
      ''');
    /* 8 */
    await db.execute('''
      INSERT INTO Gameplays (option1, option2, option3, result, isComplete, lessonId)
      VALUES('8', '3', '5', '8', 0, 1)
      ''');
    /* 6 */
    await db.execute('''
      INSERT INTO Gameplays (option1, option2, option3, result, isComplete, lessonId)
      VALUES('9', '6', '2', '6', 0, 1)
      ''');
    /* 3 */
    await db.execute('''
      INSERT INTO Gameplays (option1, option2, option3, result, isComplete, lessonId)
      VALUES('3', '5', '1', '3', 0, 1)
      ''');
    /* 10 */
    await db.execute('''
      INSERT INTO Gameplays (option1, option2, option3, result, isComplete, lessonId)
      VALUES('8', '10', '7', '10', 0, 1)
      ''');
    /* 4 */
    await db.execute('''
      INSERT INTO Gameplays (option1, option2, option3, result, isComplete, lessonId)
      VALUES('3', '1', '4', '4', 0, 1)
      ''');
    /* 9 */
    await db.execute('''
      INSERT INTO Gameplays (option1, option2, option3, result, isComplete, lessonId)
      VALUES('6', '9', '2', '9', 0, 1)
      ''');
    /* 5 */
    await db.execute('''
      INSERT INTO Gameplays (option1, option2, option3, result, isComplete, lessonId)
      VALUES('5', '6', '8', '5', 0, 1)
      ''');
    /* 7 */
    await db.execute('''
      INSERT INTO Gameplays (option1, option2, option3, result, isComplete, lessonId)
      VALUES('4', '7', '3', '7', 0, 1)
      ''');
  }

  Future<List<Map<String, dynamic>>> getAll(String tableName) async {
    Database db = await dbHelper.database;
    return await db.query(tableName);
  }

  Future getById(String tableName, int id) async {
    Database db = await dbHelper.database;
    var res = await db.query(tableName, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? res.first : null;
  }

  Future getLessonWithGameplays(int id) async {
    Database db = await dbHelper.database;
    var lessonQuery =
        await db.query(Lesson2.tableName, where: "id = ?", whereArgs: [id]);
    var gameplayQuery = await db
        .query(GamePlay.tableName, where: "lessonId = ?", whereArgs: [id]);

    if (lessonQuery.isEmpty) {
      return null;
    }

    var list = Lesson2.fromMap(lessonQuery.first);

    gameplayQuery.isEmpty
        ? list.gameplays = []
        : list.gameplays =
            List<GamePlay>.from(gameplayQuery.map((x) => GamePlay.fromMap(x)));

    return list;
  }

  Future<int> updateLesson(String tableName, Lesson lesson) async {
    Database db = await dbHelper.database;
    return await db.update(tableName, lesson.toMap(),
        where: "id = ?", whereArgs: [lesson.id]);
  }
}
