import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app_getx/constands/constand.dart';

class PlayerButtonWidget extends StatelessWidget {
  const PlayerButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
      stream: player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final playing = playerState?.playing;
        if (playing != true) {
          return Padding(
            padding: const EdgeInsets.all(0),
            child: IconButton(
              icon: const Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
              iconSize: 60.0,
              onPressed: player.play,
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(0),
            child: IconButton(
              icon: const Icon(Icons.pause, color: Colors.white),
              iconSize: 60.0,
              onPressed: player.pause,
            ),
          );
        }
      },
    );
  }
}
