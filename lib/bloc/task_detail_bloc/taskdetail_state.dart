part of 'taskdetail_bloc.dart';

@immutable
sealed class TaskdetailState {}

final class TaskdetailInitial extends TaskdetailState {}

final class TaskDetailLoadedState extends TaskdetailState {
  final Datum taskList;

  TaskDetailLoadedState({required this.taskList});
}
