import 'package:flutter/material.dart';
import 'package:practise/main.dart';
import 'package:practise/screens/pomo.dart';
import 'package:practise/screens/songs.dart';
import 'calender.dart';
import 'package:practise/screens/todo.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  get onTap => null;

  @override
  Widget build(BuildContext context) {
    const Color.fromARGB(66, 21, 1, 24);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'HOME',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30.0,
          ),
          const SizedBox(
            height: 120.0,
            child: Text(
              'Hi Study Beast,Start Your Productive Journey!',
              style: TextStyle(
                // ignore: unnecessary_const
                color: Colors.grey,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              InkWell(
                child: Container(
                  width: 176,
                  height: 176,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 255, 13),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        'TO-DO',
                        style: TextStyle(
                          // ignore: unnecessary_const
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      const Text(
                        'Make your Todo Lists',
                        style: TextStyle(
                          // ignore: unnecessary_const
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => todo(true)),
                    ),
                  );
                },
              ),
              InkWell(
                child: Container(
                  width: 176,
                  height: 176,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 255, 13),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        'POMO',
                        style: TextStyle(
                          // ignore: unnecessary_const
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      const Text(
                        'Manage time with Pomodoro Timer',
                        style: TextStyle(
                          // ignore: unnecessary_const
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const Pomo()),
                    ),
                  );
                },
              )
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            children: [
              InkWell(
                child: Container(
                  width: 176,
                  height: 176,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 255, 13),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        'LO-FI',
                        style: TextStyle(
                          // ignore: unnecessary_const
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      const Text(
                        'Beats to study and relax',
                        style: TextStyle(
                          // ignore: unnecessary_const
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const Song()),
                    ),
                  );
                },
              ),
              InkWell(
                  child: Container(
                    width: 176,
                    height: 176,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 0, 255, 13),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Text(
                          'CALENDAR',
                          style: TextStyle(
                            // ignore: unnecessary_const
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        const Text(
                          'Keep track of your deadlines',
                          style: TextStyle(
                            // ignore: unnecessary_const
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => Calendar()),
                      ),
                    );
                  })
            ],
          ),
        ],
      ),
    );
  }
}
