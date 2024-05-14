import 'dart:convert';

import 'package:authenticationapp/data/register_model.dart';
import 'package:authenticationapp/utils/endpoints/endpoints.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterButtonClickedEvent>((event, emit) async {
      emit(RegisterLoadingState());

      try {
        Dio dio = Dio();

        Map<String, dynamic> registerBody = {
          "firstname": event.first_name,
          "lastname": event.last_name,
          "email": event.email,
          "phone": event.phone,
          "password": event.password
        };

        print(registerBody);

        Response response =
            await dio.post(EndPoints.register, data: registerBody);
        print(response);

        emit(RegisterLoadedState(
            registerdata: Registerusermodel.fromJson(response.data)));
      } on DioException catch (e) {
        if (e.response != null) {
          Map<String, dynamic> json =
              jsonDecode(e.response!.data['error'].toString());
          json.forEach((key, value) {
            emit(RegisterErrorState(
                errormessage: e.response!.data["error"].toString()));
          });
        }
      }
    });
  }
}
