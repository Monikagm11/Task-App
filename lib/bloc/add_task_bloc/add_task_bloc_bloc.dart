import 'package:authenticationapp/data/task_model.dart';
import 'package:authenticationapp/utils/endpoints/endpoints.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'add_task_bloc_event.dart';
part 'add_task_bloc_state.dart';

class AddTaskBloc extends Bloc<AddTaskBlocEvent, AddTaskBlocState> {
  AddTaskBloc() : super(AddTaskBlocInitial()) {
    on<AddTaskButtonClickedEvent>((event, emit) async {
      emit(AddTaskBlocLoadingState());

      try {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        Dio dio = Dio();

        Map<String, dynamic> taskBody = {
          "title": event.title,
          "description": event.description,
          "status": event.status,
          "start_date": event.startdate,
          "end_date": event.enddate
        };

        print(taskBody);
        print(preferences.getString("token"));
        Response response = await dio.post(EndPoints.task,
            data: taskBody,
            options: Options(headers: {
              "Authorization": "Bearer ${preferences.getString("token")}"
            }));

        print(response);
        print(response.data);

        emit(AddTaskBlocLoadedState(
            taskdata: Datum.fromJson(response.data['data'])));
      } on DioException catch (e) {
        if (e.response != null) {
          // print("1 ${e.response!.data["error"].toString()}");
          // print("2 ${e.response!.data["error"]["msg"].toString()}");
          print(e);

          emit(AddTaskBlocErrorState(
              errormessage: e.response!.data["error"].toString()));

          // errormessage: e.response!.statusMessage.toString()));
        }
      }
    });
  }
}
