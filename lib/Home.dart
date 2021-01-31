import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache(prefix: "audios/");
  bool firstExecution = true;
  double volume = 0.5;

  _execute() async {
    if (firstExecution) {
      audioPlayer.setVolume(volume);
      audioPlayer = await audioCache.play("musica.mp3");
      firstExecution = false;
    } else {
      audioPlayer.resume();
    }

    /*
    String url = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3";
    int result = await audioPlayer.play(url);

    if (result == 1) {
      // success
    }
     */
  }

  _pause() async {
    int result = await audioPlayer.pause();
    if (result == 1) {
      // success
    }
  }

  _stop() async {
    int result = await audioPlayer.stop();
    if (result == 1) {
      // success
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Executing sounds"),
      ),
      body: Column(
        children: [
          Slider(
            value: volume,
            min: 0,
            max: 1,
            divisions: 10,
            onChanged: (newVolume) {
              setState(() {
                volume = newVolume;
              });
              audioPlayer.setVolume(volume);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  child: Image.asset("assets/images/executar.png"),
                  onTap: () {
                    _execute();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  child: Image.asset("assets/images/pausar.png"),
                  onTap: () {
                    _pause();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  child: Image.asset("assets/images/parar.png"),
                  onTap: () {
                    _stop();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
