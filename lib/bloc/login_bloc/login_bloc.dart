import 'package:authenticationapp/data/login_model.dart';
import 'package:authenticationapp/utils/endpoints/endpoints.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonClickedEvent>((event, emit) async {
      emit(LoginLoadingState());

      try {
        Dio dio = Dio();

        Map<String, dynamic> loginBody = {
          "email": event.email,
          "password": event.password,
        };

        print(loginBody);

        Response response = await dio.post(EndPoints.login, data: loginBody);

        print(response.statusCode);

        print(response.data);

        emit(LoginLoadedState(
            loginData: Loginusermodel.fromJson(response.data)));
        String token = response.data['data']['access'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", token);
      } on DioException catch (e) {
        if (e.response != null) {
          // print("1 ${e.response!.data["error"].toString()}");
          // print("2 ${e.response!.data["error"]["msg"].toString()}");
          emit(LoginErrorState(
              errormessage: e.response!.data["error"]["msg"].toString()));
          // errormessage: e.response!.statusMessage.toString()));
        }
      }
    });
  }
}
