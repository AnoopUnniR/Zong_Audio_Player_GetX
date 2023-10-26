import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app_getx/constands/constand.dart';
import 'package:music_app_getx/controller/current_playing_song_controller.dart';
import 'package:music_app_getx/controller/mini_player_controller.dart';
import 'package:music_app_getx/presentation/musicPlayerPage/music_player_screen.dart';
import 'package:text_scroll/text_scroll.dart';

class MiniPlayerClass extends StatelessWidget {
  const MiniPlayerClass({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final miniPlayerController = Get.put(MiniPlayerController());

    return Obx(() {
      if (miniPlayerController.isMiniPlayerVisible.value == false) {
        return const SizedBox();
      }
      return Visibility(
        visible: miniPlayerController.isMiniPlayerVisible.value,
        child: Padding(
          padding: const EdgeInsets.only(left: 13.0, right: 13, bottom: 8),
          child: SizedBox(
            width: displayWidth * 100,
            child:
                GetBuilder<CurrentPlayingSongController>(builder: (controller) {
              return Stack(
                children: [
                  InkWell(
                    onLongPress: () {
                      miniPlayerController.miniPlayerVisible(false);
                    },
                    onTap: () => Get.to(
                      () => MusicPlayerScreen(
                          index: controller.currentPlayingSong!.id!,
                          songs: controller.songList.songsList),
                    ),
                    child: Container(
                      height: 70,
                      width: displayWidth * 100,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Color(0xff121526),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextScroll(
                              controller.currentPlayingSong!.songTitle,
                              style: const TextStyle(
                                  fontSize: 17,
                                  color: Color.fromARGB(255, 213, 207, 207)),
                              delayBefore: const Duration(seconds: 3),
                              pauseBetween: const Duration(seconds: 2),
                            ),
                          ),
                          SizedBox(
                            height: 300,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.skip_previous_outlined,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    player.seekToPrevious();
                                    controller.currentSongUpdate(1);
                                  },
                                ),
                                StreamBuilder<PlayerState>(
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
                                          iconSize: 40.0,
                                          onPressed: player.play,
                                        ),
                                      );
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: IconButton(
                                          icon: const Icon(Icons.pause,
                                              color: Colors.white),
                                          iconSize: 40.0,
                                          onPressed: player.pause,
                                        ),
                                      );
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.skip_next_outlined,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    player.seekToNext();
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      );
    });
  }
}
