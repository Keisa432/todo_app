import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/provider/todos.dart';
import 'package:todo_app/widget/todo_form_widget.dart';

class EditTodoPage extends StatefulWidget {
  final Todo todo;

  const EditTodoPage({ Key? key, required this.todo}) : super(key: key);

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  void initState() {
    super.initState();

    title = widget.todo.title;
    description = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Edit Todo'),
      actions: [
        deleteAction(context)
      ],
    ),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: NotificationListener<TodoFormNotification>(
          onNotification: notificationHandler,
          child: Form(
            key: _formKey,
            child: TodoFormWidget(
            title: title,
            description: description,
            onSavedTodo: updateTodo,
            onCancelTodo: () => Navigator.of(context).pop(),
          ),
        ),
      ),
    )
  );

  void updateTodo() {
    final isValid = _formKey.currentState?.validate();

    if(isValid == null || !isValid) {
      return;
    } else {
      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.updateTodo(widget.todo, title, description);

      Navigator.of(context).pop();
    }
  }

  Widget deleteAction(BuildContext context) => IconButton(
    onPressed: () {
      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.removeTodo(widget.todo);

      Navigator.of(context).pop();
    }, 
    icon: const Icon(Icons.delete),
  );

  bool notificationHandler(TodoFormNotification notification) {
    if(notification.type == TodoFormNotificationType.description) {
      description = notification.description as String;
    }

    if(notification.type == TodoFormNotificationType.title) {
      title = notification.title as String;
    }
    setState(() {});
    return true;
  }
}