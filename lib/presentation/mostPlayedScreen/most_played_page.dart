import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_getx/controller/all_songs_controller.dart';
import 'package:music_app_getx/controller/current_playing_song_controller.dart';
import 'package:music_app_getx/controller/most_played_songs.dart';
import 'package:music_app_getx/functions/music_get_func.dart';
import 'package:music_app_getx/models/models.dart';
import 'package:music_app_getx/presentation/musicPlayerPage/music_player_screen.dart';
import 'package:music_app_getx/presentation/widgets/custom_appbar.dart';
import 'package:music_app_getx/presentation/widgets/menu_icon_home.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MostPlayedPage extends StatelessWidget {
  MostPlayedPage({super.key});
  final allSongsController = Get.find<AllSongsController>();
  final musicFucntion = MusicFunctionsClass();
  final currentplayingController = Get.find<CurrentPlayingSongController>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xff121526),
      appBar: const CustomAppbar(title: "Most Played"),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    GetBuilder<MostPlayedController>(
                      builder: (mostPlayedController) {
                        if (mostPlayedController.mostPlayed.isEmpty) {
                          return SizedBox(
                            height: height,
                            child: const Center(
                              child: Text(
                                'nothing to show',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }
                        List<SongsListModel> mostPlayedSongs = [];
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 30,
                                  mainAxisSpacing: 30),
                          itemBuilder: (context, index) {
                            int songIndex = allSongsController.songsList
                                .indexWhere((element) =>
                                    element.id ==
                                    mostPlayedController.mostPlayed[index]);
                            mostPlayedSongs
                                .add(allSongsController.songsList[songIndex]);
                            SongsListModel song = mostPlayedSongs[index];
                            int id = song.id!;
                            return InkWell(
                              child: Card(
                                color: Colors.white,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child:
                                          menuIcon(id: id, isPlaylist: false),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: SizedBox(
                                        height: 80,
                                        width: 80,
                                        child: QueryArtworkWidget(
                                          artworkHeight: 100,
                                          artworkWidth: 100,
                                          id: song.imageId!,
                                          type: ArtworkType.AUDIO,
                                          nullArtworkWidget: Image.asset(
                                            height: 100,
                                            width: 60,
                                            'assets/icon.png',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(song.songTitle,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () async {
                                currentplayingController.currentSongUpdate(id);
                                Get.to(() => MusicPlayerScreen(
                                      index: index,
                                      songs: mostPlayedSongs,
                                    ));
                                await musicFucntion
                                    .creatingPlayerList(mostPlayedSongs);
                                await musicFucntion.playingAudio(index);
                              },
                            );
                          },
                          itemCount: mostPlayedController.mostPlayed.length,
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
