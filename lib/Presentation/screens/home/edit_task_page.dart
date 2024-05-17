import 'package:authenticationapp/Presentation/screens/home/view_task.dart';
import 'package:authenticationapp/bloc/edit_task_bloc/edit_task_bloc.dart';
import 'package:authenticationapp/data/task_model.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EditTaskPage extends StatefulWidget {
  final Datum data;
  const EditTaskPage({super.key, required this.data});

  @override
  State<EditTaskPage> createState() => _EditTaskPage();
}

class _EditTaskPage extends State<EditTaskPage> {
  final TextEditingController title_controller = TextEditingController();
  final TextEditingController description_controller = TextEditingController();
  TextEditingController startdate_controller = TextEditingController();
  TextEditingController enddate_controller = TextEditingController();

  final _key = GlobalKey<FormState>();
  final DateTime start_date = DateTime.now();

  @override
  void initState() {
    super.initState();
    title_controller.text = widget.data.title;
    description_controller.text = widget.data.description;
    startdate_controller.text = widget.data.startDate;
    enddate_controller.text = widget.data.endDate;
  }

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
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ViewTaskPage(),
                  ));
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            )),
        backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _key,
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
              height: size.height,
              width: size.width,
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
                  const SizedBox(
                    height: 20,
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
                  const SizedBox(
                    height: 20,
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
                    // maxLines: 30,
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
                  const SizedBox(
                    height: 20,
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
                  const SizedBox(
                    height: 40,
                  ),
                  BlocListener<EditTaskBloc, EditTaskState>(
                    listener: (context, state) {
                      if (state is EditTaskLoadingState) {
                        BotToast.showLoading();
                      }
                      if (state is EditTaskLoadedState) {
                        BotToast.closeAllLoading();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ViewTaskPage(),
                            ));
                        BotToast.showText(
                          text: "Task succesfully edited",
                        );
                      }
                      if (state is EditTaskErrorState) {
                        BotToast.closeAllLoading();
                        BotToast.showText(text: state.errormesaage);
                      }
                    },
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            padding: WidgetStateProperty.all(
                                const EdgeInsets.fromLTRB(80, 15, 80, 15)),
                            backgroundColor:
                                WidgetStateProperty.all(Colors.green[300])),
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            BlocProvider.of<EditTaskBloc>(context).add(
                                EditTaskButtonClickedEvent(
                                    title: title_controller.text,
                                    description: description_controller.text,
                                    startdate: start_date.toString(),
                                    enddate: enddate_controller.toString(),
                                    id: widget.data.id));

                            setState(() {
                              title_controller.text = "";
                              description_controller.text = "";
                              startdate_controller.text = "";
                              enddate_controller.text = "";
                            });
                          }
                        },
                        child: const Text(
                          "Update Task",
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
