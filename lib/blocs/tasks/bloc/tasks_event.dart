part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class ShowTasks extends TasksEvent {
  final List<Task> tasksList;
  const ShowTasks({this.tasksList = const <Task>[]});
}

class AddTask extends TasksEvent {
  final Task task;

  const AddTask({required this.task});

  @override
  List<Object> get props => [task];
}

class EditTask extends TasksEvent {
  final Task task;
  final Task editedTask;

  const EditTask({required this.task, required this.editedTask});

  @override
  List<Object> get props => [task];
}

class DeleteTask extends TasksEvent {
  final Task task;

  const DeleteTask({required this.task});

  @override
  List<Object> get props => [task];
}

class DeleteAll extends TasksEvent {
  const DeleteAll();

  @override
  List<Object> get props => [];
}

class PermaDeleteTask extends TasksEvent {
  final Task task;

  const PermaDeleteTask({required this.task});

  @override
  List<Object> get props => [task];
}

class RestoreTask extends TasksEvent {
  final Task task;

  const RestoreTask({required this.task});

  @override
  List<Object> get props => [task];
}

class FavoriteTask extends TasksEvent {
  final Task task;

  const FavoriteTask({required this.task});

  @override
  List<Object> get props => [task];
}

class RemoveFavoriteTask extends TasksEvent {
  final Task task;

  const RemoveFavoriteTask({required this.task});

  @override
  List<Object> get props => [task];
}

class CompleteTask extends TasksEvent {
  final Task task;

  const CompleteTask({required this.task});

  @override
  List<Object> get props => [task];
}
