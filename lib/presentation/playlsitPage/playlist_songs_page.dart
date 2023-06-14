import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_getx/controller/all_songs_controller.dart';
import 'package:music_app_getx/controller/current_playing_song_controller.dart';
import 'package:music_app_getx/controller/playlist_page_controller.dart';
import 'package:music_app_getx/controller/playlist_songs_list_controller.dart';
import 'package:music_app_getx/functions/music_get_func.dart';
import 'package:music_app_getx/models/models.dart';
import 'package:music_app_getx/presentation/musicPlayerPage/music_player_screen.dart';
import 'package:music_app_getx/presentation/widgets/menu_icon_home.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistSongsScreen extends StatelessWidget {
  PlaylistSongsScreen({super.key, required this.playlist});
  final PlayListModel playlist;

  final songsList = Get.find<AllSongsController>();
  final playlistSongs = Get.find<PlayListPageController>();
  final playlistSongController = Get.find<PlaylistSongsController>();
  final musicFucntion = MusicFunctionsClass();
  final currentPlaying = Get.find<CurrentPlayingSongController>();
  @override
  Widget build(BuildContext context) {
    playlistSongController.getPlaylistSongs(playlist.id!);
    return Scaffold(
      backgroundColor: const Color(0xff121526),
      appBar: AppBar(
          title: Text(playlist.playlistName),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          toolbarHeight: 50,
          backgroundColor: const Color.fromARGB(255, 38, 32, 63)),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  GetBuilder<PlaylistSongsController>(
                    builder: (controller) {
                      // controller.getPlaylistSongs(playlist.id!);
                      List collection = controller.songsInPlaylist.toList();
                      if (collection.isEmpty) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: const Center(
                            child: Text(
                              'no audio files found',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }
                      List songs = [];
                      songs.addAll(controller.songsInPlaylist);
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: collection.length,
                        itemBuilder: (context, index) {
                          var title = songsList
                              .songsList[controller.songsInPlaylist[index]]
                              .songTitle;
                          var artist = songsList
                              .songsList[controller.songsInPlaylist[index]]
                              .songArtist;
                          var id = songsList
                              .songsList[controller.songsInPlaylist[index]].id;
                          var image = songsList
                              .songsList[controller.songsInPlaylist[index]]
                              .imageId;
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              //listing songs//------------------------------------------------
                              child: ListTile(
                                  onTap: () async {
                                    await currentPlaying.currentSongUpdate(id);
                                    await await musicFucntion
                                        .creatingPlayerList(collection);
                                    await musicFucntion.playingAudio(index);
                                    Get.to(() => MusicPlayerScreen(
                                          index: index,
                                          songsIds: songs,
                                        ));
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
                                      color: Color.fromARGB(255, 55, 55, 55),
                                    ),
                                  ),
                                  leading: QueryArtworkWidget(
                                    id: image!,
                                    type: ArtworkType.AUDIO,
                                    nullArtworkWidget: Image.asset(
                                      'assets/0.png',
                                    ),
                                  ),
                                  trailing: menuIcon(
                                      id: id,
                                      isPlaylist: true,
                                      playlistId: playlist.id)),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // ElevatedButton(
                    //   onPressed: () {
                    //     // Get.to(() => MusicPlayerScreen(index: index));
                    //   },
                    //   child: const Text('Add Songs'),
                    // ),
                    // MiniPlayerClass(
                    //     currentSongTitles: currentSongTitle ?? '',
                    //     width: width),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
