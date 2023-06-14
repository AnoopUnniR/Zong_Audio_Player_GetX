import 'package:get/get.dart';
import 'package:music_app_getx/controller/all_songs_controller.dart';
import 'package:music_app_getx/controller/most_played_songs.dart';
import 'package:music_app_getx/controller/recent_played_controller.dart';
import 'package:music_app_getx/models/models.dart';

class CurrentPlayingSongController extends GetxController {
  SongsListModel? currentPlayingSong;

  final songList = Get.put(AllSongsController());
  final recentSong = Get.put(RecentPlayedController());
  final mostPlayedController = Get.put(MostPlayedController());
  // final mostPlayedController = Get.find<MostPlayedController>();


  currentSongUpdate(int id) {
    if (id != songList.songsList.length && id != -1) {
      currentPlayingSong = songList.songsList[id];
    }
    recentSong.addToRecent(id);
    mostPlayedController.addToMostplayed(id);
    update();
  }
}
