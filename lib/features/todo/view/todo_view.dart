// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_nuaiman_ashiq/features/todo/controllers/todo_list_controller.dart';
import 'package:todo_app_nuaiman_ashiq/features/todo/controllers/todo_search_controller.dart';

import '../controllers/filtered_todos_controller.dart';
import '../widgets/create_todo_field.dart';
import '../widgets/search_todo_field.dart';
import '../widgets/todo_filter_buttons.dart';
import '../widgets/todo_header.dart';
import '../widgets/todo_list_builder.dart';

class TodoView extends ConsumerStatefulWidget {
  const TodoView({super.key});

  @override
  ConsumerState<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends ConsumerState<TodoView> {
  final _textController = TextEditingController();
  final _textEditController = TextEditingController();
  final _searchController = TextEditingController();

  late Future<void> _loadTodos;

  @override
  void initState() {
    super.initState();

    _loadTodos = ref.read(todoListControllerProvider.notifier).loadTodos();
  }

  @override
  void dispose() {
    _textController.dispose();
    _textEditController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todoListProvider = ref.watch(todoListControllerProvider);
    final todoListProviderNotifier =
        ref.read(todoListControllerProvider.notifier);
    final filteredTodosNotifier = ref.watch(filteredTodosProvider.notifier);
    final filteredTodoListProvider = filteredTodosNotifier.getFilteredTodos();
    final searchProvider = ref.watch(todoSearchProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              TodoHeader(todoListProviderNotifier: todoListProviderNotifier),
              const SizedBox(height: 20),
              CreateTodoField(
                  textController: _textController,
                  todoListProviderNotifier: todoListProviderNotifier),
              const SizedBox(height: 10),
              SearchTodoField(searchController: _searchController, ref: ref),
              const TodoFilterButtons(),
              const SizedBox(height: 20),
              FutureBuilder(
                future: _loadTodos,
                builder: (context, snapshot) =>
                    snapshot.connectionState == ConnectionState.waiting
                        ? const Center(child: CircularProgressIndicator())
                        : TodoListBuilder(
                            filteredTodoListProvider: filteredTodoListProvider,
                            todoListProviderNotifier: todoListProviderNotifier,
                            textEditController: _textEditController,
                            textController: _textController),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
