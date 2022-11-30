import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoMainTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final void Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;
  final VoidCallback? onPressed;
  const ToDoMainTile({
    Key? key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    this.deleteFunction,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.only(top: 25, ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
                colors: [Color(0xFF5F0A87), Color(0xFFA4508B)]),
          ),
          child: Column(children: [
            Row(children: [
              //checkbox
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.white,
                checkColor: Colors.black,
              ),
              //task name
              Text(
                taskName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  decoration: taskCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ]),
            GestureDetector(
              onTap: onPressed,
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  color: Colors.white,
                  child: const Center(
                    child: Text(
                      'Assign SubTasks',
                      style: TextStyle(color: Colors.purple, fontSize: 15),
                    ),
                  )),
            ),
          ]),
        ),
      ),
    );
  }
}
