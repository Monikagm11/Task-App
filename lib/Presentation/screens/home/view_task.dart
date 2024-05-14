import 'package:authenticationapp/Presentation/screens/authentication/login_page.dart';
import 'package:authenticationapp/Presentation/screens/home/add_task_page.dart';
import 'package:authenticationapp/Presentation/screens/home/edit_task_page.dart';
import 'package:authenticationapp/Presentation/screens/home/task_detail_page.dart';
import 'package:authenticationapp/bloc/edit_task_bloc/edit_task_bloc.dart';
import 'package:authenticationapp/bloc/task_detail_bloc/taskdetail_bloc.dart';
import 'package:authenticationapp/bloc/update_taskbloc/update_task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/view_task_bloc/viewtask_bloc.dart';
import '../../../data/task_model.dart';
import '../../../utils/constants/color_constants.dart';

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text(
              "Your Task",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: ColorConstant.blue,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                )),
            actions: [
              IconButton(
                style: IconButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddTaskPage(),
                    ),
                  );
                },
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              backgroundColor: Colors.white,
                              elevation: 2.0,

                              title: const Text("Sign_Out!!",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              content: const SizedBox(
                                height: 50,
                                child: Text(
                                  "Do you really want to sign-out?",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16),
                                ),
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          // SystemNavigator.pop();
                                          // Navigator.pop(context);
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginPage(),
                                              ),
                                              (route) => false);
                                        },
                                        child: const Text(
                                          "Yes",
                                          style: TextStyle(color: Colors.green),
                                        )),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "No",
                                          style: TextStyle(color: Colors.red),
                                        )),
                                  ],
                                ),
                              ],
                              // elevation: 6,
                            ));
                    // Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.login_outlined,
                    color: Colors.white,
                    size: 35,
                  )),
            ],
            bottom: TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              labelStyle: const TextStyle(fontSize: 18),
              controller: _tabController,
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
                ListView.builder(
                  //physics: const ScrollPhysics(),
                  //shrinkWrap: true,
                  itemBuilder: (context, index) {
                    // final item = datalist[index];
                    Datum item = datalist
                        .where((item) => item.status == 0)
                        .elementAt(index);

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: BlocConsumer<UpdateTaskBloc, UpdateTaskState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return Dismissible(
                            onDismissed: (value) {
                              BlocProvider.of<UpdateTaskBloc>(context)
                                  .add(UpdateTaskSlideEvent(id: item.id));

                              setState(() {
                                datalist.removeAt(index);
                                // Then show a snackbar.
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        '${item.title} dismissed with status ${item.status}')));
                                BlocProvider.of<ViewtaskBloc>(context)
                                    .add(ViewtaskButtonClickedEvent());
                                _tabController.animateTo(1);
                              });
                            },
                            // Show a red background as the item is swiped away.

                            key: UniqueKey(),
                            child: InkWell(
                              onTap: () {
                                // BlocProvider.of<TaskdetailBloc>(context)
                                //     .add(TaskDetailViewEvent(id: item.id));
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
                                height: 120,
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),

                                // height: 100,
                                // width: 400,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: ColorConstant.blue, width: 3),
                                    borderRadius: BorderRadius.circular(20),
                                    // border: ,

                                    color: Colors.white),

                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Text(
                                    //   item.id.toString(),
                                    //   style: const TextStyle(
                                    //     fontSize: 18,
                                    //     color: Color.fromARGB(255, 77, 74, 74),
                                    //   ),
                                    // ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          item.title,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: ColorConstant.blue,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      // width: 100,
                                      child: Column(
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.start,
                                        // crossAxisAlignment: Cros,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.green[300],
                                            child: BlocBuilder<EditTaskBloc,
                                                EditTaskState>(
                                              builder: (context, state) {
                                                if (state
                                                    is EditTaskLoadedState) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const EditTaskPage(),
                                                      ));
                                                }
                                                return IconButton(
                                                    onPressed: () {
                                                      BlocProvider.of<
                                                                  EditTaskBloc>(
                                                              context)
                                                          .add(EditTaskButtonClickedEvent(
                                                              title: item.title,
                                                              description:
                                                                  item
                                                                      .description,
                                                              startdate: item
                                                                  .startDate,
                                                              enddate:
                                                                  item.endDate,
                                                              id: 17));
                                                    },
                                                    icon: const Icon(
                                                      Icons.edit,
                                                      size: 20,
                                                      color: Colors.white,
                                                    ));
                                              },
                                            ),
                                          ),
                                          CircleAvatar(
                                            backgroundColor: Colors.red[200],
                                            child: IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.delete,
                                                  size: 20,
                                                  color: Colors.white,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // const Text("hi")
                                    // const SizedBox(
                                    //   height: 5,
                                    // ),
                                    // Text(
                                    //   item.description,
                                    //   style: const TextStyle(
                                    //     fontSize: 18,
                                    //     color: Color.fromARGB(255, 77, 74, 74),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                  itemCount: datalist.where((item) => item.status == 0).length,
                ),
                ListView.builder(
                  //physics: const ScrollPhysics(),
                  //shrinkWrap: true,
                  itemBuilder: (context, index) {
                    // final item = datalist[index];
                    Datum item = datalist
                        .where((item) => item.status == 1)
                        .elementAt(index);

                    print(item.id);

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      child: Container(
                        height: 120,
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),

                        // height: 100,
                        // width: 400,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: ColorConstant.blue, width: 3),
                            borderRadius: BorderRadius.circular(20),
                            // border: ,

                            color: Colors.white),

                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.id.toString(),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 77, 74, 74),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: ColorConstant.blue,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              // width: 100,
                              child: Column(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.start,
                                // crossAxisAlignment: Cros,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.green[300],
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.edit,
                                          size: 20,
                                          color: Colors.white,
                                        )),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.red[200],
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.delete,
                                          size: 20,
                                          color: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            // const Text("hi")
                            // const SizedBox(
                            //   height: 5,
                            // ),
                            // Text(
                            //   item.description,
                            //   style: const TextStyle(
                            //     fontSize: 18,
                            //     color: Color.fromARGB(255, 77, 74, 74),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: datalist.where((item) => item.status == 1).length,
                ),
              ]);
            }

            return const SizedBox();
          })),
    );
  }
}
