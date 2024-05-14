part of 'viewtask_bloc.dart';

sealed class ViewtaskState {}

final class ViewtaskInitial extends ViewtaskState {}

final class Viewtaskloadingstate extends ViewtaskState {}

final class Viewtaskloadedstate extends ViewtaskState {
  final List<Datum> taskList;

  Viewtaskloadedstate({required this.taskList});
}

final class Viewtaskerrorstate extends ViewtaskState {
  final String errorMessage;

  Viewtaskerrorstate({required this.errorMessage});
}


  


// final class Viewtaskeditloadedstate extends ViewtaskState{


// }