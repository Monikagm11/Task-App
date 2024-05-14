part of 'update_task_bloc.dart';


sealed class UpdateTaskState {}

final class UpdateTaskInitial extends UpdateTaskState {}

final class UpdateTaskLoadingState extends UpdateTaskState {}

final class UpdateTaskLoadedState extends UpdateTaskState {
  final List<Datum> updateList;

  UpdateTaskLoadedState({required this.updateList});
}

final class UpdateTaskErrorState extends UpdateTaskState {
  final String errormessage;

  UpdateTaskErrorState({required this.errormessage});
}
