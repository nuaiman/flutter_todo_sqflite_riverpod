import 'package:flutter/material.dart';

import '../../../models/todo.dart';
import '../controllers/todo_list_controller.dart';

class TodoListBuilder extends StatelessWidget {
  const TodoListBuilder({
    super.key,
    required this.filteredTodoListProvider,
    required this.todoListProviderNotifier,
    required TextEditingController textEditController,
    required TextEditingController textController,
  })  : _textEditController = textEditController,
        _textController = textController;

  final List<Todo> filteredTodoListProvider;
  final TodoListControllerNotifier todoListProviderNotifier;
  final TextEditingController _textEditController;
  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: filteredTodoListProvider.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return filteredTodoListProvider.isEmpty
              ? const Center(
                  child: Text('No todos added yet!'),
                )
              : Dismissible(
                  key: ValueKey(filteredTodoListProvider[index].id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) => todoListProviderNotifier
                      .removeTodo(filteredTodoListProvider[index]),
                  confirmDismiss: (direction) {
                    return showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Remove Todo'),
                          content: const Text(
                              'This action is irreversible. Please confirm deletion'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              child: const Text('Yes'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: const Text('No'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          _textEditController.text =
                              filteredTodoListProvider[index].description;
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                title: const Text('Edit Todo'),
                                content: TextField(
                                  controller: _textEditController,
                                  autofocus: true,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      if (_textEditController.text.isEmpty) {
                                        return;
                                      }
                                      todoListProviderNotifier.editTodo(
                                          filteredTodoListProvider[index].id,
                                          _textEditController.text);
                                      _textController.clear();
                                      Navigator.of(context).pop(true);
                                    },
                                    child: const Text('Update'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                    leading: Checkbox(
                      value: filteredTodoListProvider[index].isDone,
                      onChanged: (value) {
                        todoListProviderNotifier.updateTodoStatus(
                          filteredTodoListProvider[index].id,
                          value!,
                        );
                      },
                    ),
                    title: Text(filteredTodoListProvider[index].description),
                  ),
                );
        },
      ),
    );
  }
}
