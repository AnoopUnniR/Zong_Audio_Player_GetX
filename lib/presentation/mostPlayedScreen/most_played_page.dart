import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_getx/controller/all_songs_controller.dart';
import 'package:music_app_getx/controller/most_played_songs.dart';
import 'package:music_app_getx/functions/music_get_func.dart';
import 'package:music_app_getx/presentation/musicPlayerPage/music_player_screen.dart';
import 'package:music_app_getx/presentation/widgets/menu_icon_home.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MostPlayedPage extends StatelessWidget {
  MostPlayedPage({super.key});
  final allSongs = Get.find<AllSongsController>();
  final musicFucntion = MusicFunctionsClass();
  // final mostPlayedController = Get.find<MostPlayedController>();
  // final mostPlayedController = Get.put(MostPlayedController());
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xff121526),
      appBar: AppBar(
          title: const Text("Most Played"),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          toolbarHeight: 50,
          backgroundColor: const Color.fromARGB(255, 38, 32, 63)),
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
                        List songs = [];

                        // mostPlayedDetails.clear();
                        songs.addAll(mostPlayedController.mostPlayed);
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 30,
                                  mainAxisSpacing: 30),
                          itemBuilder: (context, index) {
                            int songIndex =
                                mostPlayedController.mostPlayed[index];
                            // var path = allSongs.songsList[songIndex].songuri;
                            var title = allSongs.songsList[songIndex].songTitle;
                            // var artist =
                            allSongs.songsList[songIndex].songArtist!;
                            // var image = allSongs.songsList[songIndex].imageId;
                            var id = allSongs.songsList[songIndex].id;
                            return InkWell(
                              child: Card(
                                color: Colors.white,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(allSongs
                                          .songsList[songIndex].mostplayedCount
                                          .toString()),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child:
                                          menuIcon(id: id, isPlaylist: false),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: QueryArtworkWidget(
                                        artworkHeight: 100,
                                        artworkWidth: 100,
                                        id: id,
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
                                await musicFucntion.creatingPlayerList(
                                    mostPlayedController.mostPlayed);
                                await musicFucntion.playingAudio(index);
                                Get.to(() => MusicPlayerScreen(index: index,songsIds: songs,));
                                // musicFunction.update(mostPlayedList,index);
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
