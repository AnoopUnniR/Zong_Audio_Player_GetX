import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_app_getx/constands/constand.dart';
import 'package:music_app_getx/models/models.dart';
import 'package:music_app_getx/presentation/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(SongsListModelAdapter().typeId)) {
    Hive.registerAdapter(SongsListModelAdapter());
  }
  if (!Hive.isAdapterRegistered(RecentPlayedModelAdapter().typeId)) {
    Hive.registerAdapter(RecentPlayedModelAdapter());
  }
  if (!Hive.isAdapterRegistered(PlayListModelAdapter().typeId)) {
    Hive.registerAdapter(PlayListModelAdapter());
  }

  await audioQuery.permissionsRequest();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenPage(),
    );
  }
}
