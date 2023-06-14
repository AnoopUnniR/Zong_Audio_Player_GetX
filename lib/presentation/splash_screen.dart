import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_getx/controller/splash_screen_controller.dart';
import 'package:music_app_getx/constands/constand.dart';

class SplashScreenPage extends StatelessWidget {
  SplashScreenPage({super.key});
  final splashScreenController = Get.put(SplashScreenController());
      
  @override
  Widget build(BuildContext context) {
    displayHeight = MediaQuery.of(context).size.height;
    displayWight = MediaQuery.of(context).size.width / 100;
  
    return Scaffold(
      backgroundColor: const Color(0xff121526),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            CircleAvatar(
              radius: 40,
              backgroundColor: const Color(0xff121526),
              child: Image.asset('assets/app_icon.png'),
            ),
            const Padding(
              padding: EdgeInsets.all(30.0),
              child: Text(
                'Loading...',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
