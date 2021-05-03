import 'package:math_app_for_kid/models/local/characterVoices.dart';

class AppSounds {
  AppSounds._();

  static String defaultRoot = "base/audios";

  static List<CharacterVoice> characterIdleVoice = [
    CharacterVoice("Chào bạn", defaultRoot + "/hello_audio.mp3"),
  ];

  static List<CharacterVoice> characterSuccessVoice = [
    CharacterVoice("Đúng rồi bạn thật giỏi, mình cùng qua bài tiếp theo nhé",
        defaultRoot + "/success_audio.mp3"),
    CharacterVoice("Chính xác, mình cùng qua bài tiếp theo nhé",
        defaultRoot + "/success_audio.mp3"),
  ];

  static List<CharacterVoice> characterFailVoice = [
    CharacterVoice("Sai rồi, bạn hãy thử lại lần nữa xem",
        defaultRoot + "/error_audio.mp3"),
    CharacterVoice("Không đúng rồi", defaultRoot + "/error_audio.mp3"),
  ];

  static String fxBubbleBlip = defaultRoot + "/fx/bubble_blip.mp3";
  static String fxBlinkTwice = defaultRoot + "/fx/blink_twice.mp3";
  static String fxMultimediaAlarm = defaultRoot + "/fx/multimedia_alarm.mp3";
}
