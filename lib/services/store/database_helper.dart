import 'dart:io';
import 'package:math_app_for_kid/models/local/gameClaims.dart';
import 'package:math_app_for_kid/models/local/games.dart';
import 'package:math_app_for_kid/models/local/lessons.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper dbHelper = DatabaseHelper._();

  static final String gameClaimTable = 'GameClaims';
  static final String gameTable = 'Games';
  static final String gameTypeTable = 'GameTypes';
  static final String lessonTable = 'Lessons';

  static Database _database;
  static final _dbName = 'math_app_for_kids.db';
  static final _dbVersion = 1;

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
      onUpgrade: _onUpgrade,
    );
  }

  _onCreate(Database db, int version) async {
    var batch = db.batch();

    _createTables(batch);
    _insertLessons(batch);
    _insertGameTypes(batch);
    _insertGames(batch);
    // _insertGameToDbV2(batch);
    // _insertGameToDbV3(batch);

    await batch.commit();
  }

  _insertGames(Batch batch) {
    // GAME ĐẾM SỐ
    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (1, 1, 1, '2', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (1, 'option1', '6')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (1, 'option2', '7')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (1, 'option3', '2')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (2, 1, 1, '1', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (2, 'option1', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (2, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (2, 'option3', '2')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (3, 1, 1, '8', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (3, 'option1', '8')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (3, 'option2', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (3, 'option3', '5')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (4, 1, 1, '6', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (4, 'option1', '9')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (4, 'option2', '6')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (4, 'option3', '2')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (5, 1, 1, '3', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (5, 'option1', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (5, 'option2', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (5, 'option3', '1')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (6, 1, 1, '10', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (6, 'option1', '8')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (6, 'option2', '10')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (6, 'option3', '7')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (7, 1, 1, '4', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (7, 'option1', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (7, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (7, 'option3', '4')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (8, 1, 1, '9', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (8, 'option1', '6')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (8, 'option2', '9')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (8, 'option3', '2')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (9, 1, 1, '5', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (9, 'option1', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (9, 'option2', '6')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (9, 'option3', '8')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (10, 1, 1, '7', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (10, 'option1', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (10, 'option2', '7')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (10, 'option3', '3')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (11, 1, 1, '3', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (11, 'option1', '6')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (11, 'option2', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (11, 'option3', '3')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (12, 1, 1, '2', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (12, 'option1', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (12, 'option2', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (12, 'option3', '8')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (13, 1, 1, '5', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (13, 'option1', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (13, 'option2', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (13, 'option3', '3')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (14, 1, 1, '7', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (14, 'option1', '9')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (14, 'option2', '7')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (14, 'option3', '8')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (15, 1, 1, '4', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (15, 'option1', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (15, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (15, 'option3', '6')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (16, 1, 1, '1', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (16, 'option1', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (16, 'option2', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (16, 'option3', '1')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (17, 1, 1, '10', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (17, 'option1', '8')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (17, 'option2', '10')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (17, 'option3', '9')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (18, 1, 1, '6', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (18, 'option1', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (18, 'option2', '6')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (18, 'option3', '4')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (19, 1, 1, '9', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (19, 'option1', '9')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (19, 'option2', '6')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (19, 'option3', '7')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (20, 1, 1, '8', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (20, 'option1', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (20, 'option2', '8')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (20, 'option3', '6')
    ''');

    // GAME SO SÁNH
    // 0: >
    // 1: =
    // 2: <
    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (21, 3, 3, '2', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (21, 'option1', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (21, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (21, 'option3', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (21, 'numA', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (21, 'numB', '5')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (22, 3, 3, '1', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (22, 'option1', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (22, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (22, 'option3', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (22, 'numA', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (22, 'numB', '4')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (23, 3, 3, '0', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (23, 'option1', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (23, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (23, 'option3', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (23, 'numA', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (23, 'numB', '2')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (24, 3, 3, '2', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (24, 'option1', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (24, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (24, 'option3', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (24, 'numA', '7')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (24, 'numB', '9')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (25, 3, 3, '1', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (25, 'option1', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (25, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (25, 'option3', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (25, 'numA', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (25, 'numB', '2')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (26, 3, 3, '2', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (26, 'option1', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (26, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (26, 'option3', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (26, 'numA', '9')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (26, 'numB', '10')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (27, 3, 3, '0', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (27, 'option1', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (27, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (27, 'option3', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (27, 'numA', '8')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (27, 'numB', '6')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (28, 3, 3, '0', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (28, 'option1', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (28, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (28, 'option3', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (28, 'numA', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (28, 'numB', '1')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (29, 3, 3, '1', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (29, 'option1', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (29, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (29, 'option3', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (29, 'numA', '7')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (29, 'numB', '7')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (30, 3, 3, '2', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (30, 'option1', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (30, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (30, 'option3', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (30, 'numA', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (30, 'numB', '7')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (31, 3, 3, '2', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (31, 'option1', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (31, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (31, 'option3', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (31, 'numA', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (31, 'numB', '10')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (32, 3, 3, '1', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (32, 'option1', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (32, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (32, 'option3', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (32, 'numA', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (32, 'numB', '5')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (33, 3, 3, '0', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (33, 'option1', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (33, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (33, 'option3', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (33, 'numA', '9')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (33, 'numB', '8')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (34, 3, 3, '0', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (34, 'option1', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (34, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (34, 'option3', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (34, 'numA', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (34, 'numB', '3')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (35, 3, 3, '2', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (35, 'option1', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (35, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (35, 'option3', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (35, 'numA', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (35, 'numB', '3')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (36, 3, 3, '2', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (36, 'option1', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (36, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (36, 'option3', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (36, 'numA', '7')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (36, 'numB', '10')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (37, 3, 3, '1', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (37, 'option1', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (37, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (37, 'option3', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (37, 'numA', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (37, 'numB', '3')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (38, 3, 3, '0', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (38, 'option1', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (38, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (38, 'option3', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (38, 'numA', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (38, 'numB', '1')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (39, 3, 3, '0', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (39, 'option1', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (39, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (39, 'option3', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (39, 'numA', '8')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (39, 'numB', '4')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (40, 3, 3, '2', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (40, 'option1', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (40, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (40, 'option3', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (40, 'numA', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (40, 'numB', '6')
    ''');

    // GAME CỘNG
    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (41, 4, 4, '2', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (41, 'option1', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (41, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (41, 'option3', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (41, 'numA', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (41, 'numB', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (41, 'operator', '+')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (42, 4, 4, '3', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (42, 'option1', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (42, 'option2', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (42, 'option3', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (42, 'numA', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (42, 'numB', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (42, 'operator', '+')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (43, 4, 4, '6', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (43, 'option1', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (43, 'option2', '6')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (43, 'option3', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (43, 'numA', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (43, 'numB', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (43, 'operator', '+')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (44, 4, 4, '4', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (44, 'option1', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (44, 'option2', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (44, 'option3', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (44, 'numA', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (44, 'numB', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (44, 'operator', '+')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (45, 4, 4, '6', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (45, 'option1', '6')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (45, 'option2', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (45, 'option3', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (45, 'numA', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (45, 'numB', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (45, 'operator', '+')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (46, 4, 4, '6', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (46, 'option1', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (46, 'option2', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (46, 'option3', '6')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (46, 'numA', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (46, 'numB', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (46, 'operator', '+')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (47, 4, 4, '5', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (47, 'option1', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (47, 'option2', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (47, 'option3', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (47, 'numA', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (47, 'numB', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (47, 'operator', '+')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (48, 4, 4, '5', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (48, 'option1', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (48, 'option2', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (48, 'option3', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (48, 'numA', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (48, 'numB', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (48, 'operator', '+')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (49, 4, 4, '5', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (49, 'option1', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (49, 'option2', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (49, 'option3', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (49, 'numA', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (49, 'numB', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (49, 'operator', '+')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (50, 4, 4, '7', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (50, 'option1', '6')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (50, 'option2', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (50, 'option3', '7')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (50, 'numA', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (50, 'numB', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (50, 'operator', '+')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (51, 4, 4, '8', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (51, 'option1', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (51, 'option2', '8')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (51, 'option3', '9')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (51, 'numA', '7')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (51, 'numB', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (51, 'operator', '+')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (52, 4, 4, '5', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (52, 'option1', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (52, 'option2', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (52, 'option3', '7')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (52, 'numA', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (52, 'numB', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (52, 'operator', '+')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (53, 4, 4, '9', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (53, 'option1', '9')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (53, 'option2', '8')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (53, 'option3', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (53, 'numA', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (53, 'numB', '9')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (53, 'operator', '+')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (54, 4, 4, '7', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (54, 'option1', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (54, 'option2', '7')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (54, 'option3', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (54, 'numA', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (54, 'numB', '6')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (54, 'operator', '+')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (55, 4, 4, '4', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (55, 'option1', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (55, 'option2', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (55, 'option3', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (55, 'numA', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (55, 'numB', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (55, 'operator', '+')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (56, 4, 4, '8', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (56, 'option1', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (56, 'option2', '9')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (56, 'option3', '8')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (56, 'numA', '7')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (56, 'numB', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (56, 'operator', '+')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (57, 4, 4, '10', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (57, 'option1', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (57, 'option2', '6')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (57, 'option3', '10')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (57, 'numA', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (57, 'numB', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (57, 'operator', '+')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (58, 4, 4, '9', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (58, 'option1', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (58, 'option2', '9')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (58, 'option3', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (58, 'numA', '6')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (58, 'numB', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (58, 'operator', '+')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (59, 4, 4, '10', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (59, 'option1', '6')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (59, 'option2', '10')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (59, 'option3', '7')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (59, 'numA', '10')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (59, 'numB', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (59, 'operator', '+')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (60, 4, 4, '9', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (60, 'option1', '9')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (60, 'option2', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (60, 'option3', '7')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (60, 'numA', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (60, 'numB', '6')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (60, 'operator', '+')
    ''');

    // GAME TRỪ
    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (61, 5, 4, '1', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (61, 'option1', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (61, 'option2', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (61, 'option3', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (61, 'numA', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (61, 'numB', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (61, 'operator', '-')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (62, 5, 4, '2', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (62, 'option1', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (62, 'option2', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (62, 'option3', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (62, 'numA', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (62, 'numB', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (62, 'operator', '-')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (63, 5, 4, '0', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (63, 'option1', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (63, 'option2', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (63, 'option3', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (63, 'numA', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (63, 'numB', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (63, 'operator', '-')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (64, 5, 4, '1', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (64, 'option1', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (64, 'option2', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (64, 'option3', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (64, 'numA', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (64, 'numB', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (64, 'operator', '-')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (65, 5, 4, '3', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (65, 'option1', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (65, 'option2', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (65, 'option3', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (65, 'numA', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (65, 'numB', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (65, 'operator', '-')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (66, 5, 4, '0', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (66, 'option1', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (66, 'option2', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (66, 'option3', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (66, 'numA', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (66, 'numB', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (66, 'operator', '-')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (67, 5, 4, '3', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (67, 'option1', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (67, 'option2', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (67, 'option3', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (67, 'numA', '6')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (67, 'numB', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (67, 'operator', '-')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (68, 5, 4, '1', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (68, 'option1', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (68, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (68, 'option3', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (68, 'numA', '6')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (68, 'numB', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (68, 'operator', '-')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (69, 5, 4, '0', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (69, 'option1', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (69, 'option2', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (69, 'option3', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (69, 'numA', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (69, 'numB', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (69, 'operator', '-')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (70, 5, 4, '5', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (70, 'option1', '7')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (70, 'option2', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (70, 'option3', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (70, 'numA', '7')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (70, 'numB', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (70, 'operator', '-')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (71, 5, 4, '8', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (71, 'option1', '7')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (71, 'option2', '8')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (71, 'option3', '9')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (71, 'numA', '10')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (71, 'numB', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (71, 'operator', '-')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (72, 5, 4, '1', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (72, 'option1', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (72, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (72, 'option3', '7')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (72, 'numA', '8')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (72, 'numB', '7')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (72, 'operator', '-')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (73, 5, 4, '4', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (73, 'option1', '6')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (73, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (73, 'option3', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (73, 'numA', '9')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (73, 'numB', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (73, 'operator', '-')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (74, 5, 4, '2', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (74, 'option1', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (74, 'option2', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (74, 'option3', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (74, 'numA', '7')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (74, 'numB', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (74, 'operator', '-')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (75, 5, 4, '1', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (75, 'option1', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (75, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (75, 'option3', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (75, 'numA', '7')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (75, 'numB', '6')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (75, 'operator', '-')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (76, 5, 4, '3', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (76, 'option1', '0')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (76, 'option2', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (76, 'option3', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (76, 'numA', '9')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (76, 'numB', '6')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (76, 'operator', '-')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (77, 5, 4, '4', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (77, 'option1', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (77, 'option2', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (77, 'option3', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (77, 'numA', '8')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (77, 'numB', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (77, 'operator', '-')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (78, 5, 4, '5', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (78, 'option1', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (78, 'option2', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (78, 'option3', '6')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (78, 'numA', '10')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (78, 'numB', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (78, 'operator', '-')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (79, 5, 4, '2', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (79, 'option1', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (79, 'option2', '3')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (79, 'option3', '2')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (79, 'numA', '10')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (79, 'numB', '8')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (79, 'operator', '-')
    ''');

    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (80, 5, 4, '9', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (80, 'option1', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (80, 'option2', '9')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (80, 'option3', '7')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (80, 'numA', '10')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (80, 'numB', '1')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (80, 'operator', '-')
    ''');

    //GAME CHỌN HÌNH
    // 0: circle
    // 1: square
    // 2: rectangle
    // 3: triangle
    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (81, 2, 2, '0', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (81, 'numberCorrect', '4')
    ''');
    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (82, 2, 2, '1', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (82, 'numberCorrect', '2')
    ''');
    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (83, 2, 2, '2', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (83, 'numberCorrect', '2')
    ''');
    batch.execute(
        '''INSERT INTO Games(id, lessonId, gameTypeId, result, isCompleted)
    VALUES (84, 2, 2, '3', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (84, 'numberCorrect', '5')
    ''');
  }

  _createTables(Batch batch) {
    batch.execute('''CREATE TABLE Lessons (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      image TEXT,
      completedGame INTEGER)
    ''');

    batch.execute('''CREATE TABLE GameTypes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT)
    ''');

    batch.execute('''CREATE TABLE Games (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      result TEXT,
      isCompleted BOOL,
      lessonId INTEGER,
      gameTypeId INTEGER,
      FOREIGN KEY (lessonId) REFERENCES Lesson (id),
      FOREIGN KEY (gameTypeId) REFERENCES GameType (id))
    ''');

    batch.execute('''CREATE TABLE GameClaims (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      key TEXT,
      value TEXT,
      gameId INTEGER,
      FOREIGN KEY (gameId) REFERENCES Game (id))
    ''');
  }

  _insertLessons(Batch batch) {
    batch.insert(lessonTable, {
      'title': 'Đếm các số trong phạm vi 10',
      'image': 'mars.png',
      'completedgame': 0,
    });
    batch.insert(lessonTable, {
      'title': 'Hình vuông - Hình tròn\nHình tam giác - Hình chữ nhật',
      'image': 'earth.png',
      'completedgame': 0,
    });
    batch.insert(lessonTable, {
      'title': 'Nhiều hơn - Ít hơn - Bằng nhau',
      'image': 'mercury.png',
      'completedgame': 0,
    });
    batch.insert(lessonTable, {
      'title': 'Phép cộng trong phạm vi 10',
      'image': 'moon.png',
      'completedgame': 0,
    });
    batch.insert(lessonTable, {
      'title': 'Phép trừ trong phạm vi 10',
      'image': 'neptune.png',
      'completedgame': 0,
    });
  }

  _insertGameTypes(Batch batch) {
    batch.execute('''INSERT INTO GameTypes (title)
    VALUES ('CountingGame')
    ''');

    batch.execute('''INSERT INTO GameTypes (title)
    VALUES ('ShapeGame')
    ''');

    batch.execute('''INSERT INTO GameTypes (title)
    VALUES ('ComparisonGame')
    ''');

    batch.execute('''INSERT INTO GameTypes (title)
    VALUES ('AdditionAndSubtractionGame')
    ''');
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    var batch = db.batch();
    if (oldVersion != newVersion) {
      switch (oldVersion) {
        case 1:
          _insertGameToDbV2(batch);
          _insertGameToDbV3(batch);
          break;

        case 2:
          _insertGameToDbV3(batch);
          break;
      }
    }
    await batch.commit();
  }

  void _insertGameToDbV2(Batch batch) {
    batch
        .execute('''INSERT INTO Games(lessonId, gameTypeId, result, isCompleted)
    VALUES (1, 1, '8', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (31, 'option1', '6')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (31, 'option2', '7')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (31, 'option3', '8')
    ''');

    batch
        .execute('''INSERT INTO Games(lessonId, gameTypeId, result, isCompleted)
    VALUES (1, 1, '4', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (32, 'option1', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (32, 'option2', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (32, 'option3', '6')
    ''');
  }

  void _insertGameToDbV3(Batch batch) {
    batch
        .execute('''INSERT INTO Games(lessonId, gameTypeId, result, isCompleted)
    VALUES (1, 1, '8', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (33, 'option1', '6')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (33, 'option2', '7')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (33, 'option3', '8')
    ''');

    batch
        .execute('''INSERT INTO Games(lessonId, gameTypeId, result, isCompleted)
    VALUES (1, 1, '4', 0)
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (34, 'option1', '4')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (34, 'option2', '5')
    ''');
    batch.execute('''INSERT INTO GameClaims(gameId, key, value)
    VALUES (34, 'option3', '6')
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

  Future updateGame(Game game) async {
    Database db = await dbHelper.database;
    return await db.update(
      gameTable,
      game.toMap(),
      where: "id = ?",
      whereArgs: [game.id],
    );
  }
}
