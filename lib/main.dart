import 'dart:async';

import 'package:flutter/material.dart';
import 'dice.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Timer timer;
  late Dice dice;
  int pickNumber = 0;
  List<int> result = [];
  int _currentHorizontalIntValue = 10;

  void start() {
    isEnd = false;
    isRunning = true;
    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        pickNumber = dice.shuffle().first;
      });
    });
  }

  void select() {
    setState(() {
      result.add(dice.pick());
      if (result.length == dice.size) {
        end();
        isRunning = false;
        isEnd = true;
      }
    });
  }

  //상태 검사를 하는 변수
  // 끝났는가? 동작 중인가?
  bool isEnd = true;
  bool isRunning = false;

  void end() {
    setState(() {
      timer.cancel();
      isEnd = true;
      isRunning = false;
    });
  }
  // 셔플 멈추기 기능

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            NumberPicker(
              value: _currentHorizontalIntValue,
              minValue: 0,
              maxValue: 100,
              step: 10,
              itemHeight: 50,
              axis: Axis.vertical,
              onChanged: (value) =>
                  setState(() => _currentHorizontalIntValue = value),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black26),
              ),
            ),
            Flexible(
                flex: 3,
                child: Center(
                    child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: Colors.amber,
                        child: Center(
                          child: Text(
                            '$pickNumber',
                            style: const TextStyle(
                                fontSize: 100, color: Colors.red),
                          ),
                        )))),
            Flexible(
                child: Center(
              child: Text('$result'),
            )),
            Flexible(
                flex: 2,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          iconSize: 100,
                          onPressed: () {
                            if (!isRunning) {
                              dice = Dice(size: _currentHorizontalIntValue);
                              isRunning = true;
                              start();
                            } else {
                              null;
                            }
                          },
                          icon: const Icon(Icons.play_circle_rounded)),
                      IconButton(
                          iconSize: 100,
                          onPressed: () {
                            if (isRunning) {
                              select();
                            } else {
                              null;
                            }
                          },
                          icon: const Icon(Icons.check_circle_outline)),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
