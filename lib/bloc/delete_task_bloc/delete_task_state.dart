part of 'delete_task_bloc.dart';

@immutable
sealed class DeleteTaskState {}

final class DeleteTaskInitial extends DeleteTaskState {}
final class DeleteTaskLoadedState extends DeleteTaskState {}




