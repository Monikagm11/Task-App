part of 'add_task_bloc_bloc.dart';


sealed class AddTaskBlocEvent {}

class AddTaskButtonClickedEvent extends AddTaskBlocEvent {
  final String title;
  final String description;
  final String startdate;
  final String enddate;
  final int status;

  AddTaskButtonClickedEvent({
    required this.title,
    required this.description,
    required this.startdate,
    required this.enddate,
    required this.status,

  });
}

class AddTaskNavigateEvent extends AddTaskBlocEvent {}
