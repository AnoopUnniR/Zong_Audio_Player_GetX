import 'package:get/get.dart';

class MiniPlayerController extends GetxController {
  RxBool isMiniPlayerVisible = false.obs;

  miniPlayerVisible(bool isMiniPlayerVisible) {
    this.isMiniPlayerVisible.value = isMiniPlayerVisible;
   
  }
}
