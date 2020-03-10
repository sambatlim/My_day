import 'package:my_day/dao/dao.dart';
import 'package:my_day/model/model.dart';

class DatabaseRepository {
  final diaryDao = DataAccessObject();

  Future getAllDiary({String query}) => diaryDao.getDiary(query: query);

  Future insertDiary(DiaryModel diary) => diaryDao.createTodo(diary);

  Future updateTodo(DiaryModel diary) => diaryDao.updateDiary(diary);

  Future deleteTodoById(int id) => diaryDao.deleteDiary(id);
}
