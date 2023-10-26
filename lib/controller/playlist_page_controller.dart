import 'package:get/get.dart';
import 'package:music_app_getx/models/models.dart';
import 'package:hive/hive.dart';

const String playlistBox = 'playlist_db';

class PlayListPageController extends GetxController {
  List<PlayListModel> playListTitle = [];

  @override
  onInit() {
    super.onInit();
    getAllPlaylist();
  }

  getAllPlaylist() async {
    final playListDb = await Hive.openBox<PlayListModel>(playlistBox);
    // await playListDb.clear();
    playListTitle.clear();
    for (var element in playListDb.values) {
      playListTitle.add(element);
    }
    update();
  }

  void addPlaylist(String name) async {
    final data = PlayListModel(playlistName: name, songsInPlaylist: []);
    final playListDb = await Hive.openBox<PlayListModel>(playlistBox);
    int id = await playListDb.add(data);
    data.id = id;
    await playListDb.put(id, data);
    await getAllPlaylist();
  }

  editPlaylistName(int id, String name) async {
    final playListDb = await Hive.openBox<PlayListModel>(playlistBox);
    final val = playListDb.get(id);
    val!.playlistName = name;
    await playListDb.put(id, val);
    await getAllPlaylist();
  }

  deletePlaylist(int id) async {
    final playListDb = await Hive.openBox<PlayListModel>(playlistBox);
    await playListDb.delete(id);
    await getAllPlaylist();
  }
}
