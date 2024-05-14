part of 'add_task_bloc_bloc.dart';


sealed class AddTaskBlocState {}

final class AddTaskBlocInitial extends AddTaskBlocState {}

final class AddTaskBlocLoadingState extends AddTaskBlocState {}

final class AddTaskBlocLoadedState extends AddTaskBlocState {
  final Datum taskdata;

  AddTaskBlocLoadedState({required this.taskdata});
}

final class AddTaskBlocErrorState extends AddTaskBlocState {
  final String errormessage;

  AddTaskBlocErrorState({required this.errormessage});
}
