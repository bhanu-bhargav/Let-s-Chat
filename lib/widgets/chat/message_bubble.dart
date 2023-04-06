import 'package:flutter/material.dart';


class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String username;
  final String userImage;
  MessageBubble(this.message,this.username,this.userImage, this.isMe,);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
        mainAxisAlignment: isMe? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: const BoxConstraints(
              maxWidth: 250
            ),
            decoration: BoxDecoration(
              color: isMe? Theme.of(context).colorScheme.primary : Colors.grey[600],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              )
            ),
            // width: 140,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16
            ),
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 10,
            ),
            child: Column(
              crossAxisAlignment: isMe? CrossAxisAlignment.end: CrossAxisAlignment.start ,
              children: [
                Text(username, style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isMe? Colors.white : Colors.black,
                ),
                textAlign:TextAlign.start,),
                Text(message, style: TextStyle(
                  color: isMe? Colors.white : Colors.black,),),
              ],
            ),
          ),
        ],
      ),
      Positioned(
        top: -5,
        left: isMe? null : 0,
        right: isMe? 0 : null,
        child: CircleAvatar(
          radius: 15,
          backgroundColor: isMe? Theme.of(context).colorScheme.primary : Colors.grey,
          backgroundImage: NetworkImage(userImage),
        )),
      ],
    );
  }
}