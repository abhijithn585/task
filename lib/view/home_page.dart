import 'dart:async';

import 'package:alarm/controller/dbcontroller.dart';
import 'package:alarm/view/addalarm.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime dateTime = DateTime.now();
  late DateTime currentime;
  late Timer timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentime = DateTime.now();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        currentime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var currenttime = DateFormat('hh:mm:ss a').format(currentime);
    var currendate = DateFormat('EEE, d MMM').format(currentime);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurpleAccent,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddAlarm(),
                ));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              height: MediaQuery.of(context).size.height * 0.1,
              child: Center(
                  child: Column(
                children: [
                  Text(
                    currenttime,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white),
                  ),
                  Text(
                    currendate,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ],
              )),
            ),
            const SizedBox(
              height: 10,
            ),
            Consumer<DbController>(
              builder: (context, value, child) {
                if (value.alarmlist.isEmpty) {
                  return Center(
                    child: Text(
                      'empty',
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: value.alarmlist.length,
                      itemBuilder: (context, index) {
                        final alarms = value.alarmlist[index];
                        return ListTile(
                          title: Text(alarms.title!),
                        );
                      },
                    ),
                  );
                }
              },
            )
          ],
        ));
  }
}
