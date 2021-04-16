import 'package:math_app_for_kid/models/local/bubble.dart';
import 'package:math_app_for_kid/models/local/game.dart';

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

  String getCharacterVoice(BubbleType bubbleType) {
    String audioUrl = "";

    switch (bubbleType) {
      case BubbleType.success:
        audioUrl = 'base/audios/success_audio.mp3';
        break;
      case BubbleType.hello:
        audioUrl = 'base/audios/hello_audio.mp3';
        break;
      case BubbleType.error:
        audioUrl = 'base/audios/error_audio.mp3';
        break;
    }

    return audioUrl;
  }

  ///#endregion
  ///#region VIDEOS
  /// -----------------
  ///#endregion
}
