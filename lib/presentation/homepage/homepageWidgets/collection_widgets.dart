import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_getx/presentation/favouritesPage/favourites_page.dart';
import 'package:music_app_getx/presentation/homepage/homepageWidgets/collections_widget.dart';
import 'package:music_app_getx/presentation/mostPlayedScreen/most_played_page.dart';
import 'package:music_app_getx/presentation/playlsitPage/playlist_page.dart';
import 'package:music_app_getx/presentation/recentPlayed/recent_played.dart';

class CollectionWidgets extends StatelessWidget {
  const CollectionWidgets({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(width: 20),
          InkWell(
              onTap: () => Get.to(
                    () => FavoritesScreen(),
                  ),
              child: collectionsHomePage(
                  width: width,
                  color: const Color(0xfffb8943),
                  title: 'FAVOURITES')),
          const SizedBox(width: 20),
          InkWell(
            child: collectionsHomePage(
                width: width,
                color: const Color(0xff71c4fc),
                title: 'PLAYLIST'),
            onTap: () => Get.to(
              () => PlayListPage(),
            ),
          ),
          const SizedBox(width: 20),
          InkWell(
            child: collectionsHomePage(
                width: width,
                color: const Color(0xfff8ce67),
                title: 'RECENT SONGS'),
            onTap: () => Get.to(
              () => RecentPlayedScreen(),
            ),
          ),
          const SizedBox(width: 20),
          //------------------------------------------------------------------------
          InkWell(
            child: collectionsHomePage(
                width: width,
                color: const Color.fromARGB(255, 236, 236, 239),
                title: 'MOST PLAYED'),
            onTap: () => Get.to(
              () => MostPlayedPage(),
            ),
          ),
        ],
      ),
    );
  }
}
