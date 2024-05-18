import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String today = "today"; //API URL의 엔드포인트

  void getTodaysToons() async {
    final url = Uri.parse('$baseUrl/$today'); //url 서버에 요청
    final response = await http.get(url); //서버에 요청한 처리를 기다렸다가 받으면 response로 저장
    if (response.statusCode == 200) {
      //200: 요청이 성공함
      print(response.body); //서버가 보낸 데이터
      return;
    }
    throw Error();
  }
}
