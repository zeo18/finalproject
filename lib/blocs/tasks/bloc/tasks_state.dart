part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<Task> tasksList;
  final List<Task> deletedTasks;
  final List<Task> favoriteTasks;
  final List<Task> completedTasks;
  const TasksState({
    this.tasksList = const <Task>[],
    this.deletedTasks = const <Task>[],
    this.favoriteTasks = const <Task>[],
    this.completedTasks = const <Task>[],
  });

  @override
  List<Object> get props =>
      [tasksList, deletedTasks, favoriteTasks, completedTasks];

  Map<String, dynamic> toMap() {
    return {
      'tasksList': tasksList.map((e) => e.toMap()).toList(),
      'deletedTasks': deletedTasks.map((e) => e.toMap()).toList(),
      'favoriteTasks': favoriteTasks.map((e) => e.toMap()).toList(),
      'completedTasks': completedTasks.map((e) => e.toMap()).toList(),
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
        tasksList:
            List<Task>.from(map['tasksList'].map((e) => Task.fromMap(e))),
        deletedTasks:
            List<Task>.from(map['deletedTasks'].map((e) => Task.fromMap(e))),
        favoriteTasks:
            List<Task>.from(map['favoriteTasks'].map((e) => Task.fromMap(e))),
        completedTasks:
            List<Task>.from(map['completedTasks'].map((e) => Task.fromMap(e))));
  }
}
