import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 타이머 기능
  int totalseconds = 1500;
  late Timer timer;

  void onTick(Timer timer) {
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
              '$totalseconds',
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
                onPressed: onStartPressed, // 타이머 실행(멈추지 않음)
                icon: const Icon(Icons.play_circle_outline),
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
                        Text('0',
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
