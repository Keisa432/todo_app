import 'package:flutter/cupertino.dart';
import 'package:todo_app/model/todo.dart';

class TodosProvider extends ChangeNotifier {
   final List<Todo> _todos = [
    Todo(
        createTime: DateTime.now(),
        title: 'Walk the Dog'
      ),
      Todo(
        createTime: DateTime.now(),
        title: 'Manuel ist cool',
        description: 'Er kanns einfach'
      ),
      Todo(
        createTime: DateTime.now(),
        title: 'COVID tests',
        description: 'Machen danke dere'
      )
  ];

  ///List of incomplete Todos
  List<Todo> get todos => _todos.where((element) => element.isCompleted == false).toList();

  /// List of completed Todos
  List<Todo> get completedTodos =>_todos.where((element) => element.isCompleted == true).toList();

  void addTodo(Todo todo) {
    _todos.add(todo);

    notifyListeners(); 
  }

  void removeTodo(Todo todo) {
    _todos.remove(todo);

    notifyListeners();
  }

  bool toggleTodoStatus(Todo todo) {
    todo.isCompleted = !todo.isCompleted;
    notifyListeners();

    return todo.isCompleted;
  }
}