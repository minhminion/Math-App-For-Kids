import 'package:flutter/services.dart';
import 'package:math_app_for_kid/services/safety/change_notifier_safety.dart';
import 'package:math_app_for_kid/utils/app_assets.dart';
import 'package:rive/rive.dart';

enum CharacterType { start, success, idle, fail, talk }

class CharacterProvider extends ChangeNotifierSafety {
  AppAssets assets = AppAssets.origin();
  Artboard _riveArtboard;
  RiveAnimationController _controller;

  Artboard get riveArtboard => _riveArtboard;

  void loadRiveFile() async {
    final bytes = await rootBundle.load(assets.characterRiv);
    final file = RiveFile();
    if (file.import(bytes)) {
      _riveArtboard = file.mainArtboard
        ..addController(_controller = SimpleAnimation("Idle"));
    }

    _controller.isActiveChanged.addListener(() {
      if (_controller.isActive) {
        print('Animation started playing');
      } else {
        changeAnimation(CharacterType.idle);
      }
    });
  }

  void changeAnimation(CharacterType type) {
    _riveArtboard.removeController(_controller);

    switch (type) {
      case CharacterType.fail: // False

        _controller = SimpleAnimation('False');

        break;
      case CharacterType.success: // Success

        _controller = SimpleAnimation('Success');

        break;
      case CharacterType.talk: // Talk

        _controller = SimpleAnimation('Talk');

        break;
      case CharacterType.start: // Start

        _controller = SimpleAnimation('Start');

        break;
      default: // Idle

        _controller = SimpleAnimation('Idle');
        // _riveArtboard.addController(SimpleAnimation('Idle'));
        break;
    }

    _riveArtboard.addController(_controller);
    notifyListeners();
  }

  @override
  void resetState() {
    // TODO: implement resetState
  }
}
