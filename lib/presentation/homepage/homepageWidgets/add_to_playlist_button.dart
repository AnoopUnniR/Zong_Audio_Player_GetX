import 'package:flutter/material.dart';
import 'package:music_app_getx/presentation/homepage/homepageWidgets/playlist_add_dialogue.dart';

addToPlaylistbutton(int id, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 18.0, right: 18, top: 8),
    child: SizedBox(
      height: 40,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff121526),
        ),
        onPressed: () {
          Navigator.pop(context);
          playlistDialogue(id);
        },
        child: const Text(
          'ADD TO PLAYLIST',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    ),
  );
}
