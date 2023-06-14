import 'package:hive_flutter/adapters.dart';
import 'package:music_app_getx/constands/constand.dart';
import 'package:music_app_getx/controller/all_songs_controller.dart';
import 'package:music_app_getx/controller/most_played_songs.dart';
import 'package:music_app_getx/controller/playlist_page_controller.dart';
import 'package:music_app_getx/models/models.dart';
import 'package:restart_app/restart_app.dart';

class ResetApp {
  resetAppFunction() async {
    final songDb = await Hive.openBox<SongsListModel>(allSongsDbName);
    final playListDb = await Hive.openBox<PlayListModel>("playlist_db");
    final recentDb = await Hive.openBox<RecentPlayedModel>('recent_db');

    songDb.clear();
    playListDb.clear();
    recentDb.clear();
    await AllSongsController().getAllSongs();
    await PlayListPageController().getAllPlaylist();
    await MostPlayedController().getAllRecebtPlayed();
    await Restart.restartApp();
  }
}
