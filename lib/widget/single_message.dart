import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SingleMessage extends StatelessWidget {
  final String message;
  final bool isMe;
  final Timestamp waktu;
  SingleMessage(
      {required this.message, required this.isMe, required this.waktu});

  // String jam = waktu.toString();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BubbleNormal(
          text: message,
          isSender: isMe,
          color: isMe ? Color(0xFF1B97F3) : Colors.black38,
          tail: false,
          textStyle: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                waktu.toDate().year.toString() +
                    "-" +
                    waktu.toDate().month.toString() +
                    "-" +
                    waktu.toDate().day.toString() +
                    " " +
                    waktu.toDate().hour.toString() +
                    ":" +
                    waktu.toDate().minute.toString(),
                style: TextStyle(fontSize: 10),
              ),
            ),
          ],
        )
      ],
    );
  }
}
