import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/database.dart';
import 'package:todo/utils/dialog_box.dart';
import 'package:todo/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _mybox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();
  final _controller = TextEditingController();

  @override
  void initState() {
    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void toDoChecked({required bool? value, required int index}) {
    setState(() {
      db.toDoLists[index][1] = !db.toDoLists[index][1];
    });
    db.updateData();
  }

  void saveTask() {
    setState(() {
      db.toDoLists.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void addNewTask() {
    showDialog(
        context: context,
        builder: (context) => DialogBox(
              textController: _controller,
              onCancel: () => Navigator.of(context).pop(),
              onSave: saveTask,
            ));
  }

  void deleteTask({required int index}) {
    setState(() {
      db.toDoLists.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          elevation: 0,
          title: const Center(
              child: Text(
            "T O D O",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addNewTask,
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ListView.builder(
              itemCount: db.toDoLists.length,
              itemBuilder: (context, index) {
                return TodoTile(
                  onChanged: (value) =>
                      toDoChecked(value: db.toDoLists[index][1], index: index),
                  taskName: db.toDoLists[index][0],
                  taskDone: db.toDoLists[index][1],
                  deleteTask: (context) => deleteTask(index: index),
                );
              }),
        ));
  }
}
