import 'package:authenticationapp/utils/endpoints/endpoints.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/task_model.dart';

part 'viewtask_event.dart';
part 'viewtask_state.dart';

class ViewtaskBloc extends Bloc<ViewtaskEvent, ViewtaskState> {
  ViewtaskBloc() : super(ViewtaskInitial()) { 
    
    on<ViewtaskButtonClickedEvent>((event, emit) async {
      emit(Viewtaskloadingstate());

      try {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        Dio dio = Dio();

        Response response = await dio.get(EndPoints.task,
            options: Options(headers: {
              "Authorization": "Bearer ${preferences.getString("token")}"
            }));

        // final List<Datum> taskdata = [];
        print(response);
        print(response.statusCode);
        print(response.data);
        print(response.data["data"]);
        if (response.statusCode == 200) {
          emit(Viewtaskloadedstate(
            taskList: (response.data["data"] as List<dynamic>)
                .map((taskData) => Datum.fromJson(taskData))
                .toList(),
          ));

          return response.data;
        }
      } catch (e) {
        print(e.toString());
        emit(Viewtaskerrorstate(errorMessage: e.toString()));
      }
    });


    

    
  }
}
