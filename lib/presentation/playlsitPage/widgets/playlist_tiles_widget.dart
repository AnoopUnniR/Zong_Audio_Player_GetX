import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_getx/controller/playlist_page_controller.dart';
import 'package:music_app_getx/controller/playlist_songs_list_controller.dart';
import 'package:music_app_getx/presentation/playlsitPage/playlist_songs_page.dart';
import 'package:music_app_getx/presentation/playlsitPage/widgets/edit_playlist_name.dart';
import 'package:text_scroll/text_scroll.dart';

class PlaylistTilesWidget extends StatelessWidget {
  const PlaylistTilesWidget({
    super.key,
    required this.controller,
    required this.index,
  });

  final PlayListPageController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    final playlistSongController = Get.find<PlaylistSongsController>();

    return InkWell(
        child: Card(
          color: const Color(0xff8177ea),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            editingPlaylist(controller.playListTitle[index]);
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                        icon: const Icon(Icons.delete_forever),
                        onPressed: () {
                          Get.dialog(
                            AlertDialog(
                              title: Text(
                                  'Do you want to delete the playlist ${controller.playListTitle[index].playlistName}?'),
                              actions: [
                                ElevatedButton(
                                  onPressed: () async {
                                    await controller.deletePlaylist(
                                        controller.playListTitle[index].id!);
                                    if (context.mounted) Navigator.pop(context);
                                  },
                                  child: const Text('Delete'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel"),
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
                    controller.playListTitle[index].playlistName,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () async {
          await playlistSongController
              .getPlaylistSongs(controller.playListTitle[index].id!);
          Get.to(
            () => PlaylistSongsScreen(
              playlist: controller.playListTitle[index],
            ),
          );
        });
  }
}
