import 'package:authenticationapp/utils/endpoints/endpoints.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/task_model.dart';

part 'edit_task_event.dart';
part 'edit_task_state.dart';

class EditTaskBloc extends Bloc<EditTaskEvent, EditTaskState> {
  EditTaskBloc() : super(EditTaskInitial()) {
    on<EditTaskButtonClickedEvent>((event, emit) async {
      try {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        Dio dio = Dio();

        // Map<String, dynamic> taskBody = {
        //   "title": event.title,
        //   "description": event.description,
        //   "id": event.id,
        //   "start_date": event.startdate,
        //   "end_date": event.enddate
        // };

        // print(taskBody);
        print(preferences.getString("token"));
        Response response = await dio.put("${EndPoints.task}17",
            data: {
              "title": event.title,
              "description": event.description,
              "id": 17,
              "start_date": event.startdate,
              "end_date": event.enddate
            },
            options: Options(headers: {
              "Authorization": "Bearer ${preferences.getString("token")}"
            }));

        // final List<Datum> taskdata = [];
        print(response);
        print(response.statusCode);
        print(response.data);
        //print(response.data["data"].id);

        emit(EditTaskLoadedState(
            taskdata: Datum.fromJson(response.data['data'])));
      } catch (e) {
        print(e.toString());
      }
    });
  }
}
