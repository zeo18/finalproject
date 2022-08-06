import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<EditTask>(_onEditTask);
    on<DeleteTask>(_onDeleteTask);
    on<PermaDeleteTask>(_onPermaDeleteTask);
    on<DeleteAll>(_onDeleteAll);
    on<RestoreTask>(_onRestoreTask);
    on<FavoriteTask>(_onFavoriteTask);
    on<CompleteTask>(_onCompleteTask);
  }

  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;

    emit(TasksState(
        tasksList: List.from(state.tasksList)..add(event.task),
        deletedTasks: List.from(state.deletedTasks),
        completedTasks: List.from(state.completedTasks),
        favoriteTasks: List.from(state.favoriteTasks)));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;

    emit(TasksState(
        tasksList: List.from(state.tasksList)..remove(event.task),
        deletedTasks: List.from(state.deletedTasks)
          ..add(event.task.copyWith(isDeleted: true)),
        completedTasks: List.from(state.completedTasks)..remove(event.task),
        favoriteTasks: List.from(state.favoriteTasks)..remove(event.task)));
  }

  void _onDeleteAll(DeleteAll event, Emitter<TasksState> emit) {
    final state = this.state;

    emit(TasksState(
        tasksList: List.from(state.tasksList),
        deletedTasks: List.from(state.deletedTasks)..clear(),
        completedTasks: List.from(state.completedTasks),
        favoriteTasks: List.from(state.favoriteTasks)));
  }

  void _onPermaDeleteTask(PermaDeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;

    emit(TasksState(
        tasksList: List.from(state.tasksList),
        deletedTasks: List.from(state.deletedTasks)..remove(event.task),
        completedTasks: List.from(state.completedTasks),
        favoriteTasks: List.from(state.favoriteTasks)));
  }

  void _onEditTask(EditTask event, Emitter<TasksState> emit) {
    final state = this.state;

    List<Task> tasksList = List.from(state.tasksList)..remove(event.task);
    List<Task> deletedTasks = List.from(state.deletedTasks)..remove(event.task);
    List<Task> favoriteTasks = List.from(state.favoriteTasks)
      ..remove(event.task);
    List<Task> completedTasks = List.from(state.completedTasks)
      ..remove(event.task);

    if (event.task.isDone == true || event.task.isFavorite == true) {
      if (event.task.isFavorite == true) {
        favoriteTasks.insert(0, event.editedTask.copyWith(isFavorite: true));
        tasksList.insert(0, event.editedTask.copyWith(isFavorite: true));
      }

      if (event.task.isDone == true) {
        completedTasks.insert(0, event.editedTask.copyWith(isDone: true));
        tasksList.insert(0, event.editedTask.copyWith(isDone: true));
      }
    } else {
      tasksList.insert(0, event.editedTask);
    }

    emit(TasksState(
        tasksList: tasksList,
        deletedTasks: deletedTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks));
  }

  void _onRestoreTask(RestoreTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> tasksList = List.from(state.tasksList);
    List<Task> deletedTasks = List.from(state.deletedTasks)..remove(event.task);
    List<Task> favoriteTasks = List.from(state.favoriteTasks);
    List<Task> completedTasks = List.from(state.completedTasks);

    if (event.task.isFavorite == true) {
      favoriteTasks.add(event.task.copyWith(isDeleted: false));
    }

    if (event.task.isDone == true) {
      completedTasks.add(event.task.copyWith(isDeleted: false));
    } else {
      tasksList.add(event.task.copyWith(isDeleted: false));
    }
    emit(TasksState(
        tasksList: tasksList,
        deletedTasks: deletedTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks));
  }

  void _onFavoriteTask(FavoriteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> tasksList = List.from(state.tasksList)..remove(event.task);
    List<Task> deletedTasks = List.from(state.deletedTasks);
    List<Task> favoriteTasks = List.from(state.favoriteTasks);
    List<Task> completedTasks = List.from(state.completedTasks);

    if (event.task.isFavorite == true) {
      if (event.task.isDone == true) {
        completedTasks.remove(event.task);
        completedTasks.insert(
            0, event.task.copyWith(isFavorite: false, isDone: true));
      } else {
        tasksList.insert(0, event.task.copyWith(isFavorite: false));
      }
      favoriteTasks.remove(event.task);
    } else {
      if (event.task.isDone == true) {
        favoriteTasks.remove(event.task);
        favoriteTasks.insert(
            0, event.task.copyWith(isFavorite: true, isDone: true));
        completedTasks.remove(event.task);
        completedTasks.insert(0, event.task.copyWith(isFavorite: true));
      } else {
        favoriteTasks.insert(0, event.task.copyWith(isFavorite: true));
        tasksList.remove(event.task);
        tasksList.insert(0, event.task.copyWith(isFavorite: true));
      }
    }
    emit(TasksState(
        tasksList: tasksList,
        deletedTasks: deletedTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks));
  }

  void _onCompleteTask(CompleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> tasksList = List.from(state.tasksList);
    List<Task> deletedTasks = List.from(state.deletedTasks);
    List<Task> favoriteTasks = List.from(state.favoriteTasks);
    List<Task> completedTasks = List.from(state.completedTasks);

    final faveIndex = favoriteTasks.indexOf(event.task);

    if (event.task.isDone == true) {
      if (event.task.isFavorite == true) {
        favoriteTasks.remove(event.task);
        favoriteTasks.insert(faveIndex, event.task.copyWith(isDone: false));
      }
      tasksList.insert(0, event.task.copyWith(isDone: false));
      completedTasks.remove(event.task);
    } else {
      if (event.task.isFavorite == true) {
        favoriteTasks.remove(event.task);
        favoriteTasks.insert(faveIndex, event.task.copyWith(isDone: true));
        completedTasks.insert(
            0, event.task.copyWith(isDone: true, isFavorite: true));
      } else {
        completedTasks.insert(0, event.task.copyWith(isDone: true));
      }
      tasksList.remove(event.task);
    }

    emit(TasksState(
        tasksList: tasksList,
        deletedTasks: deletedTasks,
        completedTasks: completedTasks,
        favoriteTasks: favoriteTasks));
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
