import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_getx/constands/constand.dart';
import 'package:music_app_getx/controller/all_songs_controller.dart';
import 'package:music_app_getx/controller/current_playing_song_controller.dart';
import 'package:music_app_getx/functions/music_get_func.dart';
import 'package:music_app_getx/models/models.dart';
import 'package:music_app_getx/presentation/homepage/homepageWidgets/playlist_add_dialogue.dart';
import 'package:rxdart/rxdart.dart' as dartrx;
import 'package:on_audio_query/on_audio_query.dart';
import 'package:just_audio/just_audio.dart';
import 'package:text_scroll/text_scroll.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

class MusicPlayerScreen extends StatelessWidget {
  MusicPlayerScreen({super.key, required this.index,required this.songsIds});
  final int index;
  final List songsIds;

  Stream<DurationState> get _durationStateStream =>
      dartrx.Rx.combineLatest2<Duration, Duration?, DurationState>(
          player.positionStream,
          player.durationStream,
          (position, duration) => DurationState(
              position: position, total: duration ?? Duration.zero));
  List<IconData> icons = [Icons.play_arrow_outlined, Icons.pause];
  final songListController = Get.find<AllSongsController>();
  final currentSongController = Get.find<CurrentPlayingSongController>();
  final musicFunction = MusicFunctionsClass();
  @override
  Widget build(BuildContext context) {
    int indexVal = index;
    var iconColor = const Color.fromARGB(255, 238, 238, 238);
    double width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      backgroundColor: const Color(0xff121526),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            //main column
            GetBuilder<CurrentPlayingSongController>(builder: (songController) {
              SongsListModel song = songController.currentPlayingSong!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    decoration: const BoxDecoration(),
                    height: width * 75,
                    child: QueryArtworkWidget(
                      id: song.id!,
                      type: ArtworkType.AUDIO,
                      artworkFit: BoxFit.cover,
                      nullArtworkWidget: Image.asset(
                        'assets/icon.png',
                      ),
                    ),
                  ),
                  // -------------------------------play buttons-----------------------
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      height: 25,
                      width: width * 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              playlistDialogue(index);
                            },
                            icon: const Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                          ),
                          GetBuilder<AllSongsController>(
                            builder: (controller) {
                              return controller
                                          .songsList[currentSongController
                                              .currentPlayingSong!.id!]
                                          .isfav ==
                                      false
                                  ? IconButton(
                                      onPressed: () {
                                        songListController
                                            .updateFavourites(song.id!);
                                      },
                                      icon: const Icon(
                                        Icons.favorite_border,
                                        color: Colors.white,
                                      ),
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        songListController
                                            .updateFavourites(song.id!);
                                      },
                                      icon: const Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                      ),
                                    );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            width: width * 100,
                            child: Center(
                              child: TextScroll(
                                song.songTitle,
                                style:
                                    TextStyle(fontSize: 17, color: iconColor),
                                delayBefore: const Duration(milliseconds: 1000),
                                selectable: true,
                                pauseBetween: const Duration(milliseconds: 500),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          song.songArtist ?? '<unknown>',
                          style: TextStyle(
                              color: iconColor,
                              overflow: TextOverflow.ellipsis),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          //slider bar duration state stream
                          child: StreamBuilder<DurationState>(
                            stream: _durationStateStream,
                            builder: (context, snapshot) {
                              final durationState = snapshot.data;
                              final progress =
                                  durationState?.position ?? Duration.zero;
                              final total =
                                  durationState?.total ?? Duration.zero;

                              return ProgressBar(
                                progress: progress,
                                total: total,
                                barHeight: 5.0,
                                baseBarColor: const Color(0xff8177ea),
                                progressBarColor: Colors.white,
                                thumbColor: Colors.white,
                                timeLabelLocation: TimeLabelLocation.sides,
                                timeLabelTextStyle: const TextStyle(
                                    fontSize: 15, color: Colors.white),
                                onSeek: (duration) {
                                  player.seek(duration);
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                if(indexVal>=0){
                                  currentSongController.currentSongUpdate(songsIds[indexVal--]);
                                musicFunction.playingAudio(indexVal--);
                                }
                                
                              },
                              icon: Icon(
                                Icons.skip_previous_outlined,
                                size: 40,
                                color: iconColor,
                              ),
                            ),
                            StreamBuilder<PlayerState>(
                              stream: player.playerStateStream,
                              builder: (context, snapshot) {
                                final playerState = snapshot.data;
                                final playing = playerState?.playing;
                                if (playing != true) {
                                  return Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                      ),
                                      iconSize: 60.0,
                                      onPressed: player.play,
                                    ),
                                  );
                                } else {
                                  return Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: IconButton(
                                      icon: const Icon(Icons.pause,
                                          color: Colors.white),
                                      iconSize: 60.0,
                                      onPressed: player.pause,
                                    ),
                                  );
                                }
                              },
                            ),
                            IconButton(
                              onPressed: () {
            
                                if(indexVal<songsIds.length){
                                  currentSongController.currentSongUpdate(songsIds[indexVal++]);
                                musicFunction.playingAudio(indexVal);
                                }
                                
                              },
                              icon: Icon(
                                Icons.skip_next_outlined,
                                size: 40,
                                color: iconColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

class DurationState {
  DurationState({this.position = Duration.zero, this.total = Duration.zero});
  Duration position, total;
}
