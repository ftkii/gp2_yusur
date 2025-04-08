import 'package:flutter/material.dart';
import 'task_tile.dart';
//خطوات الحج وتديث الحاله
class TaskListWidget extends StatefulWidget {
  final List<bool> completedTasks;
  final VoidCallback onUpdate;

  const TaskListWidget({
    super.key,
    required this.completedTasks,
    required this.onUpdate,
  });

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  final List<String> tasks = [
    "Ihram",
    "Tawaf al-Qudum",
    "Sa’i between Safa and Marwah",
    "Standing at Arafat",
    "Muzdalifah Stay",
    "Stoning of the Great Jamarah",
    "Tawaf al-Wada"
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskTile(
          stepNumber: index + 1,
          title: tasks[index],
          isCompleted: widget.completedTasks[index],
          isLast: index == tasks.length - 1,
          onTap: () {
            setState(() {
              widget.completedTasks[index] = !widget.completedTasks[index];
            });
            widget.onUpdate();
          },
        );
      },
    );
  }
}
