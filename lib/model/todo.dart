class TodoField {
  static const createdTime = 'createdTime';
}

class Todo {
  String id;
  DateTime createTime;
  String title;
  String description;
  bool isCompleted;

  Todo({
    required this.createTime,
    required this.title,
    this.description = '',
    this.id ='',
    this.isCompleted = false,
  });
}