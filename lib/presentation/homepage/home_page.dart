import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_getx/controller/all_songs_controller.dart';
import 'package:music_app_getx/controller/current_playing_song_controller.dart';
import 'package:music_app_getx/controller/mini_player_controller.dart';
import 'package:music_app_getx/controller/playlist_page_controller.dart';
import 'package:music_app_getx/controller/playlist_songs_list_controller.dart';
import 'package:music_app_getx/controller/recent_played_controller.dart';
import 'package:music_app_getx/functions/music_get_func.dart';
import 'package:music_app_getx/presentation/favouritesPage/favourites_page.dart';
import 'package:music_app_getx/presentation/homepage/homepageWidgets/collections_widget.dart';
import 'package:music_app_getx/presentation/miniPlayer/mini_player.dart';
import 'package:music_app_getx/presentation/widgets/menu_icon_home.dart';
import 'package:music_app_getx/presentation/mostPlayedScreen/most_played_page.dart';
import 'package:music_app_getx/presentation/musicPlayerPage/music_player_screen.dart';
import 'package:music_app_getx/presentation/playlsitPage/playlist_page.dart';
import 'package:music_app_getx/presentation/recentPlayed/recent_played.dart';
import 'package:music_app_getx/presentation/search/search_page.dart';
import 'package:music_app_getx/presentation/settings/settings.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final songController = Get.put(AllSongsController());
  final currentPlayinSongController = Get.put(CurrentPlayingSongController());
  final recentControllerGet = Get.put(RecentPlayedController());
  final playlistSongController = Get.put(PlaylistSongsController());
  final playlistController = Get.put(PlayListPageController());
  final musicFucntion = MusicFunctionsClass();
  final miniPlayerClasscontroller = Get.put(MiniPlayerController());
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      backgroundColor: const Color(0xff121526),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.settings_outlined,
            color: Colors.white,
          ),
          onPressed: () => Get.to(
            () => const SettingsPage(),
          ),
        ),
        title: const Text("Zong"),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        toolbarHeight: 50,
        backgroundColor: const Color.fromARGB(255, 38, 32, 63),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const SearchPage());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            //main column
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
//----------------------------Your Collections list----------------------------
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xff121526),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    width: width * 100,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 60,
                          width: width * 100,
                          child: const Center(
                            child: Text(
                              'Collections',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                  onTap: () => Get.to(
                                        () => FavoritesScreen(),
                                      ),
                                  child: collectionsHomePage(
                                      width: width,
                                      color: const Color(0xfffb8943),
                                      title: 'FAVOURITES')),
                              const SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                child: collectionsHomePage(
                                    width: width,
                                    color: const Color(0xff71c4fc),
                                    title: 'PLAYLIST'),
                                onTap: () => Get.to(
                                  () => PlayListPage(),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              InkWell(
                                child: collectionsHomePage(
                                    width: width,
                                    color: const Color(0xfff8ce67),
                                    title: 'RECENT SONGS'),
                                onTap: () => Get.to(
                                  () => RecentPlayedScreen(),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              //------------------------------------------------------------------------
                              InkWell(
                                child: collectionsHomePage(
                                    width: width,
                                    color: const Color.fromARGB(
                                        255, 236, 236, 239),
                                    title: 'MOST PLAYED'),
                                onTap: () => Get.to(
                                  () => MostPlayedPage(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color: Color(0xff121526),
                          ),
//playall----------------------------------
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  child: const Text(
                                    'Play All',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    musicFucntion.playingAudio(0);
                                  },
                                ),
                                TextButton(
                                  child: const Text(
                                    'Shuffle All',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    //  musicFucntion
                                    //       .creatingPlayerListShuffle(songs);
                                    // if (player.playing) {
                                    //   isPlayerOn = true;
                                    //   setState(() {});
                                    // }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GetBuilder<AllSongsController>(
                    builder: (songsController) {
                      // Obx(() {
                      if (songsController.songsList.isEmpty) {
                        return const Center(
                          child: Text(
                            'no audio files found',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      List songs = [];
                      //passing values to concatinating class
                      for (var song in songsController.songsList) {
                        songs.add(song.id);
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: songsController.songsList.length,
                        itemBuilder: (context, index) {
                          // var path = songsController.songsList[index].songuri;
                          var title =
                              songsController.songsList[index].songTitle;
                          var artist =
                              songsController.songsList[index].songArtist;
                          var image = songsController.songsList[index].imageId;
                          var id = songsController.songsList[index].id;

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
                                  await currentPlayinSongController
                                      .currentSongUpdate(id);
                                  await musicFucntion.creatingPlayerList(songs);
                                  await musicFucntion.playingAudio(index);
                                  
                                  Get.to(() => MusicPlayerScreen(
                                        index: id,
                                        songsIds: songs,
                                      ));
                                  miniPlayerClasscontroller
                                      .isMiniPlayerVisible(true);
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
                                      overflow: TextOverflow.ellipsis),
                                ),
                                leading: QueryArtworkWidget(
                                  id: image!,
                                  type: ArtworkType.AUDIO,
                                  nullArtworkWidget: Image.asset(
                                    'assets/0.png',
                                  ),
                                ),
                                trailing: menuIcon(id: id, isPlaylist: false),
                              ),
                            ),
                          );
                          // return Container(
                          //   height: 100,
                          //   width: 100,
                          //   color: Colors.yellow,
                          // );
                        },
                      );
                    },
                  ),
                  // Builder(
                  //   builder: (context) {
                  //     return player.playing == true || isPlayerOn == true
                  //         ? const SizedBox(
                  //             height: 100,
                  //           )
                  //         : const Divider();
                  //   },
                  // )
                ],
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
