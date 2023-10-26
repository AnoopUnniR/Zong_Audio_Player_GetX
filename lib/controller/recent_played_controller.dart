import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:music_app_getx/models/models.dart';

class RecentPlayedController extends GetxController {
  List recentPlayed = [];
  final String recentBox = 'recent_db';

  @override
  onInit() {
    super.onInit();
    getAllRecent();
  }

  void addToRecent(int value) async {
    var song = RecentPlayedModel(recentPlayedSongId: value);
    final recentDb = await Hive.openBox<RecentPlayedModel>(recentBox);
    if (recentPlayed.contains(value)) {
      await recentDb.delete(recentDb.values
          .firstWhere((element) => element.recentPlayedSongId == value)
          .id);
    }
    if (recentDb.values.length > 8) {
      await recentDb.deleteAt(0);
    }
    int id = await recentDb.add(song);
    song.id = id;
    await recentDb.put(id, song);
    getAllRecent();
  }

  getAllRecent() async {
    final recentDb = await Hive.openBox<RecentPlayedModel>(recentBox);
    recentPlayed.clear();
    for (var val in recentDb.values) {
      recentPlayed.add(val.recentPlayedSongId);
    }
    // recentDb.clear();
    update();
  }
}
