import 'package:ddm/board.dart';
import 'package:flutter/material.dart';

import 'chat.dart';
import 'friend.dart';
import 'map.dart';

import 'setting.dart';
import 'notification.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int _selectedIndex = 2;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    boardPage(),
    friendPage(),
    mainPage(),
    mapPage(),
    chatPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xff64DCAC),
        unselectedItemColor: Color(0xff1C1B1F),
        selectedLabelStyle: TextStyle(color: Color(0xff64DCAC)),
        unselectedLabelStyle: TextStyle(color: Color(0xff1C1B1F)),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list_alt,
            ),
            label: '게시판',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: '친구',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: '위치',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: '채팅',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class mainPage extends StatefulWidget {
  @override
  _mainPageState createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  String selectedStatus = '밥 먹어요'; // Default dropdown value
  final List<String> statusOptions = [
    '카공해요',
    '밥 먹어요',
    '편의점 가요',
    '한한 해요'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'ddm?',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications , color: Colors.black),
            onPressed: () {
              // Settings button action
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              // Settings button action
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
        leading: SizedBox(), // Placeholder to center the title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('종강', style: TextStyle(fontSize: 18)),
                Text('D-65', style: TextStyle(fontSize: 18, color: Colors.red)),
                Text('2학기', style: TextStyle(fontSize: 18)),
                Text('D+16', style: TextStyle(fontSize: 18, color: Colors.blue)),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(height: 10),
            Text(
              '나',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '“같이 밥 먹어요~”',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('공강', style: TextStyle(fontSize: 16)),
                Switch(
                  value: true,
                  onChanged: (value) {},
                  activeColor: Colors.greenAccent,
                ),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedStatus,
                  icon: Icon(Icons.arrow_drop_down),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedStatus = newValue!;
                    });
                  },
                  items: statusOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
                          Text(value),
                          SizedBox(width: 8),
                          Icon(
                            _getStatusIcon(value),
                            size: 16,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              '현재 친구의 공강 상태를 확인하세요!',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(radius: 30),
                CircleAvatar(radius: 30),
                CircleAvatar(radius: 30),
                CircleAvatar(radius: 30),
                CircleAvatar(radius: 30),
              ],
            ),
            SizedBox(height: 20),
            Text(
              '내 친구들이 모인 게시판을 확인하세요!',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.greenAccent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case '카공해요':
        return Icons.book;
      case '밥 먹어요':
        return Icons.restaurant;
      case '편의점 가요':
        return Icons.local_convenience_store;
      case '한한 해요':
        return Icons.directions_walk;
      default:
        return Icons.help;
    }
  }
}
