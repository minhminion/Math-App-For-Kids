import 'package:flutter/material.dart';
import 'package:math_app_for_kid/widgets/w_bubble_chat.dart';

class MyTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: Text('Text page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            BubbleChat(
              text: 'Sai rồi, bạn hãy thử lại',
            ),
          ],
        ),
      ),
    );
  }
}
