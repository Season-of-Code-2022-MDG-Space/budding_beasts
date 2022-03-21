import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../component/components.dart';
import '../../layout/todo_cubit/cubit.dart';


class ArchivedTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);

    return buildTask(tasks: cubit.archivedtasks);
  }
}
