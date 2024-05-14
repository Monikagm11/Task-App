import 'package:authenticationapp/Presentation/screens/home/view_task.dart';
import 'package:authenticationapp/bloc/add_task_bloc/add_task_bloc_bloc.dart';
import 'package:authenticationapp/utils/constants/color_constants.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  

  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTaskPage> {
  TextEditingController title_controller = TextEditingController();
  final TextEditingController description_controller = TextEditingController();
  final TextEditingController startdate_controller = TextEditingController();
  final TextEditingController enddate_controller = TextEditingController();

  final task_key = GlobalKey<FormState>();
  final DateTime start_date = DateTime.now();

  @override
  // void initState() {
  //   super.initState();
  //   WidgetsFlutterBinding.ensureInitialized()
  //       .addPostFrameCallback((timeStamp) async {
  //     BlocProvider.of<AddTaskBloc>(context).add(
  //       AddTaskButtonClickedEvent(
  //         title: "",
  //         description: "",
  //         startdate: "",
  //         enddate: "",
  //         status: 0,
  //       ),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // var a = DateFormat();
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Add Tasks",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: ColorConstant.blue,

        // IconButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     icon: const Icon(
        //       Icons.arrow_back,
        //       color: Colors.white,
        //       size: 35,
        //     )),

        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ViewTaskPage()));
              },
              icon: const Icon(
                Icons.task,
                size: 35,
                color: Color.fromARGB(255, 244, 228, 87),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
            key: task_key,
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  TextFormField(
                    controller: title_controller,
                    style: const TextStyle(
                      decoration: TextDecoration.none,
                      decorationThickness: 0,
                    ),
                    decoration: const InputDecoration(
                        hintText: "Title",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: ColorConstant.blue),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: description_controller,
                    maxLines: 2,
                    // maxLines: 30,
                    style: const TextStyle(
                      decoration: TextDecoration.none,
                      decorationThickness: 0,
                    ),
                    decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: ColorConstant.blue,
                        )),
                        hintText: "Description"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onTap: () async {
                      final pickdate = await showDatePicker(
                          context: context,
                          firstDate: start_date,
                          lastDate: DateTime(2025));
                      if (pickdate != null) {
                        startdate_controller.text = DateFormat("yyyy-MM-dd")
                            .format(pickdate)
                            .toString();
                      }
                    },
                    controller: startdate_controller,
                    maxLines: 2,
                    // maxLines: 30,
                    style: const TextStyle(
                      decoration: TextDecoration.none,
                      decorationThickness: 0,
                    ),
                    decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: ColorConstant.blue,
                        )),
                        hintText: "Start Date"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onTap: () async {
                      final pickendDate = await showDatePicker(
                          context: context,
                          firstDate: start_date,
                          lastDate: DateTime(2025));
                      if (pickendDate != null) {
                        enddate_controller.text = DateFormat("yyyy - MM - dd")
                            .format(pickendDate)
                            .toString();
                      }
                    },
                    controller: enddate_controller,
                    maxLines: 2,
                    // maxLines: 30,
                    style: const TextStyle(
                      decoration: TextDecoration.none,
                      decorationThickness: 0,
                    ),
                    decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: ColorConstant.blue,
                        )),
                        hintText: "End Date"),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  BlocListener<AddTaskBloc, AddTaskBlocState>(
                    listener: (context, state) {
                      if (state is AddTaskBlocLoadingState) {
                        BotToast.showLoading();
                      }
                      if (state is AddTaskBlocLoadedState) {
                        BotToast.closeAllLoading();
                        BotToast.showText(text: "Task succesfully added");
                      }
                      if (state is AddTaskBlocErrorState) {
                        BotToast.closeAllLoading();
                        BotToast.showText(text: state.errormessage);
                      }
                    },
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.fromLTRB(80, 15, 80, 15)),
                            backgroundColor:
                                MaterialStateProperty.all(ColorConstant.blue)),
                        onPressed: () {
                          BlocProvider.of<AddTaskBloc>(context).add(
                              AddTaskButtonClickedEvent(
                                  title: title_controller.text,
                                  description: description_controller.text,
                                  startdate: startdate_controller.text,
                                  enddate: enddate_controller.text,
                                  status: 0));

                          setState(() {
                            title_controller.text = "";
                            description_controller.text = "";
                            startdate_controller.text = "";
                            enddate_controller.text = "";
                          });
                        },
                        child: const Text(
                          "Add task",
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
