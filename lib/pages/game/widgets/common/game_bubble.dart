import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_app_for_kid/models/local/bubble.dart';
import 'package:math_app_for_kid/models/local/characterVoices.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';
import 'package:math_app_for_kid/widgets/w_bubble_chat.dart';

// ignore: must_be_immutable
class GameBubble extends BaseStateless {
  GameBubble({Key key, this.bubbleType}) : super(key: key);

  final BubbleType bubbleType;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    CharacterVoice voice = appTheme.assets.getCharacterVoice(bubbleType);
    return BubbleChat(
        key: ValueKey(bubbleType.index + Random().nextInt(10)),
        text: voice.messages,
        audioUrl: voice.voiceUrl);
  }
}
