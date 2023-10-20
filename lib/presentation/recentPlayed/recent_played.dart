import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_getx/constands/constand.dart';
import 'package:music_app_getx/controller/all_songs_controller.dart';
import 'package:music_app_getx/controller/current_playing_song_controller.dart';
import 'package:music_app_getx/controller/recent_played_controller.dart';
import 'package:music_app_getx/functions/music_get_func.dart';
import 'package:music_app_getx/presentation/musicPlayerPage/music_player_screen.dart';
import 'package:music_app_getx/presentation/widgets/menu_icon_home.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentPlayedScreen extends StatelessWidget {
  RecentPlayedScreen({super.key});
  final allSongsController = Get.find<AllSongsController>();
  final recentSongsController = Get.find<RecentPlayedController>();
  final musicFunction = MusicFunctionsClass();
  final currentplayingController = Get.find<CurrentPlayingSongController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121526),
      appBar: AppBar(
        title: const Text("Recently Played"),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        toolbarHeight: 50,
        backgroundColor: const Color.fromARGB(255, 38, 32, 63),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    GetBuilder<RecentPlayedController>(
                      builder: (recentController) {
                        if (recentController.recentPlayed.isEmpty) {
                          // print('emoty');
                          return SizedBox(
                            height: displayHeight,
                            child: const Center(
                              child: Text(
                                'nothing to show',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }
                        List songsInRecent = [
                          ...recentController.recentPlayed.reversed
                        ];
                        // songsInRecent.addAll(recentController.recentPlayed);
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 30,
                                  mainAxisSpacing: 30),
                          itemBuilder: (context, index) {
                            // var path = allSongsController.songsList[songsInRecent[index].recentPlayedSongId].songuri;
                            var title = allSongsController
                                .songsList[songsInRecent[index]].songTitle;
                            // var artist = allSongsController.songsList[songsInRecent[index].recentPlayedSongId].songArtist!;
                            var image = allSongsController
                                .songsList[songsInRecent[index]].imageId;
                            var id = allSongsController.songsList[songsInRecent[index]].id;
                            return InkWell(
                              child: Card(
                                color: Colors.white,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: menuIcon(
                                          id: id, isPlaylist: false),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: QueryArtworkWidget(
                                        artworkHeight: 100,
                                        artworkWidth: 100,
                                        id: image,
                                        type: ArtworkType.AUDIO,
                                        nullArtworkWidget: Image.asset(
                                          height: 100,
                                          width: 60,
                                          'assets/icon.png',
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () async {
                                await currentplayingController
                                    .currentSongUpdate(songsInRecent[index]);
                                await musicFunction
                                    .creatingPlayerList(songsInRecent);
                                musicFunction.playingAudio(index);
                                Get.to(() => MusicPlayerScreen(
                                      index: index,
                                      songsIds: songsInRecent,
                                    ));
                              },
                            );
                          },
                          itemCount: recentController.recentPlayed.length,
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
