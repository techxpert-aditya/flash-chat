// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User? loggedInUser;
  late String messageText;

  void getCurrentUser() async {
    try {
      // ignore: await_only_futures
      final user = await _auth.currentUser;
      if (user != null) {
        setState(() {
          loggedInUser = user;
        });
        print(loggedInUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void getMessagesStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var msg in snapshot.docs) {
        print(msg.data()['sender']);
        print(msg.data()['text']);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              // _auth.signOut();
              // Navigator.pop(context);
              getMessagesStream();
            },
          ),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: const Color(0xFF393E46),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'images/back.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white
                    .withOpacity(0.5), // Semi-transparent white color
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const StreamBuilderWidget(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Material(
                            elevation: 5,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(50),
                                bottomLeft: Radius.circular(50)),
                            child: TextField(
                              controller: messageTextController,
                              onChanged: (value) {
                                // Do something with the user input.
                                messageText = value;
                              },
                              decoration: kMessageTextFieldDecoration,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              messageTextController.clear();
                              _firestore.collection('messages').add({
                                'sender': loggedInUser?.email,
                                'text': messageText,
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              backgroundColor: const Color(0xFF00ADB5),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(50),
                                    bottomRight: Radius.circular(50)),
                              ), // Make the button circular
                            ),
                            child: const Icon(
                              Icons.send,
                              color: Color(0xFFEEEEEE),
                            ),
                            // child: const Text(
                            //   'Send',
                            //   style: kSendButtonTextStyle,
                            // ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StreamBuilderWidget extends StatelessWidget {
  const StreamBuilderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('messages').snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        // Data is ready
        final List<DocumentSnapshot<Map<String, dynamic>>> documents =
            snapshot.data!.docs;

        List<MessageBubble> messageBubbles = [];
        for (var msg in documents) {
          final messageText = msg.data()!['text'];
          final messageSender = msg.data()!['sender'];

          final messageBubble =
              MessageBubble(text: messageText, sender: messageSender);

          messageBubbles.add(messageBubble);
        }

        return Expanded(
          child: ListView(
            children: messageBubbles,
          ),
        );
        // return Expanded(
        //   child: ListView.builder(
        //     itemCount: documents.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       final document = documents[index];
        //       final field1 = document.data()!['sender'];
        //       // Access individual document fields using document.data() map
        //       final field2 = document.data()!['text'];

        //       // Return a widget displaying the document data
        //       return ListTile(
        //         title: Text(field1),
        //         subtitle: Text(field2),
        //       );
        //     },
        //   ),
        // );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.text, required this.sender});

  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: const TextStyle(
              color: Colors.black45,
              fontSize: 12,
            ),
          ),
          Material(
            elevation: 5,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            color: const Color(0xFF00ADB5),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
