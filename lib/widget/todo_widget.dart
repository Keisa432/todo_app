import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/provider/todos.dart';
import 'package:todo_app/utils.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;


  const TodoWidget ({ 
    Key? key,
    required this.todo
    }) : super(key: key);


  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: Slidable(
      key:  Key(todo.id),
      startActionPane: ActionPane(
      // A motion is a widget used to control how the pane animates.
      motion: const ScrollMotion(),
      // All actions are defined in the children parameter.
      children:  [
        // A SlidableAction can have an icon and/or a label.
        SlidableAction(
          onPressed: (_) {},
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          icon: Icons.edit,
          label: 'Edit',
        ),
      ],
    ),
    endActionPane: ActionPane(
      // A motion is a widget used to control how the pane animates.
      motion: const ScrollMotion(),
      // All actions are defined in the children parameter.
      children:  [
        // A SlidableAction can have an icon and/or a label.
        SlidableAction(
          onPressed: (context) => deleteTodo(context, todo),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
        ),
      ],
    ),
      child: buildTodo(context),
    )
  );
  
  
  Widget buildTodo (context) => Container (
    color: Colors.white,
    padding: const EdgeInsets.all(20),
    child: Row(
      children: [
        Checkbox(
          activeColor: Theme.of(context).primaryColor,
          checkColor: Colors.white,
          value: todo.isCompleted,
          onChanged: (_) {
            final provider =
                Provider.of<TodosProvider>(context, listen: false);
            final isDone = provider.toggleTodoStatus(todo);

            Utils.showSnackBar(
              context,
              isDone ? 'Task completed' : 'Task is incomplete');
          },
          ),
          const SizedBox(height: 8, width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    fontSize: 22
                  ),
                ),
                if(todo.description.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    child: Text(
                      todo.description,
                      style: const TextStyle(fontSize: 20, height: 1.5),
                    )
                  )
              ],
            )
          )
      ],
    )
  );

  void deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(todo);

    Utils.showSnackBar(context, 'Deleted the task');
  }
}