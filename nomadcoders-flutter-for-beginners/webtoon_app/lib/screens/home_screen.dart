import 'package:flutter/material.dart';
import 'package:webtoon_app/model/webtoon_model.dart';
import 'package:webtoon_app/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(fontSize: 24),
        ),
      ),
      // 똑똑한 data fetching : FutureBuilder() 쓰기
      body: FutureBuilder(
        future: webtoons, //자동으로 await
        builder: (context, snapshot) {
          //snapshot: future의 상태
          if (snapshot.hasData) {
            return const Text("There is data!");
          } else {
            return const Text("Loading....");
          }
        },
      ),
    );
  }
}
