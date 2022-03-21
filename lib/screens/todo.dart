import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practise/screens/layout/toda_layout.dart';
import 'package:practise/screens/layout/todo_cubit/cubit.dart';
import 'package:practise/screens/layout/todo_cubit/states.dart';
import 'package:practise/screens/shared/local/cache_helper.dart';
import 'component/bloc_observier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  todo app = todo(true);

  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark') ?? false;

  runApp(todo(true));
}

class todo extends StatelessWidget {
  final bool isDark;

  todo(this.isDark);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>
            AppCubit()..ChangeToDark(fromShared: isDark),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, states) {},
          builder: (context, states) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: ThemeMode.dark,
              darkTheme: ThemeData(brightness: Brightness.dark),
              home: HomeLayout(),
            );
          },
        ));
  }
}
