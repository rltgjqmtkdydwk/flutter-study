import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webtoon_app/screens/home_screen.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key}); // 모든 widget은 key를 갖고 있다(=flutter가 위젯을 식별하는 ID)

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

//user-agent 헤더를 바꿔주어야 함. (http가 유저-클라이언트 통신 방식(=프로토콜)이라서)
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..userAgent =
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36';
  }
}
