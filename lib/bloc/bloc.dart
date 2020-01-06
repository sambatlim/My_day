import 'dart:async';

import 'package:my_day/model/model.dart';
import 'package:my_day/repository/repository.dart';

class DiaryBloc {
  final _diaryRepository = DatabaseRepository();

  final _diaryController = StreamController<List<DiaryModel>>.broadcast();

  get diary => _diaryController.stream;

  DiaryBloc() {
    getDiary();
  }

  getDiary({String query}) async {
    _diaryController.sink.add(await _diaryRepository.getAllDiary(query: query));
  }

  addDiary(DiaryModel diary) async {
    await _diaryRepository.insertDiary(diary);
    getDiary();
  }

  updateDairy(DiaryModel diary) async {
    await _diaryRepository.updateTodo(diary);
    getDiary();
  }

  deleteDiaryById(int id) async {
    _diaryRepository.deleteTodoById(id);
    getDiary();
  }

  dispose() {
    _diaryController.close();
  }
}
