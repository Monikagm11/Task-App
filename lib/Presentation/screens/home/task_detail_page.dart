import 'package:authenticationapp/bloc/task_detail_bloc/taskdetail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskDetailPage extends StatefulWidget {
  final int id;
  const TaskDetailPage({super.key, required this.id});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TaskdetailBloc>(context)
        .add(TaskDetailViewEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskdetailBloc, TaskdetailState>(
      builder: (context, state) {
        if (state is TaskDetailLoadedState) {
          print(state.taskList);

          return Scaffold(
              backgroundColor: const Color.fromARGB(255, 244, 244, 244),
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 30,
                    )),
                backgroundColor: const Color.fromARGB(255, 244, 244, 244),
                title: Text(
                  "Task Detail",
                  style: TextStyle(color: Colors.red[300]),
                ),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                        width: 500,
                        margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green, width: 3),
                            borderRadius: BorderRadius.circular(20),
                            // border: ,

                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.taskList.title,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              state.taskList.description,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 108, 108, 108)),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  state.taskList.startDate,
                                  style: const TextStyle(
                                      color: Colors.green, fontSize: 16),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                const Text(
                                  "-",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  state.taskList.endDate,
                                  style: TextStyle(
                                      color: Colors.red[300], fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        )),
                  ),
                ],
              ));
        }
        return const SizedBox();
      },
    );
  }
}
