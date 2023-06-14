import 'package:get/get.dart';
import 'package:music_app_getx/functions/music_get_func.dart';
import 'package:music_app_getx/presentation/homepage/home_page.dart';

class SplashScreenController extends GetxController {
  final musicGet = MusicFunctionsClass();
  @override
  void onInit() async{
    super.onInit();
    await musicGet.songList();
    await loadDataAndNavigate();
  }

  void navigateToHomeScreen() {
    Get.off(() =>  HomePage());
  }

  Future<void> loadDataAndNavigate() async {
    await Future.delayed(const Duration(seconds: 1));
    navigateToHomeScreen();
  }
}
