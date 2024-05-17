import 'package:authenticationapp/data/task_model.dart';
import 'package:authenticationapp/utils/endpoints/endpoints.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'update_task_event.dart';
part 'update_task_state.dart';

class UpdateTaskBloc extends Bloc<UpdateTaskEvent, UpdateTaskState> {
  UpdateTaskBloc() : super(UpdateTaskInitial()) {
    on<UpdateTaskSlideEvent>((event, emit) async {
      emit(UpdateTaskLoadingState());

      try {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        Dio dio = Dio();

        print("${EndPoints.task}${event.id}/status/");

        Response response = await dio.put(
            "${EndPoints.task}${event.id}/status/",
            data: {
              "status": 1,
            },
            options: Options(headers: {
              "Authorization": "Bearer ${preferences.getString("token")}"
            }));

        print(response);
        print(response.data);

        if (response == 200) {
          emit(UpdateTaskLoadedState(updateList: response.data));
        }
      } catch (e) {}
    });
  }
}
