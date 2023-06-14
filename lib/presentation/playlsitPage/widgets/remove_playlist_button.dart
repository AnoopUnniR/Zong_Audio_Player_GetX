import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_getx/controller/playlist_songs_list_controller.dart';

removefromPlaylist(int id, int playlistId) {
  final playlistSongsController = Get.find<PlaylistSongsController>();
  return Padding(
    padding: const EdgeInsets.only(left: 18.0, right: 18, top: 8),
    child: SizedBox(
      height: 40,
      width: double.infinity,
      child: ElevatedButton(
        style:
            ElevatedButton.styleFrom(backgroundColor: const Color(0xff121526)),
        onPressed: () {
          Get.back();
          playlistSongsController.removeFromPlaylist(id, playlistId);
        },
        child: const Text(
          'REMOVE FROM PLAYLIST',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    ),
  );
}
