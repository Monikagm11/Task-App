import 'package:authenticationapp/data/task_model.dart';
import 'package:authenticationapp/utils/endpoints/endpoints.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'taskdetail_event.dart';
part 'taskdetail_state.dart';

class TaskdetailBloc extends Bloc<TaskdetailEvent, TaskdetailState> {
  TaskdetailBloc() : super(TaskdetailInitial()) {
    on<TaskDetailViewEvent>((event, emit) async {
      try {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        Dio dio = Dio();

        Response response = await dio.get("${EndPoints.task}${event.id}/",
            options: Options(headers: {
              "Authorization": "Bearer ${preferences.getString("token")}"
            }));

        // final List<Datum> taskdata = [];
        print(response);
        print(response.statusCode);
        print(response.data);
        //print(response.data["data"].id);
        if (response.statusCode == 200) {
          emit(
            TaskDetailLoadedState(
              taskList: Datum.fromJson(response.data['data']),
            ),
          );

          return response.data;
        }
      } catch (e) {
        print(e.toString());
      }
    });
  }
}
