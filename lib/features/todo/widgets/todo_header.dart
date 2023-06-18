import 'package:flutter/material.dart';

import '../controllers/todo_list_controller.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({
    super.key,
    required this.todoListProviderNotifier,
  });

  final TodoListControllerNotifier todoListProviderNotifier;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Todos',
          style: TextStyle(fontSize: 48),
        ),
        Text(
          '${todoListProviderNotifier.getActiveTodoCount()} items left',
          style: const TextStyle(fontSize: 24, color: Colors.red),
        ),
      ],
    );
  }
}
