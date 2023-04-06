import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _enteredMessage = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData['username'],
      'userImage': userData['image_url']
    });
    _controller.clear();
    setState(() {
      _enteredMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              constraints: const BoxConstraints(
                minHeight: 45,
                maxHeight: 100
              ),
              child: SingleChildScrollView(
                child: TextField(
                controller: _controller,
                textCapitalization: TextCapitalization.sentences,
                maxLines: null,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                    hintText: 'Message',
                    hintStyle: TextStyle(
                  color: Colors.black,
                ),
                    fillColor: Color.fromARGB(255, 238, 193, 208),
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.white, width: 1))),
                onChanged: (value) {
                  setState(() {
                    _enteredMessage = value;
                  });
                },
                        ),
              ),
            )),
          IconButton(
              color: Theme.of(context).colorScheme.primary,
              onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
              icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
