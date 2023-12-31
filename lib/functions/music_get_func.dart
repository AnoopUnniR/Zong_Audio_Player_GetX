import 'package:get/get.dart';
import 'package:music_app_getx/constands/constand.dart';
import 'package:music_app_getx/controller/current_playing_song_controller.dart';
import 'package:music_app_getx/functions/songs_hive.dart';
import 'package:music_app_getx/models/models.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:just_audio/just_audio.dart';

class MusicFunctionsClass with AllSongsFunctClass {
  final currentPlayer = Get.put(CurrentPlayingSongController());
  songList() async {
    List<SongModel> songs = await audioQuery.querySongs(
        sortType: null,
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL);

    for (var song in songs) {
      SongsListModel songs = SongsListModel(
        songTitle: song.title,
        songuri: song.uri!,
        songArtist: song.artist,
        imageId: song.id,
      );
      await addSongsToDB(songs);
    }
  }

  creatingPlayerList(List<SongsListModel> songsList) async {
    List<AudioSource> sources = [];
    for (var song in songsList) {
      sources.add(
        AudioSource.uri(
          Uri.parse(song.songuri),
        ),
      );
    }
    playing = ConcatenatingAudioSource(children: sources);
  }

  creatingPlayerListShuffle(List songs) async {
    await player.stop();
    List<AudioSource> sources = [];
    for (var song in songs) {
      sources.add(
        AudioSource.uri(
          Uri.parse(song),
        ),
      );
    }
    player.setShuffleModeEnabled(true);
    playing = ConcatenatingAudioSource(
        children: sources,
        shuffleOrder: DefaultShuffleOrder(),
        useLazyPreparation: true);
    await player.setAudioSource(
      playing!,
      initialPosition: Duration.zero,
    );
    await player.play();
  }

  Future<void> playingAudio(index) async {
    if (index > -1 && index < playing!.length) {
      await player.stop();
      await player.setAudioSource(playing!,
          initialPosition: Duration.zero, initialIndex: index);
      await player.play();
    }
  }
}
