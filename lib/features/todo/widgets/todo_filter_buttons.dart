import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/todo.dart';
import '../controllers/todo_filter_controller.dart';

class TodoFilterButtons extends ConsumerWidget {
  const TodoFilterButtons({super.key});

  Widget _buildTodoFilterButton(
      BuildContext context, WidgetRef ref, TodoFilter filter) {
    return TextButton(
      onPressed: () {
        ref.read(todoFilterProvider.notifier).updateTodoStatus(filter);
      },
      child: Text(
        filter == TodoFilter.all
            ? 'All'
            : filter == TodoFilter.active
                ? 'Active'
                : 'Done',
        style: TextStyle(color: _getTodoFilterTextButtonColor(filter, ref)),
      ),
    );
  }

  Color _getTodoFilterTextButtonColor(TodoFilter filter, WidgetRef ref) {
    final currentTodoFilter = ref.watch(todoFilterProvider);
    return currentTodoFilter == filter ? Colors.purple : Colors.grey;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTodoFilterButton(context, ref, TodoFilter.all),
        _buildTodoFilterButton(context, ref, TodoFilter.active),
        _buildTodoFilterButton(context, ref, TodoFilter.done),
      ],
    );
  }
}
