import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:math_app_for_kid/models/local/bubble.dart';
import 'package:math_app_for_kid/utils/app_assets.dart';
import 'package:rive/rive.dart';

enum CharacterType { success, fail, idle, start }

class CharacterProvider extends ChangeNotifier {
  CharacterProvider() {
    loadRiveFile();
  }

  AppAssets assets = AppAssets.origin();
  Artboard riveArtboard;
  CharacterType _characterType = CharacterType.idle;
  List<MixinAnimation> _mixinController = List<MixinAnimation>.filled(4, null);

  Bubble _bubble;

  CharacterType get characterType => _characterType;
  Bubble get bubble => _bubble;

  Future<void> loadRiveFile() async {
    notifyListeners();
    final bytes = await rootBundle.load(assets.characterRiv);
    setRive(bytes);
  }

  void setRive(dynamic bytes) {
    final file = RiveFile.import(bytes);
    riveArtboard = file.mainArtboard
      ..addController(_mixinController[CharacterType.idle.index] =
          MixinAnimation("Idle", CharacterType.idle))
      ..addController(_mixinController[CharacterType.fail.index] =
          MixinAnimation("False", CharacterType.fail))
      ..addController(_mixinController[CharacterType.success.index] =
          MixinAnimation("Success", CharacterType.success))
      ..addController(_mixinController[CharacterType.start.index] =
          MixinAnimation("Start", CharacterType.start));

    changeAnimation(CharacterType.idle);
  }

  void changeAnimation(CharacterType type) {
    if (riveArtboard == null) return;
    // riveArtboard.removeController(_controller);

    switch (type) {
      case CharacterType.idle: // Idle
      case CharacterType.start:
        _mixinController[type.index].start();
        _mixinController.forEach((_controller) {
          if (_controller != null && _controller.characterType != type) {
            _controller.stop();
          }
        });
        break;
      default: // False, Success, Start
        _mixinController[type.index].start();
        _mixinController[this.characterType != null
                ? this.characterType.index
                : type.index]
            .stop();
        break;
    }

    this._characterType = type;

    // riveArtboard.addController(_controller);
    notifyListeners();
  }

  void showBubble(BubbleType type) {
    this._bubble = new Bubble("Xin chào bạn", type ?? BubbleType.success);
    notifyListeners();
  }
}

class MixinAnimation extends SimpleAnimation {
  MixinAnimation(String animationName, this.characterType)
      : super(animationName);

  final CharacterType characterType;

  start() {
    instance.animation.loop = Loop.pingPong;
    isActive = true;
  }

  stop() => instance.animation.loop = Loop.oneShot;
}
