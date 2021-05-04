import 'package:math_app_for_kid/models/local/characterVoices.dart';

class AppSounds {
  AppSounds._();

  static String defaultRoot = "base/audios";

  static List<CharacterVoice> characterIdleVoice = [
    CharacterVoice("Xin chào bạn!", defaultRoot + "/zalo_hello_audio.mp3"),
  ];

  static List<CharacterVoice> characterSuccessVoice = [
    CharacterVoice("Đúng rồi!", defaultRoot + "/zalo_success_audio1.mp3"),
    CharacterVoice("Chính xác rồi!", defaultRoot + "/zalo_success_audio2.mp3"),
  ];

  static List<CharacterVoice> characterFailVoice = [
    CharacterVoice(
        "Sai rồi, bạn hãy thử lại!", defaultRoot + "/zalo_fail_audio1.mp3"),
    CharacterVoice("Không đúng rồi!", defaultRoot + "/zalo_fail_audio2.mp3"),
  ];

  static String fxBubbleBlip = defaultRoot + "/fx/bubble_blip.mp3";
  static String fxBlinkTwice = defaultRoot + "/fx/blink_twice.mp3";
  static String fxMultimediaAlarm = defaultRoot + "/fx/multimedia_alarm.mp3";
}
