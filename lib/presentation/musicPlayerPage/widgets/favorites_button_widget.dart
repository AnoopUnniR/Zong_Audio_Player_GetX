import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_getx/controller/all_songs_controller.dart';
import 'package:music_app_getx/controller/current_playing_song_controller.dart';
import 'package:music_app_getx/models/models.dart';

class FavoritesButtonWidget extends StatelessWidget {
  const FavoritesButtonWidget({
    super.key,
    required this.currentSongController,
    required this.songListController,
    required this.song,
  });

  final CurrentPlayingSongController currentSongController;
  final AllSongsController songListController;
  final SongsListModel song;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllSongsController>(
      builder: (controller) {
        return controller
                    .songsList[currentSongController.currentPlayingSong!.id!]
                    .isfav ==
                false
            ? IconButton(
                onPressed: () {
                  songListController.updateFavourites(song.id!);
                },
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                ),
              )
            : IconButton(
                onPressed: () {
                  songListController.updateFavourites(song.id!);
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
              );
      },
    );
  }
}
