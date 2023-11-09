import 'package:flutter/material.dart';
import 'package:todoapp/constatnt/colors.dart';
import 'package:todoapp/models/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo toDo;
  final onToDoChanged;
  final onDeleteItem;
  const ToDoItem(
      {super.key,
      required this.toDo,
      required this.onDeleteItem,
      required this.onToDoChanged});
  // const ToDoItem({Key? key,required this.toDo}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onToDoChanged(toDo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: !toDo.isDone
            ? Color.fromARGB(255, 255, 255, 255)
            : Color.fromARGB(255, 173, 211, 179),
        leading: Icon(
          toDo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: theBlue,
        ),
        title: Text(
          toDo.todoText,
          style: TextStyle(
              color: theBlack,
              decoration: toDo.isDone ? TextDecoration.lineThrough : null),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 5),
          width: 39,
          height: 39,
          decoration: BoxDecoration(
            color: theRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: IconButton(
              onPressed: () {
                onDeleteItem(toDo.id);
              },
              color: Colors.white,
              icon: Icon(Icons.delete),
            ),
          ),
        ),
      ),
    );
  }
}
