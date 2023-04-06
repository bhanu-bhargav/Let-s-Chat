import '/widgets/chat/messages.dart';
import '/widgets/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Firebase.initializeApp();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Let's Chat"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: DropdownButton(
              icon: Icon(Icons.more_vert),
              // iconEnabledColor: Colors.white,
              underline: Container(),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Container(
                    child: Row(
                      children: const [
                        Icon(Icons.exit_to_app),
                        SizedBox(width: 8,),
                        Text('Logout')
                      ],
                    ),
                  ),)
              ], 
              
              onChanged: (itemIdentifier) {
                if(itemIdentifier == 'logout'){
                  FirebaseAuth.instance.signOut();
                }
              }),
          )
        ],
      ),
      body:Container(
        child: Column(
          children: const [
            Expanded(
              child: Messages()),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
