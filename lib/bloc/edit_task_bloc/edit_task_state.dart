part of 'edit_task_bloc.dart';

@immutable
sealed class EditTaskState {}

final class EditTaskInitial extends EditTaskState {}

final class EditTaskLoadingState extends EditTaskState {}

final class EditTaskLoadedState extends EditTaskState {
  final Datum taskdata;

  EditTaskLoadedState({required this.taskdata});
}

final class EditTaskErrorState extends EditTaskState {
  final String errormesaage;

  EditTaskErrorState({required this.errormesaage});

}
