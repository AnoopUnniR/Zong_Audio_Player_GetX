 import 'package:flutter/material.dart';
import 'package:get/get.dart';

snackBarWidget({required String message, required String title}){
  return Get.snackbar(
          title , message,
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.white);
}