import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_getx/constands/constand.dart';
import 'package:music_app_getx/controller/playlist_page_controller.dart';
import 'package:music_app_getx/controller/playlist_songs_list_controller.dart';
import 'package:music_app_getx/presentation/playlsitPage/playlist_page.dart';

playlistDialogue(int id) {
  final playlistController = Get.find<PlayListPageController>();
  final playlistSongController = Get.find<PlaylistSongsController>();
  return Get.dialog(
    Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color(0xff121526)),
          height: 400,
          width: 400,
          child: GetBuilder<PlayListPageController>(
            builder: (controller) {
              if (controller.playListTitle.isEmpty) {
                return SizedBox(
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     const Material(
                        color: Colors.transparent,
                        child:  Text(
                          "No Playlist Created",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 119, 109, 234),
                          ),
                          onPressed: () {
                            Get.back();
                            Get.to(() => PlayListPage());
                          },
                          child: const Text(
                            'Go to Playlist Page',
                            style: whiteText,
                          ))
                    ],
                  ),
                );
              }
              
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Column(
                        children: [
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: playlistController.playListTitle.length,
                            itemBuilder: (context, index) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 119, 109, 234),
                                ),
                                child: Text(
                                  playlistController
                                      .playListTitle[index].playlistName,
                                ),
                                onPressed: () {
                                  playlistSongController.addToPlaylist(
                                      id,
                                      playlistController
                                          .playListTitle[index].id!);
                                },
                              );
                            },
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text('Cancel'),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    ),
  );
}
