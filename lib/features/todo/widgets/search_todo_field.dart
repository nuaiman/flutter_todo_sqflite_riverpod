import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/todo_search_controller.dart';

class SearchTodoField extends StatelessWidget {
  const SearchTodoField({
    super.key,
    required TextEditingController searchController,
    required this.ref,
  }) : _searchController = searchController;

  final TextEditingController _searchController;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      onChanged: (value) {
        ref
            .read(todoSearchProvider.notifier)
            .setTodosBySearchTerm(_searchController.text);
      },
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      decoration: const InputDecoration(
        filled: true,
        border: InputBorder.none,
        hintText: 'Search todos',
        suffixIcon: Icon(Icons.search),
      ),
    );
  }
}
