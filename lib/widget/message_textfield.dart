import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MessageTextField extends StatefulWidget {
  final String currentId;
  final String frendId;

  MessageTextField(this.currentId, this.frendId);

  @override
  State<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: "Tulis Pesan disini..",
              fillColor: Colors.grey[100],
              filled: true,
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 0,
                  ),
                  gapPadding: 10,
                  borderRadius: BorderRadius.circular(25)),
            ),
          )),
          SizedBox(
            width: 20,
          ),
          GestureDetector(
              onTap: () async {
                String message = _controller.text;
                _controller.clear();
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.currentId)
                    .collection('messages')
                    // .doc('ibHr3iGCZBQhUX7ZiW3G1rKS2fd2')
                    .doc('JWkjx78n7udJRyeuglm8B6Wa51r1')
                    .collection('chats')
                    .add({
                  "senderId": widget.currentId,
                  "receiverId": widget.frendId,
                  "message": message,
                  "type": "text",
                  "date": DateTime.now()
                }).then((value) {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.currentId)
                      .collection('messages')
                      // .doc('ibHr3iGCZBQhUX7ZiW3G1rKS2fd2')
                      .doc('JWkjx78n7udJRyeuglm8B6Wa51r1')
                      .set({'last_msg': message, 'date': DateTime.now()});
                });

                await FirebaseFirestore.instance
                    .collection('users')
                    // .doc('ibHr3iGCZBQhUX7ZiW3G1rKS2fd2')
                    .doc('JWkjx78n7udJRyeuglm8B6Wa51r1')
                    .collection('messages')
                    .doc(widget.currentId)
                    .collection('chats')
                    .add({
                  "senderId": widget.currentId,
                  "receiverId": 'JWkjx78n7udJRyeuglm8B6Wa51r1',
                  "message": message,
                  "type": "text",
                  "date": DateTime.now()
                }).then((value) {
                  FirebaseFirestore.instance
                      .collection('users')
                      // .doc('ibHr3iGCZBQhUX7ZiW3G1rKS2fd2')
                      .doc('JWkjx78n7udJRyeuglm8B6Wa51r1')
                      .collection('messages')
                      .doc(widget.currentId)
                      .set({'last_msg': message, 'date': DateTime.now()});
                });
              },
              child: Container(
                  padding: EdgeInsets.all(8),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                  child: Icon(Icons.send, color: Colors.white)))
        ],
      ),
    );
  }
}
