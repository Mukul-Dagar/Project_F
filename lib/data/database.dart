import 'package:hive/hive.dart';

class ToDoDataBase {
  final _myBox = Hive.box('myBox');
  List toDoList = [];

  //run this if opening the app for first time
  void createInitialData () {
    toDoList = [];
  }

  //load the data from database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");

  }

  // update the database
  void updateDataBase () {
    _myBox.put("TODOLIST", toDoList);

  }
}