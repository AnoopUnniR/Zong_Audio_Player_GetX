import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_getx/constands/constand.dart';
import 'package:music_app_getx/controller/all_songs_controller.dart';
import 'package:music_app_getx/controller/current_playing_song_controller.dart';
import 'package:music_app_getx/functions/music_get_func.dart';
import 'package:music_app_getx/presentation/miniPlayer/mini_player.dart';
import 'package:music_app_getx/presentation/musicPlayerPage/music_player_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key});

  final songController = Get.find<AllSongsController>();
  final musicFucntion = MusicFunctionsClass();
  final currentSong = Get.find<CurrentPlayingSongController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121526),
      appBar: AppBar(
        title: const Text("Favourites"),
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
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: GetBuilder<AllSongsController>(
                builder: (songController) {
                  List favouriteSongs = songController.songsList
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
                  musicFucntion.creatingPlayerList(song);

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: favouriteSongs.length,
                    itemBuilder: (context, index) {
                      // var path = favouriteSongs[index].songuri;
                      var title = favouriteSongs[index].songTitle;
                      var artist = favouriteSongs[index].songArtist!;
                      var image = favouriteSongs[index].imageId;
                      var id = favouriteSongs[index].id;
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
                              Get.to(() => MusicPlayerScreen(index: id,songsIds: song,));
                              await currentSong.currentSongUpdate(id);
                              await musicFucntion.creatingPlayerList(song);
                              await musicFucntion.playingAudio(index);

                            },
                            title: Text(
                              title,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 37, 36, 36),
                                  overflow: TextOverflow.ellipsis),
                            ),
                            subtitle: Text(
                              artist,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 55, 55, 55),
                                  overflow: TextOverflow.ellipsis),
                            ),
                            leading: QueryArtworkWidget(
                              id: image!,
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
                                // favouritesController.deleteFavourites(id!);
                                // deleteFavourite(id!, context, title);
                                // favouritesDetails.removeAt(index);
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
