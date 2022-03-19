// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:practise/screens/widget/custom_button.dart';
import 'package:practise/screens/widget/progress_icons.dart';
import 'package:practise/model/pomodoro_status.dart';
import 'package:practise/utils/constants.dart';

class Pomo extends StatefulWidget {
  const Pomo({Key? key}) : super(key: key);

  @override
  State<Pomo> createState() => _PomoState();
}

const _btnTextStart = 'START POMODORO';
const _btnTextResumePomodoro = 'RESUME POMODORO';
const _btnTextResumeBreak = 'RESUME BREAK';
const _btnTextStartShortBreak = 'TAKE SHORT BREAK';
const _btnTextStartLongBreak = 'START LONG BREAK';
const _btnTextSTartNewSet = 'START NEW SET';
const _btnTextReset = 'RESET';
const _btnTextPause = 'PAUSE';

class _PomoState extends State<Pomo> {
  int remainingTime = pomodoroTotalTime;
  String mainBtnText = _btnTextStart;
  PomodoroStatus pomodoroStatus = PomodoroStatus.pausedPomodoro;
  Timer _timer = Timer(Duration(seconds: 1), () {});
  int pomodoroNum = 0;
  int setNum = 0;
  int totalTime = 0;
  @override
  void dispose() {
    _cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'POMODORO TIMER',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const SizedBox(
              height: 10,
            ),
            // ignore: prefer_const_constructors
            Text(
              'Pomodoro Number: $pomodoroNum',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            // ignore: prefer_const_constructors
            Text(
              'Set: $setNum',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            // ignore: prefer_const_constructors
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularPercentIndicator(
                    radius: 120.0,
                    lineWidth: 20.0,
                    percent: _getPomodoroPercentage(),
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Text(
                      _secondsToFormatedString(remainingTime - 1),
                      style: const TextStyle(fontSize: 32, color: Colors.grey),
                    ),
                    progressColor: statusColor[pomodoroStatus],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ProgressIcons(
                    total: pomodoriPerSet,
                    done: pomodoroNum - (setNum * pomodoriPerSet),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(onTap: _mainButtonPressed, text: 'Start Timer'),
                  CustomButton(onTap: _resetButtonPressed, text: 'Reset Timer'),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  _secondsToFormatedString(int seconds) {
    int roundedMinutes = seconds ~/ 60;
    int remainingSeconds = seconds - (roundedMinutes * 60);
    String remainingSecondsFormated;
    if (remainingSeconds < 10) {
      remainingSecondsFormated = '0$remainingSeconds';
    } else {
      remainingSecondsFormated = remainingSeconds.toString();
    }
    return '$roundedMinutes:$remainingSeconds';
  }

  _getPomodoroPercentage() {
    if (pomodoroStatus == PomodoroStatus.pausedPomodoro) {
      totalTime = pomodoroTotalTime;
    }
    if (pomodoroStatus == PomodoroStatus.runningPomodoro) {
      totalTime = pomodoroTotalTime;
    }
    if (pomodoroStatus == PomodoroStatus.runningShortBreak) {
      totalTime = shortBreakTime;
    }
    if (pomodoroStatus == PomodoroStatus.pausedShortBreak) {
      totalTime = shortBreakTime;
    }
    if (pomodoroStatus == PomodoroStatus.runningLongBreak) {
      totalTime = longBreakTime;
    }
    if (pomodoroStatus == PomodoroStatus.pausedLongBreak) {
      totalTime = longBreakTime;
    }
    if (pomodoroStatus == PomodoroStatus.setFinished) {
      totalTime = pomodoroTotalTime;
      ;
    }
    double percentage = (totalTime - remainingTime) / totalTime;
    return percentage;
  }

  _mainButtonPressed() {
    if (pomodoroStatus == PomodoroStatus.pausedPomodoro) {
      _startPomodoroCountdown();
    }
    if (pomodoroStatus == PomodoroStatus.runningPomodoro) {
      _pausePomodoroCountdown();
    }
    if (pomodoroStatus == PomodoroStatus.runningShortBreak) {
      _pauseShortBreak();
    }
    if (pomodoroStatus == PomodoroStatus.pausedShortBreak) {
      _startShortBreak();
    }
    if (pomodoroStatus == PomodoroStatus.runningLongBreak) {
      _pauseLongBreak();
    }
    if (pomodoroStatus == PomodoroStatus.pausedLongBreak) {
      _startLongBreak();
    }
    if (pomodoroStatus == PomodoroStatus.setFinished) {
      setNum++;
      _startPomodoroCountdown();
    }
  }

  _startShortBreak() {
    pomodoroStatus = PomodoroStatus.runningShortBreak;
    _cancelTimer();
    _timer = Timer.periodic(
        Duration(seconds: 1),
        (timer) => {
              if (remainingTime > 0)
                {
                  setState(() {
                    remainingTime--;
                  }),
                }
              else
                {
                  remainingTime = pomodoroTotalTime,
                  _cancelTimer(),
                  pomodoroStatus = PomodoroStatus.pausedPomodoro,
                  setState(() {
                    mainBtnText = _btnTextStart;
                  })
                }
            });
  }

  _startLongBreak() {
    pomodoroStatus = PomodoroStatus.runningLongBreak;
    _cancelTimer();
    _timer = Timer.periodic(
        Duration(seconds: 1),
        (timer) => {
              if (remainingTime > 0)
                {
                  setState(() {
                    remainingTime--;
                  }),
                }
              else
                {
                  remainingTime = pomodoroTotalTime,
                  _cancelTimer(),
                  pomodoroStatus = PomodoroStatus.pausedPomodoro,
                  setState(() {
                    mainBtnText = _btnTextSTartNewSet;
                  })
                }
            });
  }

  _pauseShortBreak() {
    pomodoroStatus = PomodoroStatus.pausedShortBreak;
    _pauseBreakCountdown();
  }

  _pauseLongBreak() {
    pomodoroStatus = PomodoroStatus.pausedShortBreak;
    _pauseBreakCountdown();
  }

  _pauseBreakCountdown() {
    _cancelTimer();
    setState(() {
      mainBtnText = _btnTextResumeBreak;
    });
  }

  _pausePomodoroCountdown() {
    pomodoroStatus = PomodoroStatus.pausedPomodoro;
    _cancelTimer();
    setState(() {
      mainBtnText = _btnTextResumePomodoro;
    });
  }

  _resetButtonPressed() {
    pomodoroNum = 0;
    setNum = 0;
    _cancelTimer();
    _stopCountdown();
  }

  _stopCountdown() {
    pomodoroStatus = PomodoroStatus.pausedPomodoro;
    setState(() {
      mainBtnText = _btnTextStart;
      remainingTime = pomodoroTotalTime;
    });
  }

  _startPomodoroCountdown() {
    pomodoroStatus = PomodoroStatus.runningPomodoro;
    _cancelTimer();
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(
        Duration(seconds: 1),
        (timer) => {
              if (remainingTime > 0)
                {
                  setState(() {
                    remainingTime--;
                    mainBtnText = _btnTextPause;
                  })
                }
              else
                {
                  pomodoroNum++,
                  _cancelTimer(),
                  if (pomodoroNum % pomodoriPerSet == 0)
                    {
                      pomodoroStatus = PomodoroStatus.pausedLongBreak,
                      setState(() {
                        remainingTime = longBreakTime;
                        mainBtnText = _btnTextStartLongBreak;
                      }),
                    }
                  else
                    {
                      pomodoroStatus = PomodoroStatus.pausedShortBreak,
                      setState(() {
                        remainingTime = shortBreakTime;
                        mainBtnText = _btnTextStartShortBreak;
                      }),
                    }
                }
            });
  }

  _cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }
}
