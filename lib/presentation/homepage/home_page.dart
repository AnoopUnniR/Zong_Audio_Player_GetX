import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_getx/controller/all_songs_controller.dart';
import 'package:music_app_getx/controller/mini_player_controller.dart';
import 'package:music_app_getx/controller/playlist_page_controller.dart';
import 'package:music_app_getx/controller/playlist_songs_list_controller.dart';
import 'package:music_app_getx/controller/recent_played_controller.dart';
import 'package:music_app_getx/functions/music_get_func.dart';
import 'package:music_app_getx/presentation/miniPlayer/mini_player.dart';

import 'homepageWidgets/collection_widgets.dart';
import 'homepageWidgets/custom_appbar_home_screen.dart';
import 'homepageWidgets/music_t_iles_home.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final songController = Get.put(AllSongsController());
  final recentControllerGet = Get.put(RecentPlayedController());
  final playlistSongController = Get.put(PlaylistSongsController());
  final playlistController = Get.put(PlayListPageController());
  final musicFucntion = MusicFunctionsClass();
  final miniPlayerClasscontroller = Get.put(MiniPlayerController());
  final musicGet = MusicFunctionsClass();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      backgroundColor: const Color(0xff121526),
      appBar: const CustomAppbarHomeScreen(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await musicGet.songList();
            songController.getAllSongs();
          },
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
                          const SizedBox(height: 10),
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
                          const SizedBox(height: 10),
                          CollectionWidgets(width: width),
                          const SizedBox(height: 30),
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
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: songsController.songsList.length,
                          itemBuilder: (context, index) {
                            return MusicTIlesHome(
                              miniPlayerClasscontroller:
                                  miniPlayerClasscontroller,
                              musicFucntion: musicFucntion,
                              index: index,
                              songs: songController.songsList,
                            );
                          },
                        );
                      },
                    ),
                    Obx(
                      () {
                        if (miniPlayerClasscontroller
                                .isMiniPlayerVisible.value ==
                            false) {
                          return const SizedBox();
                        }
                        return const SizedBox(
                          height: 100,
                        );
                      },
                    )
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
      ),
    );
  }
}
