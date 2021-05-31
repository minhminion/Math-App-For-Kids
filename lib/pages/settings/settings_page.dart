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
          leading: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () => Navigator.of(context).pop(),
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
        body: Container(
          height: double.infinity,
          width: double.infinity,
          // color: Colors.blueAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildAudioSetting(
                title: "Nhạc nền",
                audioProvider: _audioProvider,
                sliderValue: context.watch<AudioProvider>().musicVolume,
                maxSliderValue: 0.4,
                isMute: context.watch<AudioProvider>().muteMusic,
                audioType: AudioType.music,
              ),
              _buildAudioSetting(
                title: "Giọng nói nhân vật",
                audioProvider: _audioProvider,
                sliderValue: context.watch<AudioProvider>().voiceVolume,
                isMute: context.watch<AudioProvider>().muteVoice,
                audioType: AudioType.voice,
              ),
              _buildAudioSetting(
                title: "Âm thanh hiệu ứng",
                audioProvider: _audioProvider,
                sliderValue: context.watch<AudioProvider>().fxVolume,
                isMute: context.watch<AudioProvider>().muteFx,
                audioType: AudioType.fx,
              ),
            ],
          ),
        ));
  }

  Widget _buildAudioSetting(
      {String title = "Tiêu đề",
      @required AudioType audioType,
      @required AudioProvider audioProvider,
      @required bool isMute,
      @required double sliderValue,
      double maxSliderValue = 1.0}) {
    return Row(
      children: [
        _getTitle(title),
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 16,
            activeTrackColor: appTheme.getCardColor(4),
            inactiveTrackColor: appTheme.cardBackgroundColor,
            thumbColor: Colors.white,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
            overlayColor: Colors.white.withAlpha(32),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
          ),
          child: Slider(
            max: maxSliderValue,
            min: 0,
            value: sliderValue,
            onChanged: isMute
                ? null
                : (volume) {
                    audioProvider.setVolume(audioType, volume);
                  },
            // divisions: 4,
          ),
        ),
        Switch(
          value: !isMute,
          onChanged: (value) {
            audioProvider.mute(audioType, !value);
          },
          activeTrackColor: Colors.lightGreenAccent,
          activeColor: Colors.green,
        ),
      ],
    );
  }

  Widget _getTitle(String text) {
    return Container(
      width: 240,
      padding: EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.right,
        style: TextStyle(
          color: Colors.white,
          fontSize: 21.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
