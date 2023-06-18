import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/todo.dart';

class TodoFilterControllerNotifier extends StateNotifier<TodoFilter> {
  TodoFilterControllerNotifier() : super(TodoFilter.all);

  void updateTodoStatus(TodoFilter filter) {
    state = filter;
  }
}

final todoFilterProvider =
    StateNotifierProvider<TodoFilterControllerNotifier, TodoFilter>((ref) {
  return TodoFilterControllerNotifier();
});
