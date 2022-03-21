import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../layout/todo_cubit/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.green,
  bool isUpperCase = true,
  double radius = 3.0,
  required function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(isUpperCase ? text.toUpperCase() : text,
            style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultFormField(
        {required TextEditingController controller,
        required TextInputType type,
        required bool isPassword,
        required String label,
        validation,
        required IconData prefix,
        IconData? suffix,
        OnTap,
        onChange,
        VoidCallback? suffixPressed,
        onSubmitted}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      validator: validation,
      onTap: OnTap,
      onChanged: onChange,
      onFieldSubmitted: onSubmitted,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: IconButton(
          icon: Icon(suffix),
          onPressed: suffixPressed,
        ),
        border: OutlineInputBorder(),
      ),
    );

Widget CreateTaskItem(Map model, context) {
  return Dismissible(
    key: Key(model['id'].toString()),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.green,
            child: Text(
              '${model['time']}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            radius: 40,
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${model['title']}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${model['date']}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 20),
          IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .UpdateDatabase(status: 'done', id: model['id']);
              },
              icon: Icon(Icons.check_box, color: Colors.green)),
          IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .UpdateDatabase(status: 'archive', id: model['id']);
                ScaffoldMessengerState().showSnackBar(SnackBar(
                  content: Text(
                    'Task has been added to archived list',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  backgroundColor: Colors.black87,
                  duration: Duration(seconds: 4),
                ));
              },
              icon: Icon(Icons.archive, color: Colors.green)),
        ],
      ),
    ),
    background: Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity,
      color: Colors.red,
      child: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Icon(
            Icons.delete,
            size: 32,
            color: Colors.green,
          )),
    ),
    onDismissed: (direction) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  'Delete ?',
                  style: GoogleFonts.poppins(fontSize: 20, color: Colors.black),
                ),
                content: Text(
                  'are you sure you want to delete this task ?',
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
                ),
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel')),
                  TextButton(
                    onPressed: () {
                      AppCubit.get(context).DeleteDatabase(id: model['id']);
                    },
                    child: Text(
                      'Yes',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ));
    },
  );
}

Widget buildTask({required List<Map> tasks}) {
  return ConditionalBuilder(
    condition: tasks.isNotEmpty,
    builder: (context) => ListView.separated(
        itemBuilder: (context, index) => CreateTaskItem(tasks[index], context),
        separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 1,
                width: double.infinity,
                color: Colors.green,
              ),
            ),
        itemCount: tasks.length),
    fallback: (context) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.delete,
            size: 80,
            color: Colors.green,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'No Tasks yet . please add some',
            style: TextStyle(
                color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

//

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

void addToast({
  required String message,
}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.black,
        fontSize: 18.0);
