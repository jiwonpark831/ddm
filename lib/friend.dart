// friendPage.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chat.dart';
import 'recommend_friends.dart';
import 'friendsRequest.dart';
import 'chat.dart'; // Import the chat page
import 'package:provider/provider.dart';
import 'app_state.dart';

class friendPage extends StatefulWidget {
  const friendPage({super.key});

  @override
  State<friendPage> createState() => friendPageState();
}

class friendPageState extends State<friendPage> {
  Map<String, bool> friends = {};
  List<Map<String, String>> friendsNameStatus = [];

  @override
  void initState() {
    super.initState();
    getfriendList();
  }

  getfriendList() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (doc.data() != null && doc.get('friendList') != null) {
      friends = Map<String, bool>.from(doc.get('friendList'));
    }

    for (var entry in friends.entries) {
      String key = entry.key;
      bool value = entry.value;
      if (value) {
        var friend =
            await FirebaseFirestore.instance.collection('user').doc(key).get();
        if (friend.get('friendList')[FirebaseAuth.instance.currentUser!.uid]) {
          friendsNameStatus.add({
            'name': friend.get('name'),
            'status': friend.get('status'),
            'uid': friend.get('uid')
          });
        }
      }
    }
    setState(() {});
  }

  Future<String> _getOrCreateChatRoom(String friendUid) async {
    final String currentUserUid = FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot chatRooms = await FirebaseFirestore.instance
        .collection('chat')
        .where('members', arrayContains: currentUserUid)
        .get();

    for (var room in chatRooms.docs) {
      List<dynamic> members = room['members'];
      if (members.contains(friendUid)) {
        return room.id; // Existing chat room found
      }
    }

    DocumentReference newChatRoom =
        FirebaseFirestore.instance.collection('chat').doc();
    await newChatRoom.set({
      'members': [currentUserUid, friendUid],
      'lastMessage': '',
      'timestamp': FieldValue.serverTimestamp(),
    });

    return newChatRoom.id;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(builder: (context, appState, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text('내 친구', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FriendsRequestPage()),
                );
              },
              child: Text('친구 요청', style: TextStyle(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecommendFriendsPage()),
                );
              },
              child: Text('+ 추천 친구', style: TextStyle(color: Colors.black)),
            ),
          ],
          leading: SizedBox(),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: '친구를 검색해보세요',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.all(8.0),
                itemCount: friendsNameStatus.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.blue[100],
                      child: Icon(Icons.person, color: Colors.black),
                    ),
                    title: Text(friendsNameStatus[index]['name']!,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(friendsNameStatus[index]['status']!),
                    trailing: ElevatedButton(
                      onPressed: () async {
                        String friendUid = friendsNameStatus[index]['uid']!;
                        String chatRoomId =
                            await _getOrCreateChatRoom(friendUid);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                eachChatPage(chatRoomId: chatRoomId),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                      ),
                      child: Text('1:1 채팅'),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  // Add new friend action
                },
                child: Text(
                  '+ 친구 추가',
                  style: TextStyle(color: Colors.greenAccent),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.article), label: '게시판'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: '친구'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
            BottomNavigationBarItem(icon: Icon(Icons.location_on), label: '위치'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: '채팅'),
          ],
        ),
      );
    });
  }
}
