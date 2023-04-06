import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Messages extends StatelessWidget {
  const Messages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt', descending: true).snapshots(),
      builder: (ctx, chatSnapshot) {
        if(chatSnapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          reverse: true,
          itemCount: chatSnapshot.data.docs.length,
          itemBuilder: (ctx, index) => MessageBubble(
            chatSnapshot.data.docs[index]['text'],
            chatSnapshot.data.docs[index]['username'],
            chatSnapshot.data.docs[index]['userImage'],
            chatSnapshot.data.docs[index]['userId'] == user.uid,),);
      },
    );
  }
}