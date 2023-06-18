import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/todo.dart';
import 'todo_filter_controller.dart';
import 'todo_list_controller.dart';
import 'todo_search_controller.dart';

class FilteredTodosControllerNotifier extends StateNotifier<List<Todo>> {
  final TodoListControllerNotifier _todoList;
  final TodoSearchControllerNotifier _todoSearch;
  final TodoFilterControllerNotifier _todoFilter;
  FilteredTodosControllerNotifier({
    required TodoListControllerNotifier todoList,
    required TodoSearchControllerNotifier todoSearch,
    required TodoFilterControllerNotifier todoFilter,
  })  : _todoList = todoList,
        _todoSearch = todoSearch,
        _todoFilter = todoFilter,
        super([]);

  List<Todo> getFilteredTodos() {
    List<Todo> filteredTodos = _todoList.todos;

    switch (_todoFilter.state) {
      case TodoFilter.active:
        filteredTodos = _todoList.todos.where((todo) => !todo.isDone).toList();
        break;
      case TodoFilter.done:
        filteredTodos = _todoList.todos.where((todo) => todo.isDone).toList();
        break;
      case TodoFilter.all:
        filteredTodos = _todoList.todos;
        break;
    }

    if (_todoSearch.state.isNotEmpty) {
      filteredTodos = filteredTodos
          .where((todo) =>
              todo.description.toLowerCase().contains(_todoSearch.state))
          .toList();
    } else {
      filteredTodos = filteredTodos;
    }

    return filteredTodos;
  }

  List<Todo> get todos => state;
}

final filteredTodosProvider =
    StateNotifierProvider<FilteredTodosControllerNotifier, List<Todo>>((ref) {
  final todoList = ref.watch(todoListControllerProvider.notifier);
  final todoSearch = ref.watch(todoSearchProvider.notifier);
  final todoFilter = ref.watch(todoFilterProvider.notifier);
  return FilteredTodosControllerNotifier(
      todoList: todoList, todoSearch: todoSearch, todoFilter: todoFilter);
});
