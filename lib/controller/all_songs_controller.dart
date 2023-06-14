import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:music_app_getx/constands/constand.dart';
import 'package:music_app_getx/models/models.dart';
import 'package:music_app_getx/presentation/widgets/snackbar_widget.dart';

class AllSongsController extends GetxController {
  List songsList = [];

  @override
  onInit() {
    getAllSongs();
    super.onInit();
  }

  getAllSongs() async {
    final songDb = await Hive.openBox<SongsListModel>(allSongsDbName);
    // songDb.clear();
    songsList.clear();
    songsList.assignAll(songDb.values.toList());
    update();
  }

  updateFavourites(int id) async {
    final songDb = await Hive.openBox<SongsListModel>(allSongsDbName);
    final value = songDb.values.firstWhere((element) => element.id == id);
    value.isfav = !value.isfav;
    songDb.putAt(id, value);
    getAllSongs();
    if (value.isfav) {
      snackBarWidget(message: '${value.songTitle} Added to favourites', title: 'Added');
    } else {
      snackBarWidget(message: '${value.songTitle} Removed from favourites', title: "Removed");
    }
  }
}
