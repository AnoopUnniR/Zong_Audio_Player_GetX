import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_getx/constands/constand.dart';
import 'package:music_app_getx/controller/playlist_page_controller.dart';
import 'package:music_app_getx/presentation/widgets/snackbar_widget.dart';

addPlaylistDialog(
  PlayListPageController playlistController,
) {
  List checkName =
      playlistController.playListTitle.map((e) => e.playlistName).toList();
  TextEditingController playlistNameController = TextEditingController();
  return Get.dialog(
    AlertDialog(
      title: const Text(
        'Enter the playlist name',
        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 25),
      ),
      backgroundColor: const Color.fromARGB(255, 218, 215, 215),
      content: SizedBox(
        height: 50,
        child: Center(
          child: TextFormField(
            controller: playlistNameController,
            validator: (value) {
              if (playlistNameController.text.trim().isEmpty) {
                return 'name is required';
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(8),
                hintText: 'Enter playlist name...,',
                hintStyle: TextStyle(
                    color: Color.fromARGB(153, 35, 28, 28),
                    fontSize: 20,
                    fontStyle: FontStyle.italic),
                border: OutlineInputBorder()),
            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async{
            if (playlistNameController.text.trim().isEmpty) {
              snackBarWidget(message: "Please enter a name", title: '');
            } else if (checkName.contains(playlistNameController.text)) {
              
              snackBarWidget(
                  message:
                      'playlist with name "${playlistNameController.text}" already exists',
                  title: 'Exists');
            } else  {
             playlistController
                  .addPlaylist(playlistNameController.text.trim());
              playlistNameController.clear();
              Get.back();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff8177ea),
          ),
          child: const Text(
            'create',
            style: whiteText,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            playlistNameController.clear();
            Get.back();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff8177ea),
          ),
          child: const Text(
            'cancel',
            style: whiteText,
          ),
        ),
      ],
    ),
  );
}
