import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_getx/controller/all_songs_controller.dart';
import 'package:music_app_getx/controller/current_playing_song_controller.dart';
import 'package:music_app_getx/controller/mini_player_controller.dart';
import 'package:music_app_getx/functions/music_get_func.dart';
import 'package:music_app_getx/models/models.dart';
import 'package:music_app_getx/presentation/miniPlayer/mini_player.dart';
import 'package:music_app_getx/presentation/widgets/menu_icon_home.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final musicFunciton = MusicFunctionsClass();
  final currentMusicController = Get.find<CurrentPlayingSongController>();
  final miniPlayer = Get.find<MiniPlayerController>();
  String search = '';
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List findList = [];
    return Scaffold(
      backgroundColor: const Color(0xff121526),
      appBar: AppBar(
          title: Container(
            width: width * 70,
            alignment: Alignment.centerLeft,
            color: const Color.fromARGB(255, 38, 32, 63),
            child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: 'search here...',
                ),
                onChanged: (value) => setState(() {
                      search = value;
                    })),
          ),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          toolbarHeight: 50,
          backgroundColor: const Color.fromARGB(255, 38, 32, 63)),
      body: SafeArea(
        child: Stack(
          children: [
            GetBuilder<AllSongsController>(
              builder: (controller) {
                if (controller.songsList.isEmpty) {
                  return const Center(
                    child: Text(
                      'no audio files found with the name',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                if (search.isEmpty) {
                  findList = controller.songsList.toList();
                } else {
                  findList = controller.songsList
                      .where((element) => element.songTitle
                          .toLowerCase()
                          .contains(search.toLowerCase()))
                      .toList();
                }
                if (findList.isEmpty) {
                  return const Center(
                    child: Text(
                      'no songs found',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.white,
                    thickness: 2,
                    height: 0,
                  ),
                  shrinkWrap: true,
                  itemCount: findList.length,
                  itemBuilder: (context, index) {
                    // var path = findList[index].songuri;
                    var title = findList[index].songTitle;
                    var artist = findList[index].songArtist!;
                    var image = findList[index].imageId;
                    var id = findList[index].id;
                    return ColoredBox(
                      color: Colors.black,
                      //listing songs//------------------------------------------------
                      child: ListTile(
                        onTap: () async {
                          int searchResultId = controller.songsList.indexWhere(
                              (element) => element.id == findList[index].id);
                          SongsListModel song =
                              controller.songsList[searchResultId];
                          await currentMusicController
                              .currentSongUpdate(song.id!);
                          await musicFunciton.creatingPlayerList(
                              [song]);
                          await musicFunciton.playingAudio(0);
                          miniPlayer.isMiniPlayerVisible.value = true;
                        },
                        title: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          artist,
                          style: const TextStyle(color: Colors.white),
                        ),
                        leading: QueryArtworkWidget(
                          id: image!,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: Image.asset(
                            'assets/0.png',
                          ),
                        ),
                        trailing: menuIcon(id: id, isPlaylist: false),
                      ),
                    );
                  },
                );
              },
            ),
            const Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: MiniPlayerClass(),
            ),
          ],
        ),
      ),
    );
  }
}
