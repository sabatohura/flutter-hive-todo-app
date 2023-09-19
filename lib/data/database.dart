import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoLists = [];
  final _mybox = Hive.box('mybox');

  // for first time app installer
  void createInitialData() {
    toDoLists = [
      ["Install App", true],
      ["Create your first Todo", false],
    ];
  }

  void loadData() {
    toDoLists = _mybox.get("TODOLIST");
  }

  void updateData() {
    _mybox.put("TODOLIST", toDoLists);
  }
}
