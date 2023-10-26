import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_getx/constands/constand.dart';
import 'package:music_app_getx/presentation/search/search_page.dart';
import 'package:music_app_getx/presentation/settings/settings.dart';

class CustomAppbarHomeScreen extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppbarHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(56.0),
      child: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.settings_outlined,
            color: Colors.white,
          ),
          onPressed: () => Get.to(
            () => const SettingsPage(),
          ),
        ),
        title: const Text(
          "Zong",
          style: whiteText,
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        toolbarHeight: 50,
        backgroundColor: const Color.fromARGB(255, 34, 27, 66),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const SearchPage());
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
