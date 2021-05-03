import 'package:flutter/material.dart';
import 'package:math_app_for_kid/services/app/audio_provider.dart';
import 'package:math_app_for_kid/services/safety/base_stateless.dart';
import 'package:math_app_for_kid/utils/app_extension.dart';
import 'package:math_app_for_kid/widgets/w_floating_button.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SettingsPage extends BaseStateless {
  @override
  Widget build(BuildContext context) {
    AudioProvider _audioProvider = context.provider<AudioProvider>();

    super.build(context);
    return Scaffold(
        backgroundColor: appTheme.backgroundColor,
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "Cài đặt",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: appTheme.errorColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getTitle("Nhạc nền"),
            Row(
              children: [
                Switch(
                  value: !context.watch<AudioProvider>().muteMusic,
                  onChanged: (value) {
                    _audioProvider.mute(AudioType.music, !value);
                  },
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                ),
                Slider(
                  max: 0.4,
                  value: context.watch<AudioProvider>().musicVolume,
                  onChanged: context.watch<AudioProvider>().muteMusic
                      ? null
                      : (volume) {
                          _audioProvider.setVolume(AudioType.music, volume);
                        },
                  divisions: 4,
                )
              ],
            ),
            _getTitle("Giọng nói nhân vật"),
            Row(
              children: [
                Switch(
                  value: !context.watch<AudioProvider>().muteVoice,
                  onChanged: (value) {
                    _audioProvider.mute(AudioType.voice, !value);
                  },
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                ),
                Slider(
                  value: context.watch<AudioProvider>().voiceVolume,
                  onChanged: context.watch<AudioProvider>().muteVoice
                      ? null
                      : (volume) {
                          _audioProvider.setVolume(AudioType.voice, volume);
                        },
                  divisions: 4,
                )
              ],
            ),
            _getTitle("Âm thanh hiệu ứng"),
            Row(
              children: [
                Switch(
                  value: !context.watch<AudioProvider>().muteFx,
                  onChanged: (value) {
                    _audioProvider.mute(AudioType.fx, !value);
                  },
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                ),
                Slider(
                  value: context.watch<AudioProvider>().fxVolume,
                  onChanged: context.watch<AudioProvider>().muteFx
                      ? null
                      : (volume) {
                          _audioProvider.setVolume(AudioType.fx, volume);
                        },
                  divisions: 4,
                )
              ],
            ),
          ],
        ),
        floatingActionButton: WFloatingButton());
  }

  Widget _getTitle(String text) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 21.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
