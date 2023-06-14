import 'package:hive/hive.dart';
import 'package:music_app_getx/constands/constand.dart';
import 'package:music_app_getx/models/models.dart';

mixin AllSongsFunctClass {
  Future<void> addSongsToDB(SongsListModel song) async {
    List checkIfSongAlreadyExist = [];
    final songDB = await Hive.openBox<SongsListModel>(allSongsDbName);
    // songDB.clear();
    for (var song in songDB.values) {
      checkIfSongAlreadyExist.add(song.songTitle);
    }
    if (!checkIfSongAlreadyExist.contains(song.songTitle)) {
      final id = await songDB.add(song);
      song.id = id;
      await songDB.put(id, song);
    }
  }
}
