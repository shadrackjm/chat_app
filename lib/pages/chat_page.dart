import 'package:chat_app/components/chat_bubble.dart';
import 'package:chat_app/components/my_textFields.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String useremail;
  final String receiverUserId;
  const ChatPage({
    super.key,
    required this.receiverUserId,
    required this.useremail,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController chatController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void sendMessage() async {
    if (chatController.text.isNotEmpty) {
      await _chatService.sendMessage(
        widget.receiverUserId,
        chatController.text,
      );
      //   // clear the controller after sending the message
      chatController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.useremail),
        centerTitle: true,
      ),
      body: Column(
        // show all messages
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          // chat input
          _buildMessageInput(),
        ],
      ),
    );
  }

  // build message list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
        widget.receiverUserId,
        _auth.currentUser!.uid,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading..');
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  // build message list item
  Widget _buildMessageItem(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    // align one to left another to right
    var alignment = (data['senderId'] == _auth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: (data['senderId'] == _auth.currentUser!.uid)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        mainAxisAlignment: (data['senderId'] == _auth.currentUser!.uid)
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          // Text(data['senderEmail']),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChatBubble(
              message: data['message'],
              color: (data['senderId'] == _auth.currentUser!.uid)
                  ? Colors.blue
                  : Colors.green,
                  time: data['timestamp'],
            ),
          ),
        ],
      ),
    );
  }

  // build input
  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: MyTextField(
            controller: chatController,
            textHint: 'Enter Message',
            ObsecureText: false,
          ),
        ),
        IconButton(
          onPressed: () => sendMessage(),
          icon: const Icon(
            Icons.arrow_upward,
            size: 40,
          ),
        ),
      ],
    );
  }
}
