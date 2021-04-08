import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class AppAudio {
  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  AppAudio._();
  static final AppAudio appAudio = AppAudio._();

  initAudio() {
    advancedPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: advancedPlayer);
  }

  playAudio(String audioUrl) {
    advancedPlayer.stop();
    audioCache.play(audioUrl);
  }
}
