import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:practise/screens/component/components.dart';
import 'package:practise/screens/layout/todo_cubit/cubit.dart';
import 'package:practise/screens/layout/todo_cubit/states.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..CrateDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(listener: (context, states) {
        if (states is AppInsertToDatabaseState) {
          Navigator.pop(context);
        }
      }, builder: (context, states) {
        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    cubit.InsertToDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text,
                    );
                  }
                } else {
                  cubit.ChangeBottomSheet(isShow: true, icon: Icons.add);

                  scaffoldKey.currentState!
                      .showBottomSheet(
                        (context) => Form(
                          key: formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormField(
                                  label: 'Task Title',
                                  controller: titleController,
                                  type: TextInputType.text,
                                  isPassword: false,
                                  prefix: Icons.title,
                                  validation: (String value) {
                                    if (value.isEmpty) {
                                      return 'title must be filled';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                defaultFormField(
                                    label: 'Task Time',
                                    controller: timeController,
                                    type: TextInputType.text,
                                    isPassword: false,
                                    prefix: Icons.watch_later,
                                    validation: (String value) {
                                      if (value.isEmpty) {
                                        return 'title must be filled';
                                      }
                                      return null;
                                    },
                                    OnTap: () {
                                      showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now())
                                          .then((value) {
                                        timeController.text =
                                            value!.format(context).toString();
                                      });
                                    }),
                                const SizedBox(height: 15),
                                defaultFormField(
                                    label: 'Task Date',
                                    controller: dateController,
                                    type: TextInputType.text,
                                    isPassword: false,
                                    prefix: Icons.calendar_today,
                                    validation: (String value) {
                                      if (value.isEmpty) {
                                        return 'title must be filled';
                                      }
                                      return null;
                                    },
                                    OnTap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate:
                                                  DateTime.parse('2022-02-14'))
                                          .then((value) {
                                        dateController.text =
                                            DateFormat.yMMMd().format(value!);
                                      });
                                    })
                              ],
                            ),
                          ),
                        ),
                        elevation: 30,
                      )
                      .closed
                      .then((value) {
                    cubit.ChangeBottomSheet(isShow: false, icon: Icons.edit);
                  });
                }
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              iconSize: 32,
              backgroundColor: Colors.black,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.task),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check), label: 'Done Tasks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive), label: 'Archived Tasks'),
              ],
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.ChangeNavBar(index);
              },
              showUnselectedLabels: false,
              showSelectedLabels: true,
            ),
            body: cubit.screens[cubit.currentIndex]);
      }),
    );
  }
}
