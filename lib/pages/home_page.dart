import 'package:flutter/material.dart';
import 'package:todo/utils/dialog_box.dart';
import 'package:todo/utils/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  List toDoLists = [
    ["Make Tutorial", false],
    ["Do Exercises", true],
    ["Go to School", true],
  ];

  void toDoChecked({required bool? value, required int index}) {
    setState(() {
      toDoLists[index][1] = !toDoLists[index][1];
    });
  }

  void saveTask() {
    setState(() {
      toDoLists.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
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
              itemCount: toDoLists.length,
              itemBuilder: (context, index) {
                return TodoTile(
                  onChanged: (value) =>
                      toDoChecked(value: toDoLists[index][1], index: index),
                  taskName: toDoLists[index][0],
                  taskDone: toDoLists[index][1],
                );
              }),
        ));
  }
}
