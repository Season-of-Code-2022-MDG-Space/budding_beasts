import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../component/components.dart';
import '../../layout/todo_cubit/cubit.dart';
import '../../layout/todo_cubit/states.dart';

class NewTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, states) {},
        builder: (context, states) {
          return buildTask(tasks: cubit.newtasks);
        });
  }
}
