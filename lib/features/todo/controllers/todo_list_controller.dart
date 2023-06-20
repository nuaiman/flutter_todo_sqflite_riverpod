import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/todo.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class TodoListControllerNotifier extends StateNotifier<List<Todo>> {
  TodoListControllerNotifier() : super([]);

  Future<Database> _getDatabse() async {
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, 'todo.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE todo(id TEXT PRIMARY KEY, description TEXT, isDone TEXT)');
      },
      version: 1,
    );
    return db;
  }

  List<Todo> get todos => state;

  int getActiveTodoCount() {
    final activeTodos = state.where((todo) => !todo.isDone).toList();
    return activeTodos.length;
  }

  void addTodo(String description) async {
    final newTodo = Todo(description: description);

    final db = await _getDatabse();
    db.insert(
      'todo',
      {
        'id': newTodo.id,
        'description': newTodo.description,
        'isDone': newTodo.isDone == true ? 'true' : 'false',
      },
    );

    state = [newTodo, ...state];
  }

  Future<void> loadTodos() async {
    final db = await _getDatabse();
    final data = await db.query('todo');
    final todos = data.map((row) {
      return Todo(
        id: row['id'] as String,
        description: row['description'] as String,
        isDone: (row['isDone'] as String) == 'true' ? true : false,
      );
    }).toList();
    state = todos;
  }

  void updateTodoStatus(String updatableTodoId, bool value) async {
    final newTodoList = state.map((todo) {
      if (todo.id == updatableTodoId) {
        return Todo(
            id: updatableTodoId, isDone: value, description: todo.description);
      }
      return todo;
    }).toList();

    final db = await _getDatabse();
    final data = {
      'isDone': value == true ? 'true' : 'false',
    };
    db.update('todo', data, where: "id = ?", whereArgs: [updatableTodoId]);

    state = newTodoList;
  }

  void editTodo(String updatableTodoId, String newDescription) async {
    final newTodoList = state.map((todo) {
      if (todo.id == updatableTodoId) {
        return Todo(
            id: updatableTodoId,
            isDone: todo.isDone,
            description: newDescription);
      }
      return todo;
    }).toList();

    final db = await _getDatabse();
    final data = {
      'description': newDescription,
    };
    db.update('todo', data, where: "id = ?", whereArgs: [updatableTodoId]);

    state = newTodoList;
  }

  void removeTodo(Todo deleatableTodo) async {
    final db = await _getDatabse();
    await db.rawDelete(
      'DELETE FROM todo WHERE id = ?',
      [deleatableTodo.id],
    );
    state = state.where((todo) => todo != deleatableTodo).toList();
  }
}

final todoListControllerProvider =
    StateNotifierProvider<TodoListControllerNotifier, List<Todo>>((ref) {
  return TodoListControllerNotifier();
});
