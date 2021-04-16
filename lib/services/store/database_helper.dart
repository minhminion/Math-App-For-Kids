import 'dart:io';
import 'package:math_app_for_kid/models/local/game.dart';
import 'package:math_app_for_kid/models/local/lessons.dart';
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

    await deleteDatabase(directory.path);

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
        completedGame INTEGER)
        ''');
    await db.execute('''
      CREATE TABLE Gameplays(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        gameType INTEGER,
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
      INSERT INTO Lessons (title, image, completedGame)
      VALUES('Đếm các số trong phạm vi 10', 'mars.png', 0)
      ''');
    await db.execute('''
      INSERT INTO Lessons (title, image, completedGame)
      VALUES('Hình vuông - Hình tròn\nHình tam giác - Hình chữ nhật', 'earth.png', 0)
      ''');
    await db.execute('''
      INSERT INTO Lessons (title, image, completedGame)
      VALUES('Nhiều hơn - Ít hơn - Bằng nhau', 'mercury.png', 0)
      ''');
    await db.execute('''
      INSERT INTO Lessons (title, image, completedGame)
      VALUES('Phép cộng trong phạm vi 10', 'moon.png', 0)
      ''');
    await db.execute('''
      INSERT INTO Lessons (title, image, completedGame)
      VALUES('Phép trừ trong phạm vi 10', 'neptune.png', 0)
      ''');

    /* GAMEPLAY */
    /* COUNTING GAME */
    // GAME TYPE { countGame: 0, mathGame: 1, compareGame: 2, shapeGame: 3 }
    /* 2 */
    await db.execute('''
      INSERT INTO Gameplays (option1, option2, option3, result, isComplete, lessonId, gameType)
      VALUES('6', '7', '2', '2', 0, 1, 0)
      ''');
    /* 1 */
    await db.execute('''
      INSERT INTO Gameplays (option1, option2, option3, result, isComplete, lessonId, gameType)
      VALUES('4', '1', '2', '1', 0, 1, 0)
      ''');
    /* 8 */
    await db.execute('''
      INSERT INTO Gameplays (option1, option2, option3, result, isComplete, lessonId, gameType)
      VALUES('8', '3', '5', '8', 0, 1, 0)
      ''');
    /* 6 */
    await db.execute('''
      INSERT INTO Gameplays (option1, option2, option3, result, isComplete, lessonId, gameType)
      VALUES('9', '6', '2', '6', 0, 1, 0)
      ''');
    /* 3 */
    await db.execute('''
      INSERT INTO Gameplays (option1, option2, option3, result, isComplete, lessonId, gameType)
      VALUES('3', '5', '1', '3', 0, 1, 0)
      ''');
    /* 10 */
    await db.execute('''
      INSERT INTO Gameplays (option1, option2, option3, result, isComplete, lessonId, gameType)
      VALUES('8', '10', '7', '10', 0, 1, 0)
      ''');
    /* 4 */
    await db.execute('''
      INSERT INTO Gameplays (option1, option2, option3, result, isComplete, lessonId, gameType)
      VALUES('3', '1', '4', '4', 0, 1, 0)
      ''');
    /* 9 */
    await db.execute('''
      INSERT INTO Gameplays (option1, option2, option3, result, isComplete, lessonId, gameType)
      VALUES('6', '9', '2', '9', 0, 1, 0)
      ''');
    /* 5 */
    await db.execute('''
      INSERT INTO Gameplays (option1, option2, option3, result, isComplete, lessonId, gameType)
      VALUES('5', '6', '8', '5', 0, 1, 0)
      ''');
    /* 7 */
    await db.execute('''
      INSERT INTO Gameplays (option1, option2, option3, result, isComplete, lessonId, gameType)
      VALUES('4', '7', '3', '7', 0, 1, 0)
      ''');

    // Game chọn hình
    // enum ShapeType { circle, square, rectangle, triangle }
    await db.execute('''
      INSERT INTO Gameplays (option1, option2, option3, result, isComplete, lessonId, gameType)
      VALUES('2', '2', '1', '1', 0, 2, 3)
      ''');
    await db.execute('''
      INSERT INTO Gameplays (option1, option2, option3, result, isComplete, lessonId, gameType)
      VALUES('2', '2', '1', '0', 0, 2, 3)
      ''');
    await db.execute('''
      INSERT INTO Gameplays (option1, option2, option3, result, isComplete, lessonId, gameType)
      VALUES('2', '2', '1', '2', 0, 2, 3)
      ''');
    await db.execute('''
      INSERT INTO Gameplays (option1, option2, option3, result, isComplete, lessonId, gameType)
      VALUES('2', '2', '1', '3', 0, 2, 3)
      ''');

    // Game cộng
    await db.execute('''
      INSERT INTO Gameplays (option1, option2, option3, result, isComplete, lessonId, gameType, numA, numB, operator)
      VALUES('4', '7', '3', '7', 0, 4, 1, '5', '2', '+')
      ''');
    await db.execute('''
      INSERT INTO Gameplays (option1, option2, option3, result, isComplete, lessonId, gameType, numA, numB, operator)
      VALUES('4', '7', '3', '3', 0, 4, 1, '1', '2', '+')
      ''');

    // Game So sánh
    await db.execute('''
      INSERT INTO Gameplays (option1, option2, option3, result, isComplete, lessonId, gameType, numA, numB)
      VALUES('0', '1', '2', '2', 0, 3, 2, '3', '5')
      ''');
    await db.execute('''
      INSERT INTO Gameplays (option1, option2, option3, result, isComplete, lessonId, gameType, numA, numB)
      VALUES('0', '1', '2', '1', 0, 3, 2, '4', '4')
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
        await db.query(Lesson.tableName, where: "id = ?", whereArgs: [id]);
    var gameplayQuery = await db
        .query(GamePlay.tableName, where: "lessonId = ?", whereArgs: [id]);

    if (lessonQuery.isEmpty) {
      return null;
    }

    var list = Lesson.fromMap(lessonQuery.first);

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

  Future<List<Lesson>> getAllLesson() async {
    Database db = await dbHelper.database;

    List<dynamic> lessonQuery = await db.query(Lesson.tableName);

    List<Lesson> listLesson =
        lessonQuery.map((e) => Lesson.fromMap(e)).toList();

    return await Future.wait(listLesson.map((lesson) async {
      List<GamePlay> gamePlays = await getGamePlayByLessonId(lesson.id);
      lesson.totalGame = gamePlays?.length;
      lesson.gameplays = gamePlays;
      lesson.completedGame = gamePlays.fold(
          0, (value, element) => element.isComplete ? value + 1 : value);
      return lesson;
    }));
  }

  Future<List<GamePlay>> getGamePlayByLessonId(int lessonId) async {
    Database db = await dbHelper.database;
    var gameplayQuery = await db.query(GamePlay.tableName,
        where: "lessonId = ?", whereArgs: [lessonId]);

    return gameplayQuery.map((x) => GamePlay.fromMap(x)).toList();
  }
}
