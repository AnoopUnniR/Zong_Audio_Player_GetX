import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_getx/controller/playlist_page_controller.dart';
import 'package:music_app_getx/presentation/playlsitPage/playlist_songs_page.dart';
import 'package:music_app_getx/presentation/playlsitPage/widgets/add_playlist_dialogue_box.dart';
import 'package:music_app_getx/presentation/playlsitPage/widgets/edit_playlist_name.dart';
import 'package:text_scroll/text_scroll.dart';

class PlayListPage extends StatelessWidget {
  PlayListPage({super.key});

  final _playlistController = Get.put(PlayListPageController());

  final playlistNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      backgroundColor: const Color(0xff121526),
      appBar: AppBar(
          title: const Text("PLAYLISTS"),
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
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //create new playlist button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 119, 109, 234)),
                  onPressed: () {
                    addPlaylistDialog(_playlistController);
                  },
                  child: const Text('create new'),
                ),
                Expanded(
                  child: GetBuilder<PlayListPageController>(
                    builder: (controller) {
                      if (controller.playListTitle.isEmpty) {
                        return const Center(
                          child: Text(
                            'No Playlists created.',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: controller.playListTitle.length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: width * 40,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16),
                          itemBuilder: (context, index) {
                            // int id =controller.playListTitle.;
                            return InkWell(
                                child: Card(
                                  color: const Color(0xff8177ea),
                                  child: Stack(
                                    children: [
                                      Align(
                                          alignment: Alignment.topCenter,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    editingPlaylist(controller
                                                        .playListTitle[index]);
                                                  },
                                                  icon: const Icon(Icons.edit)),
                                              IconButton(
                                                icon: const Icon(
                                                    Icons.delete_forever),
                                                onPressed: () {
                                                  Get.dialog(
                                                    AlertDialog(
                                                      title: Text(
                                                          'Do you want to delete the playlist ${controller.playListTitle[index].playlistName}?'),
                                                      actions: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            controller.deletePlaylist(
                                                                controller
                                                                    .playListTitle[
                                                                        index]
                                                                    .id);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              'Delete'),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              "Cancel"),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          )),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: TextScroll(
                                            controller.playListTitle[index]
                                                .playlistName,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () => Get.to(() => PlaylistSongsScreen(
                                      playlist: controller.playListTitle[index],
                                    ),
                                  )
                                );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            // Align(
            //   alignment: AlignmentDirectional.bottomEnd,
            //   child: MiniPlayerClass(
            //       currentSongTitles: currentSongTitle ?? '', width: width),
            // ),
          ],
        ),
      ),
    );
  }
}
