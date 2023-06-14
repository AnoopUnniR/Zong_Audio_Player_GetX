import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_app_getx/models/models.dart';
import 'package:music_app_getx/presentation/widgets/snackbar_widget.dart';

class PlaylistSongsController extends GetxController {
  List songsInPlaylist = [];

  String playlistBox = 'playlist_db';

  getPlaylistSongs(int id) async {
    final playlistSongsDb = await Hive.openBox<PlayListModel>(playlistBox);
    final val = playlistSongsDb.get(id);
    // val!.songsInPlaylist.add(id);
    songsInPlaylist.assignAll(val!.songsInPlaylist!);
    update();
  }

  addToPlaylist(int id, int playlistId) async {
    final playlistSongsDb = await Hive.openBox<PlayListModel>(playlistBox);

    final val = playlistSongsDb.get(playlistId);
    try {
      if (!val!.songsInPlaylist!.contains(id)) {
        val.songsInPlaylist!.add(id);
        playlistSongsDb.put(id, val);
        getPlaylistSongs(playlistId);
        Get.back();
        snackBarWidget(
            message: 'Added to playlist ${val.playlistName}', title: "Added");
      } else {
        snackBarWidget(message: 'Song Already Exists!', title: '');
      }
    } catch (e) {
      snackBarWidget(message: e.toString(), title: 'Error');
      debugPrint(e.toString());
    }
  }

  removeFromPlaylist(int id, int playlistId) async {
    final playlistSongsDb = await Hive.openBox<PlayListModel>(playlistBox);
    final val = playlistSongsDb.get(playlistId);
    val!.songsInPlaylist!.remove(id);
    getPlaylistSongs(playlistId);
  }
}
