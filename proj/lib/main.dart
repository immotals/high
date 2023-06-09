import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void fetchData() async {
  var url = Uri.parse('https://example.com/api/data'); // 서버의 API 엔드포인트 URL
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    // 데이터 처리
    // 예: 데이터를 모델로 변환하거나 UI에 표시하기 위해 상태 업데이트
    // 데이터 활용 예시: 각 항목의 title 출력
    for (var item in data) {
      var title = item['title'];
      if (kDebugMode) {
        print(title);
      }
    }
  } else {
    if (kDebugMode) {
      print('Failed to fetch data. Error: ${response.statusCode}');
    }
  }
}
void main() => runApp(const PortfolioApp());

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('images/profile_image.jpg'), // 프로필 이미지
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '이름: 정성재',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '소개\n'
                    '생년월일 1999년 4월2일\n'
                    '출생지: 부산광역시\n'
                    '최종학력:경성대학교 재학\n',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            const SizedBox(height: 16.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '프로젝트',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16.0),
            const ProjectItem(
              title: '프로젝트 1: math challenge',
              description: '다향한 수학 문제들을 모아놓은 웹사이트로 수학문제를 해결하여 수학능력 향상',
              imageUrl: 'images/project_image1.jpg',
            ),
            const ProjectItem(
              title: '프로젝트 2: 레고 NXT',
              description: '로봇을 만들고 프로그래밍',
              imageUrl: 'images/project_image2.jpg',
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectItem extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const ProjectItem({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(imageUrl), // 프로젝트 이미지
          const SizedBox(height: 8.0),
          Text(
            title,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4.0),
          Text(
            description,
            style: const TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
