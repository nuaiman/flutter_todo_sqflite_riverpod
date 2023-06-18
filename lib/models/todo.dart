import 'package:uuid/uuid.dart';

Uuid uuid = const Uuid();

enum TodoFilter {
  all,
  active,
  done,
}

class Todo {
  final String id;
  final String description;
  final bool isDone;
  Todo({
    String? id,
    required this.description,
    this.isDone = false,
  }) : id = id ?? uuid.v4();

  Todo copyWith({
    String? id,
    String? description,
    bool? isDone,
  }) {
    return Todo(
      id: id ?? this.id,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  String toString() =>
      'Todo(id: $id, description: $description, isDone: $isDone)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Todo &&
        other.id == id &&
        other.description == description &&
        other.isDone == isDone;
  }

  @override
  int get hashCode => id.hashCode ^ description.hashCode ^ isDone.hashCode;

  // Map<String, dynamic> toMap() {
  //   final result = <String, dynamic>{};

  //   result.addAll({'id': id});
  //   result.addAll({'description': description});
  //   result.addAll({'isDone': isDone});

  //   return result;
  // }

  // factory Todo.fromMap(Map<String, dynamic> map) {
  //   return Todo(
  //     id: map['id'] ?? '',
  //     description: map['description'] ?? '',
  //     isDone: map['isDone'] ?? false,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));
}
