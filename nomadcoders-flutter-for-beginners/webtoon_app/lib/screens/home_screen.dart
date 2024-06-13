import 'package:flutter/material.dart';
import 'package:webtoon_app/model/webtoon_model.dart';
import 'package:webtoon_app/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

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
            return ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                print(index); //메모리 효율을 위해 보여지는 item의 인덱스만 찾는다.
                var webtoon = snapshot.data![index];
                return Text(webtoon.title);
              },
              separatorBuilder: (context, index) => const SizedBox(
                width: 20,
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
