import 'dart:math';

import 'package:math_app_for_kid/models/local/bubble.dart';
import 'package:math_app_for_kid/models/local/characterVoices.dart';
import 'package:math_app_for_kid/models/local/games.dart';
import 'package:math_app_for_kid/utils/app_sounds.dart';

class AppAssets {
  AppAssets._();

  /// Default theme
  factory AppAssets.origin() {
    return AppAssets._();
  }

  static String rootAsset = "assets/base";

  ///#region FONTS
  /// -----------------
  String fontRoboto = 'Roboto';
  String fontLato = 'Lato';
  String fontUntoldStory = 'UntoldStory';
  String fontFira = 'Fira';
  String fontIOSDisplay = '.SF UI Display';
  String fontIOSDefault = '.SF UI Text';

  ///#endregion
  ///#region IMAGES, ICONS
  /// -----------------
  String icAppIcon = '$rootAsset/app_icon_ad.png';
  String icEmpty = '$rootAsset/ic_empty.png';
  String characterRiv = '$rootAsset/character/astronaut.riv';
  String characterWithBoxRiv = '$rootAsset/character/astronaut_with_box.riv';

  String backgroundLanding = '$rootAsset/images/bg_landing.png';

  String planet(id) => '$rootAsset/images/planet/planet_$id.png';
  String gameTrophy = '$rootAsset/images/others/game_trophy.png';
  String gameBox = '$rootAsset/images/others/box.png';
  String glassButton = '$rootAsset/images/others/glass_button.png';

  String getShapeImages(ShapeType shapeType, int id) {
    switch (shapeType) {
      case ShapeType.circle:
        return '$rootAsset/images/shapes/circle_$id.png';
      case ShapeType.square:
        return '$rootAsset/images/shapes/square_$id.png';
      case ShapeType.rectangle:
        return '$rootAsset/images/shapes/rectangle_$id.png';
      case ShapeType.triangle:
        return '$rootAsset/images/shapes/triangle_$id.png';
    }
    return "";
  }

  CharacterVoice getCharacterVoice(BubbleType bubbleType) {
    CharacterVoice _result;
    List<CharacterVoice> _characterVoices;
    switch (bubbleType) {
      case BubbleType.success:
        _characterVoices = AppSounds.characterSuccessVoice;
        _result = _characterVoices[Random().nextInt(_characterVoices.length)];
        break;
      case BubbleType.hello:
        _characterVoices = AppSounds.characterIdleVoice;
        _result = _characterVoices[Random().nextInt(_characterVoices.length)];
        break;
      case BubbleType.error:
        _characterVoices = AppSounds.characterFailVoice;
        _result = _characterVoices[Random().nextInt(_characterVoices.length)];
        break;
    }

    return _result;
  }

  List<String> gameCardBackgrounds = [
    '$rootAsset/images/others/game_card_background_1.png',
    '$rootAsset/images/others/game_card_background_2.png'
  ];

  String getGameCardBackground(int gameIndex) {
    return gameCardBackgrounds[(gameIndex + 1) % gameCardBackgrounds.length];
  }

  // LOTTIE
  String lottieCongratulations = '$rootAsset/lottie/congratulations.json';

  ///#endregion
  ///#region VIDEOS
  /// -----------------
  ///#endregion
}
