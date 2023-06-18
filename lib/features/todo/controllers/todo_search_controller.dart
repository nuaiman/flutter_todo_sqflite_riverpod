import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoSearchControllerNotifier extends StateNotifier<String> {
  TodoSearchControllerNotifier() : super('');

  void setTodosBySearchTerm(String searchTerm) {
    state = searchTerm;
  }
}

final todoSearchProvider =
    StateNotifierProvider<TodoSearchControllerNotifier, String>((ref) {
  return TodoSearchControllerNotifier();
});
