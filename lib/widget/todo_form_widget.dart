import 'package:flutter/material.dart';

enum TodoFormNotificationType {
  title,
  description,
  save,
  cancel
}

class TodoFormNotification extends Notification {
  final TodoFormNotificationType type;
  final String? title;
  final String? description;
  
  TodoFormNotification(
    this.type,
    this.title,
    this.description
  );

  factory TodoFormNotification.descriptionNotification(String description) {
    return TodoFormNotification(
      TodoFormNotificationType.description,
      null, 
      description);
  }

  factory TodoFormNotification.titleNotification(String title) {
    return TodoFormNotification(
      TodoFormNotificationType.title,
      title,
      null);
  }
}

class TodoFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onSavedTodo;
  final VoidCallback onCancelTodo;


  const TodoFormWidget({ 
    Key? key,
    this.title = '',
    this.description = '',
    required this.onSavedTodo,
    required this.onCancelTodo
    }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildTitle(context),
          const SizedBox(height: 8),
          buildDescription(context),
          const SizedBox(height: 32),
          Row(children: <Widget>[
            buildCancelButton(),
            const SizedBox(width: 8),
            buildSaveButton()
          ]),
        ],
      )
    );
  }


  Widget buildTitle(BuildContext context) => TextFormField(
    maxLines: 1,
    initialValue: title,
    onChanged:  (val) { TodoFormNotification.titleNotification(val).dispatch(context); },
    validator: (title) {
      if(title != null && title.isEmpty) {
        return 'The title cannot be empty';
      }

      return null;
    },
    decoration: const InputDecoration(
      border: UnderlineInputBorder(),
      label: Text('Title')
    ),
  );


 Widget buildDescription(BuildContext context) => TextFormField(
    maxLines: 3,
    initialValue: description,
    onChanged: (val) { TodoFormNotification.descriptionNotification(val).dispatch(context); },
    decoration: const InputDecoration(
      border: UnderlineInputBorder(),
      label: Text('Description')
    ),
  );


  Widget buildSaveButton() => Expanded(
    flex: 5,
    child: ElevatedButton(
        onPressed: onSavedTodo,
        child: const Text('Save')
      )
  );

  Widget buildCancelButton() => Expanded(
    flex: 5,
    child: ElevatedButton(
        onPressed: onCancelTodo,
        child: const Text('Cancel')
      )
  );

}