part of 'delete_task_bloc.dart';

@immutable
sealed class DeleteTaskEvent {}

 class DeleteTaskButtonClickedEvent extends DeleteTaskEvent {
  final int id;

  DeleteTaskButtonClickedEvent({required this.id});

}
