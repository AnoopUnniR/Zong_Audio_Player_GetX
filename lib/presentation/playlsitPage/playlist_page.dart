import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_getx/constands/constand.dart';
import 'package:music_app_getx/controller/playlist_page_controller.dart';
import 'package:music_app_getx/controller/playlist_songs_list_controller.dart';
import 'package:music_app_getx/presentation/playlsitPage/playlist_songs_page.dart';
import 'package:music_app_getx/presentation/playlsitPage/widgets/add_playlist_dialogue_box.dart';
import 'package:music_app_getx/presentation/playlsitPage/widgets/edit_playlist_name.dart';
import 'package:music_app_getx/presentation/widgets/custom_appbar.dart';
import 'package:text_scroll/text_scroll.dart';

import 'widgets/playlist_tiles_widget.dart';

class PlayListPage extends StatelessWidget {
  PlayListPage({super.key});

  final _playlistController = Get.put(PlayListPageController());
  final playlistNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      backgroundColor: const Color(0xff121526),
      appBar: const CustomAppbar(title: "Playlist"),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //create new playlist button
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
                            return PlaylistTilesWidget(
                              controller: controller,
                              index: index,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 119, 109, 234)),
                  onPressed: () {
                    addPlaylistDialog(_playlistController);
                  },
                  child: const Text(
                    'create new',
                    style: whiteText,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
