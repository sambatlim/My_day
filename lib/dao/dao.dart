import 'package:my_day/database/database.dart';
import 'package:my_day/model/model.dart';
import 'dart:async';

class DataAccessObject {
  final dbProvider = DatabaseProvider.dbprovider;
  Future<int> createTodo(DiaryModel diary) async {
    final db = await dbProvider.database;
    var result = db.insert(diaryTable, diary.toDatabaseJson());
    return result;
  }

  Future<List<DiaryModel>> getDiary(
      {List<String> columns, String query}) async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> result;

    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(diaryTable,
            columns: columns,
            where: 'description Like ?',
            whereArgs: ["%$query%"]);
    } else {
      result = await db.query(diaryTable, columns: columns);
    }

    List<DiaryModel> diary = result.isNotEmpty
        ? result.map((item) => DiaryModel.fromDatabaseJson(item)).toList()
        : [];
    return diary;
  }

  Future<int> updateDiary(DiaryModel diary) async {
    final db = await dbProvider.database;
    var result = await db.update(diaryTable, diary.toDatabaseJson(),
        where: "id= ?", whereArgs: [diary.id]);
    return result;
  }

  Future<int> deleteDiary(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(diaryTable, where: 'id=?', whereArgs: [id]);
    return result;
  }
}
