import 'package:flutter/material.dart';

class boardPage extends StatefulWidget {
  const boardPage({super.key});

  @override
  State<boardPage> createState() => _boardPageState();
}

class _boardPageState extends State<boardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 모임'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '내 모임',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                MeetingCard(
                  title: '치즈볼 맛집 찾기',
                  date: '매주 수요일',
                  time: '12:00 - 14:00',
                  location: '익선동황금 빵',
                  imageUrl: 'https://example.com/cheeseball.jpg',
                ),
                SizedBox(width: 8),
                MeetingCard(
                  title: '중고교사 성적 내기',
                  date: '매주 화, 금',
                  time: '18:00 - 22:00',
                  location: '노원 410(A)',
                  imageUrl: 'https://example.com/teachers.jpg',
                ),
                SizedBox(width: 8),
                AddMeetingCard(),
              ],
            ),
            SizedBox(height: 32),
            Text(
              '모임 게시판',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Card(
              child: Text("장기모임"),
            ),
            Card(
              child: Text("단기모임"),
            ),
            Card(
              child: Text("찜한모임"),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () {},
              child: Text('+ 모임 만들기', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

class MeetingCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String location;
  final String imageUrl;

  MeetingCard({
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Column(
          children: [
            Image.network(imageUrl, height: 100, fit: BoxFit.cover),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('$date\n$time\n$location',
                      style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddMeetingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Center(
          child: Icon(Icons.add, size: 40, color: Colors.grey),
        ),
      ),
    );
  }
}

class MeetingBoardCard extends StatelessWidget {
  final String title;

  MeetingBoardCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}