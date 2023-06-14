import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app_getx/constands/constand.dart';
import 'package:music_app_getx/controller/current_playing_song_controller.dart';
import 'package:music_app_getx/controller/mini_player_controller.dart';
import 'package:music_app_getx/presentation/musicPlayerPage/music_player_screen.dart';
import 'package:text_scroll/text_scroll.dart';

class MiniPlayerClass extends StatefulWidget {
  const MiniPlayerClass({
    super.key,
  });

  @override
  State<MiniPlayerClass> createState() => _MiniPlayerClassState();
}

class _MiniPlayerClassState extends State<MiniPlayerClass> {
  var miniPlayerController = Get.put(MiniPlayerController());
  @override
  Widget build(BuildContext context) {
    // if (player.playing == true || isPlayerOn == true) {
    //   if (isPlayerOn == true) {
    //   } else {
    //     visible = false;
    //   }
    // } else {
    //   visible = false;
    // }
    return Obx(() {
      // if (player.playing == true || isPlayerOn == true) {
      //   if (isPlayerOn == true) {
      //     controller.miniPlayerVisible(true);
      //   } else {
      //    controller.miniPlayerVisible(false);

      //   }
      // } else {
      //                 controller.miniPlayerVisible(false);

      // }
      if (miniPlayerController.isMiniPlayerVisible.value == false) {
        return const SizedBox();
      }
      return Visibility(
        visible: miniPlayerController.isMiniPlayerVisible.value,
        child: Padding(
          padding: const EdgeInsets.only(left: 13.0, right: 13, bottom: 8),
          child: SizedBox(
            width: displayWight * 100,
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
                          songsIds: controller.songList.songsList),
                    ),
                    child: Container(
                      height: 70,
                      width: displayWight * 100,
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
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                            ),
                            child: SizedBox(
                              width: displayWight * 45,
                              child: TextScroll(
                                controller.currentPlayingSong!.songTitle,
                                style: const TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 213, 207, 207)),
                                delayBefore: const Duration(seconds: 3),
                                pauseBetween: const Duration(seconds: 2),
                              ),
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
