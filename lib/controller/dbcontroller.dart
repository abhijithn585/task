import 'package:alarm/model/alarm_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DbController extends ChangeNotifier {
  List<AlarmModel> alarmlist = [];

  addAlarm(AlarmModel alarm) async {
    final alarmbox = await Hive.openBox<AlarmModel>('alarmbox');
    alarmlist.add(alarm);
    alarmbox.add(alarm);
    notifyListeners();
  }

  getAlarms() async {
    final alarmbox = await Hive.openBox<AlarmModel>('alarmbox');
    alarmlist.clear();
    alarmlist = alarmbox.values.toList();
    notifyListeners();
  }
}
