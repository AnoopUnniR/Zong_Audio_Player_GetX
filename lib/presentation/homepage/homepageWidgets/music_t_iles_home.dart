import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_getx/controller/current_playing_song_controller.dart';
import 'package:music_app_getx/controller/mini_player_controller.dart';
import 'package:music_app_getx/functions/music_get_func.dart';
import 'package:music_app_getx/models/models.dart';
import 'package:music_app_getx/presentation/musicPlayerPage/music_player_screen.dart';
import 'package:music_app_getx/presentation/widgets/menu_icon_home.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicTIlesHome extends StatelessWidget {
  const MusicTIlesHome({
    super.key,
    required this.songs,
    required this.musicFucntion,
    required this.miniPlayerClasscontroller,
    required this.index,
  });
  final int index;
  final List<SongsListModel> songs;
  final MusicFunctionsClass musicFucntion;
  final MiniPlayerController miniPlayerClasscontroller;


  @override
  Widget build(BuildContext context) {
  final currentPlayinSongController = Get.put(CurrentPlayingSongController());
     SongsListModel song = songs[index];
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        //listing songs//------------------------------------------------
        child: ListTile(
          onTap: () async {
            
            await currentPlayinSongController.currentSongUpdate(song.id!);
            miniPlayerClasscontroller.isMiniPlayerVisible(true);
            await musicFucntion.creatingPlayerList(songs);
            await musicFucntion.playingAudio(index);

            Get.to(() => MusicPlayerScreen(
                  index: index,
                  songs: songs,
                ));
          },
          title: Text(
           song.songTitle,
            style: const TextStyle(
              color: Color.fromARGB(255, 37, 36, 36),
            ),
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            song.songArtist??"Unknown",
            style: const TextStyle(
                color: Color.fromARGB(255, 55, 55, 55),
                overflow: TextOverflow.ellipsis),
          ),
          leading: QueryArtworkWidget(
            id: song.imageId!,
            type: ArtworkType.AUDIO,
            nullArtworkWidget: Image.asset(
              'assets/0.png',
            ),
          ),
          trailing: menuIcon(id: song.id!, isPlaylist: false),
        ),
      ),
    );
  }
}
