import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_getx/controller/playlist_page_controller.dart';
import 'package:music_app_getx/models/models.dart';
import 'package:music_app_getx/presentation/widgets/snackbar_widget.dart';

editingPlaylist(PlayListModel playlist) {
  print(playlist.playlistName);
  print(playlist.id);
  final playlistController = Get.find<PlayListPageController>();
  TextEditingController updateController = TextEditingController();
  updateController.text = playlist.playlistName;
  return Get.dialog(
    AlertDialog(
      title: const Text('Edit playlist name'),
      content: SizedBox(
        height: 50,
        child: Center(
          child: TextFormField(
            controller: updateController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (updateController.text.isEmpty ||
                  updateController.text.trim().isEmpty) {
                return 'name required';
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
                labelText: 'Playlist name',
                contentPadding: EdgeInsets.all(8),
                border: OutlineInputBorder()),
            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (updateController.text.trim().isEmpty) {
              snackBarWidget(
                  message: 'Please enter a name', title: 'Name Required');
            } else {
              String editedName = updateController.text.trim();
              playlistController.editPlaylistName(playlist.id!, editedName);
              updateController.clear();
              Get.back();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff8177ea),
          ),
          child: const Text('save'),
        ),
        ElevatedButton(
          onPressed: () {
            updateController.clear();
            Get.back();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff8177ea),
          ),
          child: const Text(
            'cancel',
          ),
        ),
      ],
    ),
  );
}
