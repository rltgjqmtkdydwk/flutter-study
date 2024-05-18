import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  // 타이머 기능
  int totalseconds = twentyFiveMinutes;
  bool isRunning = false;
  int totalPomodoros = 0;
  late Timer timer;

  void onTick(Timer timer) {
    if (totalseconds == 0) {
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        isRunning = false;
        totalseconds = totalseconds - 1;
      });
    }
    // state를 변경(totalseconds-1)
    setState(() {
      totalseconds -= 1;
    });
  }

  void onStartPressed() {
    // timer는 매 초마다 onTick()을 실행시킴
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7);
  }

  // pause 기능
  void onPausePressed() {
    timer.cancel(); // 타이머 정지
    isRunning = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(children: [
        Flexible(
          flex: 1,
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              format(totalseconds),
              style: TextStyle(
                  color: Theme.of(context)
                      .cardColor, //BuildContext를 이용해 다른 위젯의 cardColor 참조
                  fontSize: 89,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Flexible(
            flex: 2,
            child: Center(
              child: IconButton(
                iconSize: 120,
                color: Theme.of(context)
                    .cardColor, //BuildContext를 이용해 다른 위젯의 cardColor 참조
                onPressed: isRunning
                    ? onPausePressed
                    : onStartPressed, // isRunning에 따라 일시정지 : 실행
                icon: Icon(
                  isRunning
                      ? Icons.play_circle_outline
                      : Icons.pause_circle_filled_outlined,
                ), // isRunning에 따라 실행버튼 : 일시정지버튼
              ),
            )),
        Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .cardColor, //BuildContext를 이용해 다른 위젯의 cardColor 참조
                        borderRadius: BorderRadius.circular(50)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodors',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .color),
                        ),
                        Text('$totalPomodoros',
                            style: TextStyle(
                              fontSize: 58,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context)
                                  .textTheme
                                  .displayLarge! //이미 앞서 정의해줬기 때문에 null이 아니라는 뜻
                                  .color,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ]),
    );
  }
}
