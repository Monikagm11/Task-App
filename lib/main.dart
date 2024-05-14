import 'package:authenticationapp/Presentation/screens/authentication/login_page.dart';
import 'package:authenticationapp/bloc/edit_task_bloc/edit_task_bloc.dart';
import 'package:authenticationapp/bloc/login_bloc/login_bloc.dart';
import 'package:authenticationapp/bloc/register_bloc/register_bloc.dart';
import 'package:authenticationapp/bloc/task_detail_bloc/taskdetail_bloc.dart';
import 'package:authenticationapp/bloc/update_taskbloc/update_task_bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/add_task_bloc/add_task_bloc_bloc.dart';
import 'bloc/view_task_bloc/viewtask_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => AddTaskBloc(),
        ),
        BlocProvider(
          create: (context) => ViewtaskBloc(),
        ),
        BlocProvider(
          create: (context) => UpdateTaskBloc(),
        ),
        BlocProvider(
          create: (context) => TaskdetailBloc(),
        ),
        BlocProvider(
          create: (context) => EditTaskBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Authentication',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 165, 121, 243)),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        home: const LoginPage(),
      ),
    );
  }
}
