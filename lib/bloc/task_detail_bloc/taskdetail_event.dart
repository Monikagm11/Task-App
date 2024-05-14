part of 'taskdetail_bloc.dart';

@immutable
sealed class TaskdetailEvent {}

class TaskDetailViewEvent extends TaskdetailEvent {
  final int id;

  TaskDetailViewEvent({required this.id});
}
