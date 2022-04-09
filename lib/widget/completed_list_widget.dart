import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/todos.dart';
import 'package:todo_app/widget/todo_widget.dart';


/// List containing all completed Tasks
///
class CompletedListWidget extends StatelessWidget {
  const CompletedListWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.completedTodos;
    
    return todos.isEmpty ?
    const Center(
      child: Text ('No Tasks completed', style: TextStyle( fontSize: 20 ))
      ) :
    ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      separatorBuilder: (context, index) => Container(height: 8),
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];

        return TodoWidget(todo: todo);
      },
    );
  }
}