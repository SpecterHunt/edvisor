// ignore_for_file: prefer_conditional_assignment, unnecessary_null_comparison

import 'package:intl/intl.dart';
import 'package:revision_planner/models/stats.dart';
import 'package:revision_planner/models/topics.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final String tableName = 'Topics';
  final String columnTitle = 'title';
  final String columnId = 'id';
  final String columnInfo = 'info';
  final String columnDifficulty = 'difficulty';
  final String columnCurDate = 'curDate';
  final String revDate1 = 'revDate1';
  final String revDate2 = 'revDate2';
  final String revDate3 = 'revDate3';
  final String revDate4 = 'revDate4';
  final String revDate5 = 'revDate5';
  final String revDate6 = 'revDate6';
  final String revDate7 = 'revDate7';
  final String completed = 'completed';
  final String pending = 'pending';
  final String lastRevised = 'lastRevised';
  final String newTableName = 'DaywiseStats';
  final String newTopics = 'newTopics';
  static Database? _database;

  static var curDate = DateTime.now();
  static var newFormat = DateFormat('dd-MM-yyyy');
  static var formattedCurDate = newFormat.format(curDate);
  DatabaseHelper._privateCunstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateCunstructor();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initialiseDatabase();

    return _database;
  }

  Future<Database> initialiseDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "topics.db";
    var database =
        await openDatabase(path, version: 10, onCreate: (db, version) async {
      await db.execute('''
          CREATE table $tableName (
            $columnId integer primary key autoincrement,
            $columnTitle text not null,
            $columnInfo text,
            $columnDifficulty text not null,
            $columnCurDate text not null,
            $revDate1 text,
            $revDate2 text,
            $revDate3 text,
            $revDate4 text,
            $revDate5 text default null,
            $revDate6 text default null,
            $lastRevised text default null,
            $pending text default 'yes',
          )
           ''');
      await db.execute('''
      create TABLE $newTableName (
        $columnId integer primary key autoincrement,
        $columnCurDate String not null,
        $newTopics integer,
        $completed integer,
        $pending integer
       )
      ''');
    }, onUpgrade: _onUpgrade);
    return database;
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      db.execute('''
      create TABLE $newTableName (
        $columnId integer primary key autoincrement,
        $columnCurDate String not null,
        $newTopics integer,
        $completed integer,
        $pending integer
       )
      ''');
    }
  }

  Future<int?> insertTopic(Topics topic) async {
    final db = await database;
    var res = await db!.insert(tableName, topic.toMap());
    return res;
  }

  Future<List<Topics>> fetchTodayTopics() async {
    final db = await instance.database;
    List<Map<String, dynamic>> res = await db!
        .query(tableName, where: 'curDate = ?', whereArgs: [formattedCurDate]);
    return List.generate(res.length, (i) {
      return Topics(
          difficulty: res[i]['difficulty'],
          title: res[i]['title'],
          id: res[i]['id'],
          info: res[i]['info'],
          curDate: res[i]['curDate'],
          revDate1: res[i]['revDate1'],
          revDate2: res[i]['revDate2'],
          revDate3: res[i]['revDate3'],
          revDate4: res[i]['revDate4'],
          revDate5: res[i]['revDate5'],
          revDate6: res[i]['revDate6']);
    });
  }

  Future<List<Topics>> fetchAllTopics() async {
    final db = await instance.database;
    List<Map<String, dynamic>> res = await db!.query(tableName);
    return List.generate(res.length, (i) {
      return Topics(
        difficulty: res[i]['difficulty'],
        title: res[i]['title'],
        id: res[i]['id'],
        info: res[i]['info'],
        curDate: res[i]['curDate'],
        revDate1: res[i]['revDate1'],
        revDate2: res[i]['revDate2'],
        revDate3: res[i]['revDate3'],
        revDate4: res[i]['revDate4'],
        revDate5: res[i]['revDate5'],
        revDate6: res[i]['revDate6'],
        lastRevised: res[i]['lastRevised'],
      );
    });
  }

  Future<List<Topics>> fetchRevisionTopics() async {
    final db = await instance.database;
    List<Map<String, dynamic>> res = await db!.query(tableName,
        where:
            '($revDate1 = ? or $revDate2 = ? or $revDate3 = ? or $revDate4 = ? or $revDate5 = ? or $revDate6 = ?) and ($lastRevised != ? or $lastRevised is null)',
        whereArgs: [
          formattedCurDate,
          formattedCurDate,
          formattedCurDate,
          formattedCurDate,
          formattedCurDate,
          formattedCurDate,
          formattedCurDate
        ]);
    return List.generate(res.length, (i) {
      return Topics(
        difficulty: res[i]['difficulty'],
        title: res[i]['title'],
        id: res[i]['id'],
        info: res[i]['info'],
        curDate: res[i]['curDate'],
        revDate1: res[i]['revDate1'],
        revDate2: res[i]['revDate2'],
        revDate3: res[i]['revDate3'],
        revDate4: res[i]['revDate4'],
        revDate5: res[i]['revDate5'],
        revDate6: res[i]['revDate6'],
        lastRevised: res[i]['lastRevised'],
      );
    });
  }

  Future<void> onDone2(int? id) async {
    final db = await instance.database;
    final Map<String, String> temp = {
      'pending': 'no',
      'lastRevised': formattedCurDate
    };

    await db!.update(tableName, temp, where: 'id = ?', whereArgs: [id]);
  }

  void setPending() async {
    final db = await instance.database;
    final Map<String, String> temp = {'pending': 'yes'};
    await db!.update(tableName, temp,
        where:
            '($revDate1 = ? or $revDate2 = ? or $revDate3 = ? or $revDate4 = ? or $revDate5 = ? or $revDate6 = ?) and ($lastRevised != ? or $lastRevised is null) and $pending = ?',
        whereArgs: [
          formattedCurDate,
          formattedCurDate,
          formattedCurDate,
          formattedCurDate,
          formattedCurDate,
          formattedCurDate,
          formattedCurDate,
          'no',
        ]);
  }

  Future<List<Topics>> fetchPendingTopics() async {
    final db = await instance.database;
    List<Map<String, dynamic>> res = await db!.query(tableName,
        where:
            '$revDate1 != ? and $revDate2 != ? and $revDate3 != ? and $revDate4 != ? and ($revDate5 != ? or $revDate5 is null) and ($revDate6 != ? or $revDate6 is null) and pending = ? and $columnCurDate != ?',
        whereArgs: [
          formattedCurDate,
          formattedCurDate,
          formattedCurDate,
          formattedCurDate,
          formattedCurDate,
          formattedCurDate,
          'yes',
          formattedCurDate,
        ]);

    return List.generate(res.length, (i) {
      return Topics(
        difficulty: res[i]['difficulty'],
        title: res[i]['title'],
        id: res[i]['id'],
        info: res[i]['info'],
        curDate: res[i]['curDate'],
        revDate1: res[i]['revDate1'],
        revDate2: res[i]['revDate2'],
        revDate3: res[i]['revDate3'],
        revDate4: res[i]['revDate4'],
        revDate5: res[i]['revDate5'],
        revDate6: res[i]['revDate6'],
        lastRevised: res[i]['lastRevised'],
      );
    });
  }

  Future<void> deleteTopic(int? id) async {
    final db = await instance.database;
    await db!.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> dsNewEntry() async {
    final db = await instance.database;
    final List<Map> res = await db!.query(newTableName,
        where: '$columnCurDate = ?', whereArgs: [formattedCurDate]);
    if (res.isEmpty) {
      final Stats temp = Stats(
          curDate: formattedCurDate, newTopics: 0, completed: 0, pending: 0);
      await db.insert(newTableName, temp.toMap());
    }
  }

  Future<void> dsNewTopic() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> res = await db!.query(newTableName,
        where: '$columnCurDate = ?', whereArgs: [formattedCurDate]);
    int n = res.first[newTopics];
    Map<String, int> temp = {newTopics: n + 1};
    await db.update(newTableName, temp,
        where: '$columnCurDate = ?', whereArgs: [formattedCurDate]);
  }

  Future<void> dsNewTopicDelete() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> res = await db!.query(newTableName,
        where: '$columnCurDate = ?', whereArgs: [formattedCurDate]);
    int n = res.first[newTopics];
    Map<String, int> temp = {newTopics: n - 1};
    await db.update(newTableName, temp,
        where: '$columnCurDate = ?', whereArgs: [formattedCurDate]);
  }

  Future<void> dsRevised(int len) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> res = await db!.query(newTableName,
        where: '$columnCurDate = ?', whereArgs: [formattedCurDate]);
    int n = res.first[completed];
    Map<String, int> temp = {completed: n + 1, pending: len};
    await db.update(newTableName, temp,
        where: '$columnCurDate = ?', whereArgs: [formattedCurDate]);
  }

  Future<void> dsPending(int len) async {
    final db = await instance.database;
    Map<String, int> temp = {pending: len};
    await db!.update(newTableName, temp,
        where: '$columnCurDate = ?', whereArgs: [formattedCurDate]);
  }

  Future<List<Stats>> dsFetchAllStats() async {
    final db = await instance.database;
    List<Map<String, dynamic>> res = await db!.query(newTableName,
        where: '$columnCurDate != ?', whereArgs: [formattedCurDate]);
    return List.generate(res.length, (i) {
      return Stats(
          curDate: res[i][columnCurDate],
          completed: res[i][completed],
          pending: res[i][pending],
          newTopics: res[i][newTopics],
          id: res[i][columnId]);
    });
  }
}
