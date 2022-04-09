import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/widget/todo_form_widget.dart';
import 'package:todo_app/provider/todos.dart';
import 'package:todo_app/model/todo.dart';

class AddTodoDialogWidget extends StatefulWidget {
  const AddTodoDialogWidget({Key? key}) : super(key: key);

  @override
  State<AddTodoDialogWidget> createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: NotificationListener<TodoFormNotification>(
          onNotification: notificationHandler,
          child:  Column(
            mainAxisSize: MainAxisSize.min,
            children:  [
              const Text('Add Todo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                )
              ),
              const SizedBox(height: 8),
              TodoFormWidget(
                onSavedTodo: addTodo,
                onCancelTodo: () => Navigator.of(context).pop(),
              )
          ])
        ),
      ),
    );
  }

  void addTodo() {
    final isValid = _formKey.currentState?.validate();

    if(isValid == null || !isValid) {
      return;
    } else {
      final todo = Todo(
        id: DateTime.now().toString(),
        title: title,
        description: description,
        createTime: DateTime.now()
      );

      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.addTodo(todo);

      Navigator.of(context).pop();
    }
  }

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
