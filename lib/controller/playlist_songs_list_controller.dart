import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_app_getx/controller/playlist_page_controller.dart';
import 'package:music_app_getx/models/models.dart';
import 'package:music_app_getx/presentation/widgets/snackbar_widget.dart';

class PlaylistSongsController extends GetxController {
  List songsInPlaylist = [];

  getPlaylistSongs(int id) async {
    final playlistSongsDb = Hive.box<PlayListModel>(playlistBox);
    final val = playlistSongsDb.get(id);
    songsInPlaylist.assignAll(val!.songsInPlaylist);
    update();
  }

  addToPlaylist(int id, int playlistId) async {
    final playlistSongsDb = await Hive.openBox<PlayListModel>(playlistBox);

    final val = playlistSongsDb.get(playlistId);
    try {
      if (!val!.songsInPlaylist.contains(id)) {
         val.songsInPlaylist.add(id);
        await playlistSongsDb.put(playlistId, val);
        await getPlaylistSongs(playlistId);
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
    val!.songsInPlaylist.remove(id);
    getPlaylistSongs(playlistId);
    snackBarWidget(
        message: 'Removed from playlist ${val.playlistName}', title: 'Removed');
  }
}
