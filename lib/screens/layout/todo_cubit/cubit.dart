import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
//import 'package:todo_app/layout/todo_cubit/states.dart';
import 'package:practise/screens/layout/todo_cubit/states.dart';

import '../../modules/archived_tasks/archived_tasks.dart';
import '../../modules/done_tasks/done_tasks.dart';
import '../../modules/new_tasks/new_tasks.dart';
import '../../shared/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntialState());
  static AppCubit get(context) => BlocProvider.of(context);

  //variables
  int currentIndex = 0;
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;
  late Database database;
  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivedtasks = [];

  List<Widget> screens = [NewTasks(), DoneTasks(), ArchivedTasks()];

  List<String> titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];

  void ChangeNavBar(int index) {
    currentIndex = index;
    emit(AppChangeNavBarState());
  }

  void ChangeBottomSheet({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  void CrateDatabase() async {
    openDatabase('task.db', version: 1, onCreate: (database, version) {
      print('database Created');
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT, status TEXT)')
          .then((value) {
        print('Table Created');
      }).catchError((error) {
        print('error while crating table ${error.toString()}');
      });
    }, onOpen: (database) {
      print('database opened');
      GetDataFromDatabase(database);
    }).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  InsertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO tasks (title, time, date, status) VALUES("$title", "$time", "$date", "new")')
          .then((value) {
        print('$value Inserted successfully');
        emit(AppInsertToDatabaseState());
        GetDataFromDatabase(database);
      }).catchError((error) {
        print('error while inserting data ${error.toString()}');
      });
    });
  }

  Future<List<Map>> GetDataFromDatabase(database) async {
    emit(AppGetDatabaseState());
    return await database.rawQuery('SELECT * FROM tasks').then((value) {
      newtasks = [];
      donetasks = [];
      archivedtasks = [];

      value.forEach((element) {
        if (element['status'] == 'archive') {
          archivedtasks.add(element);
        } else if (element['status'] == 'done') {
          donetasks.add(element);
        } else {
          newtasks.add(element);
        }
      });

      emit(AppGetDatabaseState());
    });
  }

  void UpdateDatabase({required String status, required int id}) async {
    await database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      emit(AppUpdateDatabaseState());
      GetDataFromDatabase(database);
    });
  }

  void DeleteDatabase({required int id}) async {
    await database
        .rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      emit(AppDeleteDatabaseState());
      GetDataFromDatabase(database);
    });
  }

  bool isDark = false;

  void ChangeToDark({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeToDarkState());
    } else {
      isDark = !isDark;
      CacheHelper.setData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeToDarkState());
      });
    }
  }
}
// 'UPDATE tasks SET status = ? WHERE id = ?',
// ['$status', id],
