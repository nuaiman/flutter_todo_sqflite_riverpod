import 'package:flutter/material.dart';

import '../controllers/todo_list_controller.dart';

class CreateTodoField extends StatelessWidget {
  const CreateTodoField({
    super.key,
    required TextEditingController textController,
    required this.todoListProviderNotifier,
  }) : _textController = textController;

  final TextEditingController _textController;
  final TodoListControllerNotifier todoListProviderNotifier;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textController,
      onSubmitted: (value) {
        if (value.isEmpty) {
          return;
        }
        todoListProviderNotifier.addTodo(_textController.text);
        _textController.clear();
      },
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      decoration: const InputDecoration(
        labelText: 'Add a todo',
      ),
    );
  }
}
