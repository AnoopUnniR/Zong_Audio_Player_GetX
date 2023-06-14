import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:music_app_getx/constands/constand.dart';
import 'package:music_app_getx/controller/all_songs_controller.dart';
import 'package:music_app_getx/models/models.dart';

class MostPlayedController extends GetxController {
  List<int> mostPlayed = [];

  final songs = Get.find<AllSongsController>();
  @override
  onInit() {
    super.onInit();
    getAllRecebtPlayed();
  }

  addToMostplayed(int id) async {
    final songDb = await Hive.openBox<SongsListModel>(allSongsDbName);
    try {
      final song = songDb.values.firstWhere((element) => element.id == id);
      song.mostplayedCount = song.mostplayedCount + 1;
      songDb.put(song.id, song);
    } catch (e) {
      print(e);
    }

    getAllRecebtPlayed();
  }

  getAllRecebtPlayed() async {
    mostPlayed.clear();
    final songDb = await Hive.openBox<SongsListModel>(allSongsDbName);
    List mostPlayedSongs = songDb.values.toList()
      ..sort((a, b) => b.mostplayedCount.compareTo(a.mostplayedCount));
    List values = [...mostPlayedSongs.take(8).toList()];

    List most = [];
    for (var element in values) {
      if (element.mostplayedCount != 0) {
        most.add(element);
      }
    }
    if (most.isNotEmpty) {
      mostPlayed.assignAll(most.map((e) => e.id));
    }
  }
}
