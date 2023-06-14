import 'package:get/get.dart';
import 'package:music_app_getx/models/models.dart';
import 'package:hive/hive.dart';

class PlayListPageController extends GetxController {
  List playListTitle = [];

  String playlistBox = 'playlist_db';
  @override
  onInit() {
    super.onInit();
    getAllPlaylist();
  }

  getAllPlaylist() async {
    final playListDb = await Hive.openBox<PlayListModel>(playlistBox);
    // playListDb.clear();
    playListTitle.assignAll(playListDb.values);
    update();
  }

  addPlaylist(String name) async {
    final data = PlayListModel(playlistName: name);
    final playListDb = await Hive.openBox<PlayListModel>(playlistBox);
    int id = await playListDb.add(data);
    data.id = id;
    data.songsInPlaylist = [];
    playListDb.put(id, data);
    getAllPlaylist();
  }

  editPlaylistName(int id, String name) async {
    final playListDb = await Hive.openBox<PlayListModel>(playlistBox);
    final val = playListDb.get(id);
    val!.playlistName = name;
    playListDb.put(id, val);
    getAllPlaylist();
  }

  deletePlaylist(int id) async {
    final playListDb = await Hive.openBox<PlayListModel>(playlistBox);
    playListDb.delete(id);
    getAllPlaylist();
  }
}
