
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/tasks/bloc/tasks_bloc.dart';
import '../models/task.dart';

class PopupMenu extends StatelessWidget {
  const PopupMenu({
    Key? key,
    required this.task,
    required this.editCallback,
    required this.likeOrDislikeCallback,
    required this.cancelOrDeleteCallback,
    required this.restoreTaskCallback,
  }) : super(key: key);

  final Task task;
  final VoidCallback editCallback;
  final VoidCallback likeOrDislikeCallback;
  final VoidCallback cancelOrDeleteCallback;
  final VoidCallback restoreTaskCallback;

  List<PopupMenuItem> getActiveTaskMenuItems() {
    return [
      PopupMenuItem(
        onTap: editCallback,
        child: TextButton.icon(
          onPressed: editCallback,
          icon: const Icon(Icons.edit),
          label: const Text('Edit'),
        ),
      ),
      PopupMenuItem(
        onTap: likeOrDislikeCallback,
        child: TextButton.icon(
          onPressed: likeOrDislikeCallback,
          icon: task.isFavorite == false
              ? const Icon(Icons.bookmark_add_outlined)
              : const Icon(Icons.bookmark_remove_outlined),
          label: task.isFavorite == false
              ? const Text('Add to\nBookmarks')
              : const Text('Remove from\nBookmarks'),
        ),
      ),
      PopupMenuItem(
        onTap: cancelOrDeleteCallback,
        child: TextButton.icon(
          onPressed: cancelOrDeleteCallback,
          icon: const Icon(Icons.delete),
          label: const Text('Delete'),
        ),
      ),
    ];
  }

  List<PopupMenuItem> getRecycleBinTaskMenuItems() {
    return [
      PopupMenuItem(
        onTap: restoreTaskCallback,
        child: TextButton.icon(
          onPressed: restoreTaskCallback,
          icon: const Icon(Icons.restore_from_trash),
          label: const Text('Restore'),
        ),
      ),
      PopupMenuItem(
        onTap: cancelOrDeleteCallback,
        child: TextButton.icon(
          onPressed: cancelOrDeleteCallback,
          icon: const Icon(Icons.delete_forever),
          label: const Text('Delete Forever'),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TasksBloc, TasksState>(
      listener: (context, state) {
        
      },
      child: PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        itemBuilder: (context) => task.isDeleted!
            ? getRecycleBinTaskMenuItems()
            : getActiveTaskMenuItems(),
      ),
    );
  }
}
