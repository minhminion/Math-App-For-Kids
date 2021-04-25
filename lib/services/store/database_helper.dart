import 'dart:io';
import 'package:math_app_for_kid/models/local/gameClaims.dart';
import 'package:math_app_for_kid/models/local/games.dart';
import 'package:math_app_for_kid/models/local/lessons.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _dbName = 'math_app_for_kids.db';
  static final _dbVersion = 1;

  static final String lessonTable = 'Lessons';
  static final String gameTable = 'Games';
  static final String gameTypeTable = 'GameTypes';
  static final String gameClaimTable = 'GameClaims';

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
    await _createTable(db);

    await _createLessons(db);

    await _createGameTypes(db);

    // GAME ĐẾM SỐ
    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (1, 1, '2', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (1, 'option1', '6')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (1, 'option2', '7')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (1, 'option3', '2')
    ''');

    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (1, 1, '1', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (2, 'option1', '4')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (2, 'option2', '1')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (2, 'option3', '2')
    ''');

    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (1, 1, '8', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (3, 'option1', '8')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (3, 'option2', '3')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (3, 'option3', '5')
    ''');

    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (1, 1, '6', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (4, 'option1', '9')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (4, 'option2', '6')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (4, 'option3', '2')
    ''');

    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (1, 1, '3', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (5, 'option1', '3')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (5, 'option2', '5')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (5, 'option3', '1')
    ''');

    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (1, 1, '10', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (6, 'option1', '8')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (6, 'option2', '10')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (6, 'option3', '7')
    ''');

    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (1, 1, '4', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (7, 'option1', '3')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (7, 'option2', '1')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (7, 'option3', '4')
    ''');

    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (1, 1, '9', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (8, 'option1', '6')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (8, 'option2', '9')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (8, 'option3', '2')
    ''');

    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (1, 1, '5', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (9, 'option1', '5')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (9, 'option2', '6')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (9, 'option3', '8')
    ''');

    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (1, 1, '7', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (10, 'option1', '4')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (10, 'option2', '7')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (10, 'option3', '3')
    ''');

    // GAME SO SÁNH
    // 0: >
    // 1: =
    // 2: <
    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (3, 3, '2', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (11, 'option1', '0')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (11, 'option2', '1')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (11, 'option3', '2')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (11, 'numA', '3')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (11, 'numB', '5')
    ''');

    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (3, 3, '1', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (12, 'option1', '0')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (12, 'option2', '1')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (12, 'option3', '2')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (12, 'numA', '4')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (12, 'numB', '4')
    ''');

    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (3, 3, '0', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (13, 'option1', '0')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (13, 'option2', '1')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (13, 'option3', '2')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (13, 'numA', '3')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (13, 'numB', '2')
    ''');

    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (3, 3, '2', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (14, 'option1', '0')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (14, 'option2', '1')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (14, 'option3', '2')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (14, 'numA', '7')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (14, 'numB', '9')
    ''');

    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (3, 3, '1', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (15, 'option1', '0')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (15, 'option2', '1')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (15, 'option3', '2')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (15, 'numA', '2')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (15, 'numB', '2')
    ''');

    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (3, 3, '2', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (16, 'option1', '0')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (16, 'option2', '1')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (16, 'option3', '2')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (16, 'numA', '9')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (16, 'numB', '10')
    ''');

    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (3, 3, '0', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (17, 'option1', '0')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (17, 'option2', '1')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (17, 'option3', '2')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (17, 'numA', '8')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (17, 'numB', '6')
    ''');

    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (3, 3, '0', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (18, 'option1', '0')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (18, 'option2', '1')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (18, 'option3', '2')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (18, 'numA', '4')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (18, 'numB', '1')
    ''');

    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (3, 3, '1', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (19, 'option1', '0')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (19, 'option2', '1')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (19, 'option3', '2')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (19, 'numA', '7')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (19, 'numB', '7')
    ''');

    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (3, 3, '2', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (20, 'option1', '0')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (20, 'option2', '1')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (20, 'option3', '2')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (20, 'numA', '5')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (20, 'numB', '7')
    ''');

    // GAME CỘNG
    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (4, 4, '2', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (21, 'option1', '3')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (21, 'option2', '1')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (21, 'option3', '2')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (21, 'numA', '1')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (21, 'numB', '1')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (21, 'operator', '+')
    ''');

    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (4, 4, '3', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (22, 'option1', '2')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (22, 'option2', '3')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (22, 'option3', '1')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (22, 'numA', '1')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (22, 'numB', '2')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (22, 'operator', '+')
    ''');

    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (4, 4, '4', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (23, 'option1', '4')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (23, 'option2', '3')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (23, 'option3', '2')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (23, 'numA', '1')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (23, 'numB', '3')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (23, 'operator', '+')
    ''');

    // GAME TRỪ
    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (4, 4, '1', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (24, 'option1', '1')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (24, 'option2', '3')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (24, 'option3', '2')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (24, 'numA', '2')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (24, 'numB', '1')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (24, 'operator', '-')
    ''');

    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (4, 4, '2', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (25, 'option1', '4')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (25, 'option2', '3')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (25, 'option3', '2')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (25, 'numA', '3')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (25, 'numB', '1')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (25, 'operator', '-')
    ''');

    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (4, 4, '1', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (26, 'option1', '4')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (26, 'option2', '2')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (26, 'option3', '1')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (26, 'numA', '3')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (26, 'numB', '2')
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (26, 'operator', '-')
    ''');

    //GAME CHỌN HÌNH
    // 0: circle
    // 1: square
    // 2: rectangle
    // 3: triangle
    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (2, 2, '0', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (27, 'numberCorrect', '4')
    ''');
    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (2, 2, '1', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (28, 'numberCorrect', '2')
    ''');
    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (2, 2, '2', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (29, 'numberCorrect', '2')
    ''');
    await db
        .execute('''INSERT INTO Games(lessonid, gametypeid, result, iscomplete)
    VALUES (2, 2, '3', 0)
    ''');
    await db.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (30, 'numberCorrect', '5')
    ''');
  }

  Future<List<Lesson>> getAllLesson() async {
    Database db = await dbHelper.database;

    var lessonQuery = await db.query(lessonTable);

    var lessons = lessonQuery.map((x) => Lesson.fromMap(x)).toList();

    return await Future.wait(lessons.map((lesson) async {
      List<Game> games = await getGameByLessonId(lesson.id);
      lesson.totalGame = games?.length;
      lesson.games = games;
      lesson.completedGame = games.fold(
          0, (value, element) => element.isCompleted ? value + 1 : value);
      return lesson;
    }));
  }

  Future<List<Game>> getGameByLessonId(int lessonId) async {
    Database db = await dbHelper.database;
    var gameQuery =
        await db.query(gameTable, where: "lessonId = ?", whereArgs: [lessonId]);

    var games = gameQuery.map((x) => Game.fromMap(x)).toList();

    return games;
  }

  Future getById(String tableName, int id) async {
    Database db = await dbHelper.database;
    var res = await db.query(tableName, where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? res.first : null;
  }

  Future<Map<String, dynamic>> getGameClaimsByGameId(int gameId) async {
    Database db = await dbHelper.database;
    var gameClaimsQuery = await db
        .query(gameClaimTable, where: "gameId = ?", whereArgs: [gameId]);

    List<GameClaim> gameClaims =
        gameClaimsQuery.map((x) => GameClaim.fromMap(x)).toList();

    var result = Map<String, dynamic>.fromIterable(gameClaims,
        key: (e) => e.key, value: (e) => e.value);

    return result;
  }

  Future _createTable(Database db) async {
    await db.execute('''CREATE TABLE Lessons (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      image TEXT,
      completedGame INTEGER)
    ''');

    await db.execute('''CREATE TABLE GameTypes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT)
    ''');

    await db.execute('''CREATE TABLE Games (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      result TEXT,
      isComplete BOOL,
      lessonId INTEGER,
      gameTypeId INTEGER,
      FOREIGN KEY (lessonId) REFERENCES Lesson (id),
      FOREIGN KEY (gameTypeId) REFERENCES GameType (id))
    ''');

    await db.execute('''CREATE TABLE GameClaims (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      key TEXT,
      value TEXT,
      gameId INTEGER,
      FOREIGN KEY (gameId) REFERENCES Game (id))
    ''');
  }

  Future _createLessons(Database db) async {
    await db.insert(lessonTable, {
      'title': 'Đếm các số trong phạm vi 10',
      'image': 'mars.png',
      'completedgame': 0,
    });
    await db.insert(lessonTable, {
      'title': 'Hình vuông - Hình tròn\nHình tam giác - Hình chữ nhật',
      'image': 'earth.png',
      'completedgame': 0,
    });
    await db.insert(lessonTable, {
      'title': 'Nhiều hơn - Ít hơn - Bằng nhau',
      'image': 'mercury.png',
      'completedgame': 0,
    });
    await db.insert(lessonTable, {
      'title': 'Phép cộng trong phạm vi 10',
      'image': 'moon.png',
      'completedgame': 0,
    });
    await db.insert(lessonTable, {
      'title': 'Phép trừ trong phạm vi 10',
      'image': 'neptune.png',
      'completedgame': 0,
    });
  }

  Future _createGameTypes(Database db) async {
    await db.execute('''INSERT INTO GameTypes (title)
    VALUES ('CountingGame')
    ''');

    await db.execute('''INSERT INTO GameTypes (title)
    VALUES ('ShapeGame')
    ''');

    await db.execute('''INSERT INTO GameTypes (title)
    VALUES ('ComparisonGame')
    ''');

    await db.execute('''INSERT INTO GameTypes (title)
    VALUES ('AdditionAndSubtractionGame')
    ''');

    //INSERT INTO GameTypes (title)
    //VALUES ('SubtractionGame');
  }
}
