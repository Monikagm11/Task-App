import 'package:authenticationapp/Presentation/screens/home/view_task.dart';
import 'package:authenticationapp/bloc/add_task_bloc/add_task_bloc_bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTaskPage> {
  TextEditingController title_controller =
      TextEditingController(text: "May 17 task update");
  final TextEditingController description_controller =
      TextEditingController(text: "Hello");
  final TextEditingController startdate_controller =
      TextEditingController(text: "2024-05-22");
  final TextEditingController enddate_controller =
      TextEditingController(text: "2024-05-26");

  final _taskkey = GlobalKey<FormState>();
  final DateTime start_date = DateTime.now();

  @override
  @override
  Widget build(BuildContext context) {
    // var a = DateFormat();
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Add Tasks",
          style: TextStyle(color: Colors.red[300]),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 244, 244, 244),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30.sp,
            )),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _taskkey,
            child: Container(
              margin: EdgeInsets.all(10.h),
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 40).r,
              height: size.height.h,
              width: size.width.w,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field cannot be empty";
                      }
                      return null;
                    },
                    controller: title_controller,
                    style: const TextStyle(
                      decoration: TextDecoration.none,
                      decorationThickness: 0,
                    ),
                    decoration: const InputDecoration(
                        hintText: "Title",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        )),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field cannot be empty";
                      }
                      return null;
                    },
                    controller: description_controller,
                    maxLines: 2,
                    style: const TextStyle(
                      decoration: TextDecoration.none,
                      decorationThickness: 0,
                    ),
                    decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.grey,
                        )),
                        hintText: "Description"),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field cannot be empty";
                      }
                      return null;
                    },
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
                    style: const TextStyle(
                      decoration: TextDecoration.none,
                      decorationThickness: 0,
                    ),
                    decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.grey,
                        )),
                        hintText: "Start Date"),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Field cannot be empty";
                      }
                      return null;
                    },
                    onTap: () async {
                      final pickendDate = await showDatePicker(
                          context: context,
                          firstDate: start_date,
                          lastDate: DateTime(2025));
                      if (pickendDate != null) {
                        enddate_controller.text = DateFormat("yyyy-MM-dd")
                            .format(pickendDate)
                            .toString();
                      }
                    },
                    controller: enddate_controller,
                    maxLines: 2,
                    style: const TextStyle(
                      decoration: TextDecoration.none,
                      decorationThickness: 0,
                    ),
                    decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.grey,
                        )),
                        hintText: "End Date"),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  BlocListener<AddTaskBloc, AddTaskBlocState>(
                    listener: (context, state) {
                      if (state is AddTaskBlocLoadingState) {
                        BotToast.showLoading();
                      }
                      if (state is AddTaskBlocLoadedState) {
                        BotToast.closeAllLoading();
                        BotToast.showText(text: "Task succesfully added");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ViewTaskPage(),
                            ));
                      }
                      if (state is AddTaskBlocErrorState) {
                        BotToast.closeAllLoading();
                        BotToast.showText(text: state.errormessage);
                      }
                    },
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5).r)),
                            padding: WidgetStateProperty.all(
                                const EdgeInsets.fromLTRB(80, 15, 80, 15).r),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.green[300])),
                        onPressed: () {
                          if (_taskkey.currentState!.validate()) {
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
                          }
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
