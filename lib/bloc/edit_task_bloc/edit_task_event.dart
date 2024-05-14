part of 'edit_task_bloc.dart';

@immutable
sealed class EditTaskEvent {}

class EditTaskButtonClickedEvent extends EditTaskEvent {
  final String title;
  final String description;
  final String startdate;
  final int id;
  final String enddate;

  EditTaskButtonClickedEvent(
      {required this.title,
      required this.description,
      required this.startdate,
      required this.enddate,
      required this.id,

      });
}
