import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

enum AudioType { music, voice, fx }

class AudioProvider extends ChangeNotifier {
  AudioProvider() {
    init();
  }

  bool muteMusic = false;
  bool muteVoice = false;
  bool muteFx = false;

  AudioPlayer _musicAudioPlayer;
  AudioCache _musicAudioCache;
  double musicVolume = 0.4;

  AudioPlayer _voiceAudioPlayer;
  AudioCache _voiceAudioCache;
  double voiceVolume = 1;

  AudioPlayer _fxAudioPlayer;
  AudioCache _fxAudioCache;
  double fxVolume = 1;

  init() {
    _musicAudioPlayer = AudioPlayer();
    _musicAudioCache = AudioCache(fixedPlayer: _musicAudioPlayer);

    _voiceAudioPlayer = AudioPlayer();
    _voiceAudioCache = AudioCache(fixedPlayer: _voiceAudioPlayer);

    _fxAudioPlayer = AudioPlayer();
    _fxAudioCache = AudioCache(fixedPlayer: _fxAudioPlayer);
  }

  playAudio(AudioType audioType, String audioUrl) async {
    switch (audioType) {
      case AudioType.music:
        if (!muteMusic && musicVolume != 0) {
          await _musicAudioCache.loop(audioUrl);
          await _musicAudioPlayer.setVolume(musicVolume);
        }
        break;
      case AudioType.voice:
        if (!muteVoice && voiceVolume != 0) {
          await _voiceAudioCache.play(audioUrl);
          await _voiceAudioPlayer.setVolume(voiceVolume);
        }
        break;
      case AudioType.fx:
        if (!muteFx && fxVolume != 0) {
          await _fxAudioCache.play(audioUrl);
          await _fxAudioPlayer.setVolume(fxVolume);
        }
        break;
    }
  }

  mute(AudioType audioType, bool isMute) async {
    AudioPlayerState state;
    switch (audioType) {
      case AudioType.music:
        muteMusic = isMute;
        state = _musicAudioCache.fixedPlayer.state;
        isMute ? _musicAudioPlayer.stop() : _musicAudioPlayer.resume();

        break;
      case AudioType.voice:
        muteVoice = isMute;
        state = _voiceAudioCache.fixedPlayer.state;
        if (state != AudioPlayerState.STOPPED) {
          isMute ? _voiceAudioPlayer.stop() : _voiceAudioPlayer.resume();
        }
        break;
      case AudioType.fx:
        muteFx = isMute;
        state = _fxAudioCache.fixedPlayer.state;
        if (state != AudioPlayerState.STOPPED) {
          isMute ? _fxAudioPlayer.stop() : _fxAudioPlayer.resume();
        }
        break;
    }

    notifyListeners();
  }

  setVolume(AudioType audioType, double volume) {
    switch (audioType) {
      case AudioType.music:
        musicVolume = volume;
        _musicAudioPlayer.setVolume(volume);
        break;
      case AudioType.voice:
        voiceVolume = volume;
        _voiceAudioPlayer.setVolume(volume);
        break;
      case AudioType.fx:
        fxVolume = volume;
        _fxAudioPlayer.setVolume(volume);
        break;
      // case AudioType.voice:
      //   muteVoice = isMute;
      //   isMute ? _voiceAudioPlayer.stop() : _voiceAudioPlayer.resume();
      //   break;
      // case AudioType.fx:
      //   muteFx = isMute;
      //   isMute ? _fxAudioPlayer.stop() : _fxAudioPlayer.resume();
      //   break;
      default:
        break;
    }

    notifyListeners();
  }

  pauseAll() {
    _musicAudioCache.fixedPlayer.pause();
    // _voiceAudioCache.fixedPlayer.pause();
    // _fxAudioCache.fixedPlayer.pause();
  }

  resumeAll() {
    _musicAudioCache.fixedPlayer.resume();
    // _voiceAudioCache.fixedPlayer.resume();
    // _fxAudioCache.fixedPlayer.resume();
  }
}
