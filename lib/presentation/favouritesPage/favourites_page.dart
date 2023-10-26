import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_getx/constands/constand.dart';
import 'package:music_app_getx/controller/all_songs_controller.dart';
import 'package:music_app_getx/controller/current_playing_song_controller.dart';
import 'package:music_app_getx/functions/music_get_func.dart';
import 'package:music_app_getx/models/models.dart';
import 'package:music_app_getx/presentation/miniPlayer/mini_player.dart';
import 'package:music_app_getx/presentation/musicPlayerPage/music_player_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../widgets/custom_appbar.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key});

  final songController = Get.find<AllSongsController>();
  final musicFucntion = MusicFunctionsClass();
  final currentSong = Get.find<CurrentPlayingSongController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121526),
      appBar: const CustomAppbar(title: "Favorites"),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: GetBuilder<AllSongsController>(
                builder: (songController) {
                  List<SongsListModel> favouriteSongs = songController.songsList
                      .where((element) => element.isfav == true)
                      .toList();
                  // print(controller.favouriteSongs.first.songTitle);
                  if (favouriteSongs.isEmpty) {
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
                  List song = [];

                  for (var element in favouriteSongs) {
                    song.add(element.id);
                  }
                  musicFucntion.creatingPlayerList(favouriteSongs);

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: favouriteSongs.length,
                    itemBuilder: (context, index) {
                      SongsListModel song = favouriteSongs[index];
                      int id = favouriteSongs[index].id!;
                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 8),
                        child: ColoredBox(
                          color: Colors.white,
                          //listing songs//
                          child: ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            onTap: () async {
                              Get.to(() => MusicPlayerScreen(
                                    index: id,
                                    songs: favouriteSongs,
                                  ));
                              await currentSong.currentSongUpdate(id);
                              await musicFucntion.creatingPlayerList(favouriteSongs);
                              await musicFucntion.playingAudio(index);
                            },
                            title: Text(
                              song.songTitle,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 37, 36, 36),
                                  overflow: TextOverflow.ellipsis),
                            ),
                            subtitle: Text(
                              song.songArtist??"unknown",
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 55, 55, 55),
                                  overflow: TextOverflow.ellipsis),
                            ),
                            leading: QueryArtworkWidget(
                              id: song.imageId!,
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget: Image.asset(
                                'assets/0.png',
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.highlight_remove_sharp,
                                  size: 30),
                              color: Colors.red,
                              tooltip: 'remove',
                              onPressed: () {
                                songController.updateFavourites(id);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: MiniPlayerClass(),
            ),
          ],
        ),
      ),
    );
  }
}
