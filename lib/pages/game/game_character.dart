import 'package:flutter/material.dart';
import 'package:math_app_for_kid/services/app/character_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateful.dart';
import 'package:math_app_for_kid/widgets/w_bubble_chat.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class GameCharacter extends StatefulWidget {
  GameCharacter({Key key}) : super(key: key);

  @override
  _GameCharacterState createState() => _GameCharacterState();
}

class _GameCharacterState extends BaseStateful<GameCharacter>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animation;

  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));

    _animation = Tween<Offset>(
      begin: Offset(-1.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      children: [
        SizedBox(height: 50),
        Selector<CharacterProvider, CharacterType>(
          selector: (_, _charaterProvider) => _charaterProvider.characterType,
          builder: (_, characterType, __) => Material(
            color: Colors.transparent,
            child: _buildBubble(characterType),
          ),
        ),
        Container(
          height: 180,
          width: 200,
          child: SlideTransition(
              position: _animation,
              child: Selector<CharacterProvider, Artboard>(
                selector: (_, _charaterProvider) =>
                    _charaterProvider.riveArtboard,
                builder: (_, riveArtboard, __) => Material(
                  color: Colors.transparent,
                  child: riveArtboard == null
                      ? const SizedBox()
                      : Rive(
                          artboard: riveArtboard,
                          fit: BoxFit.contain,
                        ),
                ),
              )),
        ),
      ],
    );
  }

  Widget _buildBubble(CharacterType type) {
    switch (type) {
      case CharacterType.success:
        return BubbleChat(
          key: ValueKey(CharacterType.success),
          text: 'Đúng rồi, bạn thật giỏi',
        );

      case CharacterType.fail:
        return BubbleChat(
          key: ValueKey(CharacterType.fail),
          text: 'Sai rồi, bạn hãy thử lại',
        );

      case CharacterType.idle:
        return BubbleChat(
          key: ValueKey(CharacterType.idle),
          text: 'Xin chào bạn!',
        );
      default:
        return SizedBox(
          height: 90,
        );
    }
  }
}
