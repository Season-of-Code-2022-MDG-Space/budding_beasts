import 'package:flutter/material.dart';
import 'package:practise/model/pomodoro_status.dart';

const pomodoroTotalTime = 25 * 60;
const shortBreakTime = 5 * 60;
const longBreakTime = 15 * 60;
const pomodoriPerSet = 4;
const Map<PomodoroStatus, String> statusDescription = {
  PomodoroStatus.runningPomodoro: 'Pomodoro is running,Stay Focussed',
  PomodoroStatus.pausedLongBreak: 'Lets start long break',
  PomodoroStatus.pausedPomodoro: 'Ready for a focussed pomodoro?',
  PomodoroStatus.runningLongBreak: 'Long Break is running, Relax',
  PomodoroStatus.runningShortBreak: 'Short Break is running, Relax',
  PomodoroStatus.pausedShortBreak: 'Lets start short break',
  PomodoroStatus.setFinished: 'Noice! Have a Long Break!',
};
const Map<PomodoroStatus, MaterialColor> statusColor = {
  PomodoroStatus.runningPomodoro: Colors.green,
  PomodoroStatus.pausedLongBreak: Colors.orange,
  PomodoroStatus.pausedPomodoro: Colors.pink,
  PomodoroStatus.runningLongBreak: Colors.yellow,
  PomodoroStatus.runningShortBreak: Colors.red,
  PomodoroStatus.pausedShortBreak: Colors.green,
  PomodoroStatus.setFinished: Colors.orange,
};
