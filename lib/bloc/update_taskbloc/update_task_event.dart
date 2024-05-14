part of 'update_task_bloc.dart';

sealed class UpdateTaskEvent {}

class UpdateTaskSlideEvent extends UpdateTaskEvent {
  final int id;
  UpdateTaskSlideEvent({required this.id});
}
