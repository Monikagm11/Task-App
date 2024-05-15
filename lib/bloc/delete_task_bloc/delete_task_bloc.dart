import 'package:authenticationapp/utils/endpoints/endpoints.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'delete_task_event.dart';
part 'delete_task_state.dart';

class DeleteTaskBloc extends Bloc<DeleteTaskEvent, DeleteTaskState> {
  DeleteTaskBloc() : super(DeleteTaskInitial()) {
    on<DeleteTaskButtonClickedEvent>((event, emit) async {
      try {
        SharedPreferences preferences = await SharedPreferences.getInstance();

        Dio dio = Dio();

        Response response = await dio.delete("${EndPoints.task}${event.id}/",
            data: {"id": event.id},
            options: Options(headers: {
              "Authorization": "Bearer ${preferences.getString("token")}"
            }));

        print(response.data);

        emit(DeleteTaskLoadedState());
      } catch (e) {
        print(e.toString());
      }
    });
  }
}
