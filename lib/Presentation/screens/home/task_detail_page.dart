import 'package:authenticationapp/bloc/task_detail_bloc/taskdetail_bloc.dart';
import 'package:authenticationapp/utils/constants/color_constants.dart';
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
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    )),
                backgroundColor: ColorConstant.blue,
                title: const Text(
                  "Task Detail",
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                        // constraints:
                        //     const BoxConstraints(minHeight: 350, maxHeight: 350),
                        // height: 300,
                        width: 500,
                        margin: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),

                        // height: 100,
                        // width: 400,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: ColorConstant.blue, width: 3),
                            borderRadius: BorderRadius.circular(20),
                            // border: ,

                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(state.taskList.title),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(state.taskList.description),
                            const SizedBox(
                              height: 40,
                            ),
                            Text("Start-Date:${state.taskList.startDate} "),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("End-Date:${state.taskList.endDate}"),
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
