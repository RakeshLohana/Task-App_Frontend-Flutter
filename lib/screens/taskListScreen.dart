import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notes_app/API/model.dart';
import 'package:notes_app/Urls/urls.dart';
import 'package:notes_app/Utils/Colors.dart';
import 'package:notes_app/Utils/snackBar.dart';
import 'package:notes_app/screens/HomePage.dart';
import 'package:notes_app/screens/addScreen2.dart';
import 'package:notes_app/widgets/button.dart';
import 'package:http/http.dart' as http;
import 'package:notes_app/widgets/updateDialog.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<GetTask> getList = [];

  Future<List<GetTask>> getTask() async {
    final response = await http.get(Uri.parse(getTaskUrl));
    var data = jsonDecode((response.body.toString()));
    if (response.statusCode == 200) {
      for (Map i in data) {
        getList.add(GetTask.fromJson(i));
      }
      return getList;
    }
    return getList;
  }

  Future<void> deleteTask(String taskId) async {
    final url = 'https://nutty-lingerie-frog.cyclic.app/tasks/$taskId';

    try {
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        print('Task deleted successfully');
        // Handle success case
      } else {
        print('Failed to delete task. Error code: ${response.statusCode}');
        // Handle error case
      }
    } catch (e) {
      print('Error deleting task: $e');
      // Handle error case
    }
  }

  @override
  Widget build(BuildContext context) {
    final leftEditIcon = Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height / 12,
        decoration: BoxDecoration(
          color: Appcolor.smallTextColor.withOpacity(0.5),
        ),
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        alignment: Alignment.centerLeft,
      ),
    );
    final rightEditIcon = Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height / 12,
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(color: Colors.redAccent),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
      ),
    );

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Container(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Icon(
                            Icons.arrow_back,
                            color: Appcolor.primaryColor,
                          )),
                    ),
                    Lottie.asset("assets/data.json", height: 250),
                  ],
                ),
                decoration: BoxDecoration(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          },
                          icon: Icon(
                            Icons.home,
                            size: 35,
                            color: Appcolor.secondaryColor,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Appcolor.primaryColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddScreen2()));
                          },
                          child: Center(
                              child: Icon(
                            Icons.add,
                            color: Colors.white,
                          )),
                        ),
                      ),
                    
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: FutureBuilder(
                future: getTask(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Column(
                      children: [
                        CircularProgressIndicator(
                          color: Appcolor.primaryColor, //<-- SEE HERE
                          backgroundColor: Colors.grey, //<-- SEE HERE
                        ),
                      ],
                    );
                  } else {
                    return ListView.builder(
                        itemCount: getList.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                              background: leftEditIcon,
                              secondaryBackground: rightEditIcon,
                              confirmDismiss:
                                  (DismissDirection direction) async {
                                if (direction == DismissDirection.startToEnd) {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      barrierColor: Colors.transparent,
                                      context: context,
                                      builder: (_) {
                                        return Container(
                                            height: 300,
                                            decoration: BoxDecoration(
                                                color: Appcolor.smallTextColor
                                                    .withOpacity(0.4),
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(25),
                                                    topRight:
                                                        Radius.circular(25))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  ActionButton(
                                                    text: "View",
                                                    backgroundColor:
                                                        Appcolor.primaryColor,
                                                    textColor: Colors.white,
                                                    isLoading: false,
                                                    onTap: () {
                                                      dialogBoxWidget(context, index);
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  ActionButton(
                                                    text: "Edit",
                                                    backgroundColor:
                                                        Colors.white,
                                                    textColor:
                                                        Appcolor.primaryColor,
                                                    isLoading: false,
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            UpdateDialogBox(
                                                          taskId: getList[index].sId.toString(),
                                                          currentTitle:getList[index].title.toString(),
                                                          currentDescription:
                                                             getList[index].description.toString(),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                ],
                                              ),
                                            ));
                                      });
                                  return false;
                                } else {
                                  return Future.delayed(
                                      Duration(milliseconds: 200),
                                      () =>
                                          direction ==
                                          DismissDirection.endToStart);
                                }
                              },
                              onDismissed: (DismissDirection direction) {
                                deleteTask(getList[index].sId.toString());
                                SnackBarClass().showSnackBar(
                                    context, 'Add Task', 'Task deleted successfully',(){
                                        Navigator.push(context, MaterialPageRoute(builder: ((context) => AddScreen2())));

                                    });
                              },
                              key:UniqueKey(),
                              child: InkWell(
                                  onTap: () {},
                                  child: ActionButton(
                                    border: 10,
                                    backgroundColor: Colors.grey.shade200,
                                    textColor: Appcolor.smallTextColor,
                                    text: getList[index].title.toString(),
                                    isLoading: false,
                                    onTap: () {
                                     dialogBoxWidget(context, index);
                                    },
                                  )));
                        });
                  }
                },
              ),
            )
          ]),
        ),
      ),
    );
  }

  Future<String?> dialogBoxWidget(BuildContext context, int index) {
    return showDialog<String>(
                            context: context,
                                      builder: (BuildContext context) =>
                                          Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            // border: Border.all(
                                            //   color:Appcolor.primaryColor,
                                            //   width: 2
                                            // ),
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.all(
                                                    16.0),
                                                child: Text(
                                                  getList[index]
                                                      .title
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    fontSize: 30.0,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets
                                                        .symmetric(
                                                    horizontal: 16.0),
                                                child: Text(
                                                  getList[index]
                                                      .description
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                  ),
                                                ),
                                              ),
                                              ButtonBar(
                                                children: <Widget>[
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context,
                                                            'Cancel'),
                                                    child: Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                          color: Appcolor
                                                              .primaryColor),
                                                    ),
                                                  ),
                                                  // TextButton(
                                                  //   onPressed: () =>
                                                  //       Navigator.pop(
                                                  //           context, 'OK'),
                                                  //   child: Text(
                                                  //     'OK',
                                                  //     style: TextStyle(
                                                  //         color: Appcolor
                                                  //             .primaryColor),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
  }
}
