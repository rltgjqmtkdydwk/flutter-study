import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoon_app/model/webtoon_datail_model.dart';
import 'package:webtoon_app/model/webtoon_episode_model.dart';
import 'package:webtoon_app/model/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today"; //API URL의 엔드포인트

  //오늘의 웹툰 리스트를 가져오는 메소드
  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = []; //웹툰 리스트
    final url = Uri.parse('$baseUrl/$today'); //url 서버에 요청
    final response = await http.get(url); //서버에 요청한 처리를 기다렸다가 받으면 response로 저장
    if (response.statusCode == 200) {
      //200: 요청이 성공함
      //jsonDecode(): string을 json으로 디코딩
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        final instance = WebtoonModel.fromJson(webtoon);
        webtoonInstances.add(instance);
      }
      return webtoonInstances;
    }
    throw Error();
  }

  //id로 해당 웹툰의 상세정보를 가져오는 메소드
  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  //웹툰의 최신 에피소드 리스트를 가져오는 메소드
  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse('$baseUrl/$id/episodes');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }
}
