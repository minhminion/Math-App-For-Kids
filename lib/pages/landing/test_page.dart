import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MyTestPage extends StatefulWidget {
  @override
  _MyTestPageState createState() => _MyTestPageState();
}

class _MyTestPageState extends State<MyTestPage> {
  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  @override
  void initState() {
    super.initState();
    initAudio();
  }

  initAudio() {
    advancedPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: advancedPlayer);
  }

  playAudio() {
    advancedPlayer.stop();
    audioCache.play('base/audios/hello_audio.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: Text('Text page'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                playAudio();
              },
              child: Text('Play audio'),
            ),
            TextButton(
              onPressed: () => advancedPlayer.pause(),
              child: Text('Pause audio'),
            ),
            TextButton(
              onPressed: () => advancedPlayer.stop(),
              child: Text('Stop audio'),
            ),
          ],
        ),
      ),
    );
  }
}
