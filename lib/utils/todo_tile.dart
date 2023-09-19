import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskDone;
  Function(bool?)? onChanged;
  TodoTile({
    super.key,
    required this.onChanged,
    required this.taskName,
    required this.taskDone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.yellow, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Checkbox(
              value: taskDone,
              onChanged: onChanged,
              activeColor: Colors.black,
            ),
            Text(
              taskName,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  decoration: taskDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
          ],
        ),
      ),
    );
  }
}
