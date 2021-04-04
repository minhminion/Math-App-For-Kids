class AppAssets {
  AppAssets._();

  /// Default theme
  factory AppAssets.origin() {
    return AppAssets._();
  }

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
  String icAppIcon = 'assets/base/icons/app_icon_ad.png';
  String icEmpty = 'assets/base/icons/ic_empty.png';
  String characterRiv = 'assets/base/character/astronaut.riv';

  String backgroundLanding = 'assets/base/images/bg_landing.png';

  String planet(id) => 'assets/base/images/planet/planet_$id.png';
  String gameTrophy = 'assets/base/images/others/game_trophy.png';

  ///#endregion
  ///#region VIDEOS
  /// -----------------
  ///#endregion
}
