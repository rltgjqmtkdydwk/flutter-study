import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool showTitle = true;
  IconData currentIcon = Icons.visibility;

  void toggleTitle() {
    setState(() {
      showTitle = !showTitle;

      if (currentIcon == Icons.visibility) {
        currentIcon = Icons.visibility_off;
      } else {
        currentIcon = Icons.visibility;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFF4EDDB),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              showTitle ? const MyLargeTitle() : const Text("nothing"),
              IconButton(onPressed: toggleTitle, icon: Icon(currentIcon))
            ],
          ),
        ),
      ),
    );
  }
}

// StatefulWidget은 lifecycle이 있다. = 살아있다.
class MyLargeTitle extends StatefulWidget {
  const MyLargeTitle({
    super.key,
  });

  @override
  State<MyLargeTitle> createState() => _MyLargeTitleState();
}

class _MyLargeTitleState extends State<MyLargeTitle> {
  int count = 0; // 일반적인 초기화

  // initState() : 데이터 초기화하는 메서드(특히, 부모요소에 의존하는 데이터 초기화)
  // build() 이전에 호출. 한번만 호출. 예) api 업데이트 반영.
  @override
  void initState() {
    super.initState();
    print("init!");
  }

  // dispose() : 위젯이 스크린에서 제거될 때 호출되는 메서드
  // 위젯을 위젯 트리에서 제거하기 전에 무언가를 취소. 예) 이벤트 리스너 취소.
  @override
  void dispose() {
    super.dispose();
    print("dispose!");
  }

  // build() : 위젯에서 UI를 만듦
  @override
  Widget build(BuildContext context) {
    print("build!");
    return Text(
      'My Large Title',
      style: TextStyle(
        fontSize: 30,
        color: Theme.of(context).textTheme.titleLarge?.color,
      ),
    );
  }
}
