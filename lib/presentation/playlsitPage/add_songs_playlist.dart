import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_getx/controller/all_songs_controller.dart';
import 'package:music_app_getx/controller/current_playing_song_controller.dart';
import 'package:music_app_getx/controller/mini_player_controller.dart';
import 'package:music_app_getx/controller/playlist_songs_list_controller.dart';
import 'package:music_app_getx/functions/music_get_func.dart';
import 'package:music_app_getx/presentation/miniPlayer/mini_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AddSongsPlaylistScreen extends StatelessWidget {
  const AddSongsPlaylistScreen({super.key, required this.playlistId});
  final int playlistId;

  @override
  Widget build(BuildContext context) {
    //  final playlistSongsController = PlaylistSongsController();
    // final HomePageController homePageController = Get.find();
    final musicFunctions = MusicFunctionsClass();
    final miniplayerController = Get.find<MiniPlayerController>();
    final currentplayer = Get.find<CurrentPlayingSongController>();
    // final playlistSongs = PlaylsitListPageState();
    final allSongsController = Get.find<AllSongsController>();
    final playlistController = Get.find<PlaylistSongsController>();
    List songs = [];
    List songDetails = [];
    return Scaffold(
      backgroundColor: const Color(0xff121526),
      appBar: AppBar(
        title: const Text("Add Songs"),
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
            GetBuilder<AllSongsController>(
              builder: (controller) {
                if (allSongsController.songsList.isEmpty) {
                  return const Center(
                    child: Text(
                      'no audio files found',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                for (var song in allSongsController.songsList) {
                  songs.add(song.songuri);
                  songDetails.add(song);
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: allSongsController.songsList.length,
                  itemBuilder: (context, index) {
                    var title = allSongsController.songsList[index].songTitle;
                    var artist =
                        allSongsController.songsList[index].songArtist!;
                    var image = allSongsController.songsList[index].imageId;
                    var id = allSongsController.songsList[index].id;
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        top: 8,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        //listing songs//------------------------------------------------
                        child: ListTile(
                          onTap: () async {
                            currentplayer.currentSongUpdate(id);
                            musicFunctions.creatingPlayerList(songs);
                            musicFunctions.playingAudio(index);
                            miniplayerController.isMiniPlayerVisible.value =
                                true;
                          },
                          title: Text(
                            title,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 37, 36, 36),
                            ),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            artist,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 37, 36, 36)),
                          ),
                          leading: QueryArtworkWidget(
                            id: image!,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: Image.asset(
                              'assets/0.png',
                            ),
                          ),
                          trailing: GetBuilder<PlaylistSongsController>(
                            builder: (controller) => !playlistController
                                    .songsInPlaylist
                                    .contains(id)
                                ? IconButton(
                                    icon: const Icon(Icons.add_circle_outline,
                                        size: 30),
                                    color: Colors.black,
                                    tooltip: 'add to playlist',
                                    onPressed: () {
                                      playlistController.addToPlaylist(
                                          id, playlistId);
                                    },
                                  )
                                : IconButton(
                                    icon: const Icon(
                                        Icons.remove_circle_outline_outlined,
                                        size: 30),
                                    color: Colors.red,
                                    tooltip: 'remove from playlist',
                                    onPressed: () {
                                      playlistController.removeFromPlaylist(
                                          id, playlistId);
                                    },
                                  ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            const Align(
                alignment: Alignment.bottomRight, child: MiniPlayerClass())
          ],
        ),
      ),
    );
  }
}
