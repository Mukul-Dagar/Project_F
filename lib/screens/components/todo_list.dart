import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final void Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;
  const ToDoTile(
      {Key? key,
        required this.taskName,
        required this.taskCompleted,
        required this.onChanged,
        this.deleteFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
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
          padding: const EdgeInsets.all(17.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(colors: [Color(0xFF5F0A87), Color(0xFFA4508B)]),
          ),
          child: Row(children: [
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
        ),
      ),
    );
  }
}
