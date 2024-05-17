import 'package:authenticationapp/Presentation/screens/authentication/login_page.dart';
import 'package:authenticationapp/Presentation/screens/home/add_task_page.dart';
import 'package:authenticationapp/Presentation/screens/home/edit_task_page.dart';
import 'package:authenticationapp/Presentation/screens/home/task_detail_page.dart';
import 'package:authenticationapp/bloc/delete_task_bloc/delete_task_bloc.dart';
import 'package:authenticationapp/bloc/task_detail_bloc/taskdetail_bloc.dart';
import 'package:authenticationapp/bloc/update_taskbloc/update_task_bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/view_task_bloc/viewtask_bloc.dart';
import '../../../data/task_model.dart';

class ViewTaskPage extends StatefulWidget {
  const ViewTaskPage({super.key});

  @override
  State<ViewTaskPage> createState() => _ViewTaskPageState();
}

class _ViewTaskPageState extends State<ViewTaskPage>
    with SingleTickerProviderStateMixin {
  List<Datum> datalist = [];
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ViewtaskBloc>(context).add(ViewtaskButtonClickedEvent());
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 244, 244, 244),
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              "Your Task",
              style: TextStyle(color: Colors.red[300], fontSize: 22.sp),
            ),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 244, 244, 244),
            automaticallyImplyLeading: false,
            actions: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddTaskPage(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                  ),
                  child: const Text(
                    "Add Task",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              backgroundColor: Colors.white,
                              surfaceTintColor: Colors.white,
                              elevation: 2.0,
                              title: Text("Sign_Out!!",
                                  style: TextStyle(
                                      color: const Color(0xffE78895),
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold)),
                              content: SizedBox(
                                height: 40.h,
                                child: Text(
                                  "Do you really want to sign-out?",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16.sp),
                                ),
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    Colors.red[200])),
                                        onPressed: () {
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginPage(),
                                              ),
                                              (route) => false);

                                          // ScaffoldMessenger.of(context)
                                          //     .showSnackBar( SnackBar(
                                          //         backgroundColor: Colors.red[300],
                                          //         duration:
                                          //             Duration(seconds: 1),
                                          //         behavior:
                                          //             SnackBarBehavior.floating,
                                          //         elevation: 2,
                                          //         dismissDirection:
                                          //             DismissDirection
                                          //                 .startToEnd,
                                          //         width: 200,
                                          //         content: Text(
                                          //           "Succesfully logged out",
                                          //           style: TextStyle(
                                          //               color: Colors.white),
                                          //         )));

                                          BotToast.showText(
                                              text: "Logged out succesfully");
                                        },
                                        child: const Text(
                                          "Yes",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    Colors.green[300])),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "No",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ],
                                ),
                              ],
                            ));
                  },
                  icon: const Icon(
                    Icons.login_outlined,
                    color: Color(0xffE78895),
                    size: 35,
                  )),
            ],
            bottom: TabBar(
              indicatorColor: Colors.green,
              labelColor: Colors.black,
              labelStyle: TextStyle(
                fontSize: 16.sp,
              ),
              controller: _tabController,
              dividerHeight: 0,
              tabs: const [
                Tab(
                  text: "Pending",
                ),
                Tab(
                  text: "Completed",
                )
              ],
            ),
          ),
          body: BlocConsumer<ViewtaskBloc, ViewtaskState>(
              listener: (context, state) {
            // TODO: implement listener
          }, builder: (context, state) {
            if (state is Viewtaskloadedstate) {
              datalist = state.taskList;

              return TabBarView(controller: _tabController, children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: ListView.builder(
                        // physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          Datum item = datalist
                              .where((item) => item.status == 0)
                              .elementAt(index);

                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 20, 5),
                            child:
                                BlocConsumer<UpdateTaskBloc, UpdateTaskState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                return Dismissible(
                                  onDismissed: (value) {
                                    BlocProvider.of<UpdateTaskBloc>(context)
                                        .add(UpdateTaskSlideEvent(id: item.id));

                                    setState(() {
                                      datalist.removeAt(index);
                                      // Then show a snackbar.
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  '${item.title} dismissed with status 1')));
                                      BlocProvider.of<ViewtaskBloc>(context)
                                          .add(ViewtaskButtonClickedEvent());
                                      _tabController.animateTo(1);
                                    });
                                  },
                                  key: UniqueKey(),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BlocProvider(
                                              create: (context) =>
                                                  TaskdetailBloc(),
                                              child: TaskDetailPage(
                                                id: item.id,
                                              ),
                                            ),
                                          ));
                                    },
                                    child: Container(
                                      height: 90.h,
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 10, 5),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 200.w,
                                            child: Text(
                                              item.title,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500,
                                                color: const Color.fromARGB(
                                                    255, 85, 83, 83),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BlocListener<TaskdetailBloc,
                                                  TaskdetailState>(
                                                listener: (context, state) {
                                                  if (state
                                                      is TaskDetailLoadedState) {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditTaskPage(
                                                                data: state
                                                                    .taskList),
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: InkWell(
                                                  onTap: () {
                                                    BlocProvider.of<
                                                                TaskdetailBloc>(
                                                            context)
                                                        .add(
                                                      TaskDetailViewEvent(
                                                          id: item.id),
                                                    );
                                                  },
                                                  child: const Icon(
                                                    Icons.edit,
                                                    size: 28,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ),
                                              BlocListener<DeleteTaskBloc,
                                                  DeleteTaskState>(
                                                listener: (context, state) {
                                                  if (state
                                                      is DeleteTaskLoadedState) {
                                                    BlocProvider.of<
                                                                ViewtaskBloc>(
                                                            context)
                                                        .add(
                                                            ViewtaskButtonClickedEvent());
                                                  }
                                                },
                                                child: InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            AlertDialog(
                                                          elevation: 2,
                                                          backgroundColor:
                                                              Colors.white,
                                                          surfaceTintColor:
                                                              Colors.white,
                                                          title: const Text(
                                                              "Delete Task?",
                                                              style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                              )),
                                                          content: SizedBox(
                                                            height: 40.h,
                                                            child: Text(
                                                              "Do you really want to delete the selected task??",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      16.sp),
                                                            ),
                                                          ),
                                                          actions: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                ElevatedButton(
                                                                    style: ButtonStyle(
                                                                        backgroundColor:
                                                                            WidgetStateProperty.all(Colors.red[
                                                                                200]),
                                                                        foregroundColor:
                                                                            WidgetStateProperty.all(Colors
                                                                                .white)),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      "No",
                                                                    )),
                                                                ElevatedButton(
                                                                    style: ButtonStyle(
                                                                        backgroundColor:
                                                                            WidgetStateProperty.all(Colors.green[
                                                                                200]),
                                                                        foregroundColor:
                                                                            WidgetStateProperty.all(Colors
                                                                                .white)),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                      BlocProvider.of<DeleteTaskBloc>(
                                                                              context)
                                                                          .add(DeleteTaskButtonClickedEvent(
                                                                              id: item.id));
                                                                    },
                                                                    child: const Text(
                                                                        "Yes")),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    child: const Icon(
                                                      Icons.delete,
                                                      size: 28,
                                                      color: Colors.red,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        itemCount:
                            datalist.where((item) => item.status == 0).length,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: SizedBox(
                    height: size.height * 0.8,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        Datum item = datalist
                            .where((item) => item.status == 1)
                            .elementAt(index);

                        print(item.id);

                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (context) => TaskdetailBloc(),
                                      child: TaskDetailPage(
                                        id: item.id,
                                      ),
                                    ),
                                  ));
                            },
                            child: Container(
                              height: 90.h,
                              padding: const EdgeInsets.fromLTRB(20, 5, 5, 5),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                color: Colors.white,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 200.w,
                                        child: Text(
                                          item.title,
                                          //overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                            color: const Color.fromARGB(
                                                255, 85, 83, 83),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  BlocListener<DeleteTaskBloc, DeleteTaskState>(
                                    listener: (context, state) {
                                      if (state is DeleteTaskLoadedState) {
                                        BlocProvider.of<ViewtaskBloc>(context)
                                            .add(ViewtaskButtonClickedEvent());
                                      }
                                    },
                                    child: IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              elevation: 2,
                                              backgroundColor: Colors.white,
                                              surfaceTintColor: Colors.white,
                                              title: const Text("Delete Task?",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  )),
                                              content: SizedBox(
                                                height: 40.h,
                                                child: Text(
                                                  "Do you really want to delete the selected task??",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16.sp),
                                                ),
                                              ),
                                              actions: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    ElevatedButton(
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                WidgetStateProperty
                                                                    .all(Colors
                                                                            .red[
                                                                        200]),
                                                            foregroundColor:
                                                                WidgetStateProperty
                                                                    .all(Colors
                                                                        .white)),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          "No",
                                                        )),
                                                    ElevatedButton(
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                WidgetStateProperty
                                                                    .all(Colors
                                                                            .green[
                                                                        200]),
                                                            foregroundColor:
                                                                WidgetStateProperty
                                                                    .all(Colors
                                                                        .white)),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          BlocProvider.of<
                                                                      DeleteTaskBloc>(
                                                                  context)
                                                              .add(
                                                                  DeleteTaskButtonClickedEvent(
                                                                      id: item
                                                                          .id));
                                                        },
                                                        child:
                                                            const Text("Yes")),
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          size: 25,
                                          color: Colors.red,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount:
                          datalist.where((item) => item.status == 1).length,
                    ),
                  ),
                ),
              ]);
            }

            return const SizedBox();
          })),
    );
  }
}
