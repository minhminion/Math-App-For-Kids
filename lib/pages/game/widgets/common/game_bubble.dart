import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/bubble.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';
import 'package:math_app_for_kid/widgets/w_bubble_chat.dart';

// ignore: must_be_immutable
class GameBubble extends BaseStateless {
  GameBubble({Key key, this.bubble}) : super(key: key);

  final Bubble bubble;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    String audioUrl = appTheme.assets.getCharacterVoice(bubble.type);
    return BubbleChat(
        key: ValueKey(bubble.type.index + Random().nextInt(10)),
        text: bubble.message,
        audioUrl: audioUrl);
  }
}
