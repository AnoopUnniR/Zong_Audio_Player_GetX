import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_getx/functions/reset_db.dart';
import 'package:music_app_getx/presentation/settings/pages/about_us.dart';
import 'package:music_app_getx/presentation/settings/pages/privacy_policy_page.dart';
import 'package:music_app_getx/presentation/splash_screen.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    var reset = ResetApp();

    return Scaffold(
      backgroundColor: const Color(0xff121526),
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        toolbarHeight: 50,
        backgroundColor: const Color.fromARGB(255, 38, 32, 63),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutUsPage(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10)),
                child: const ListTile(
                  title: Text(
                    'About Us',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                title: const Text(
                  'Privacy Policy',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrivacyPage(),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10)),
              child: const ListTile(
                title: Text(
                  'Build Version',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                subtitle: Text(
                  '0.0.1',
                  style: TextStyle(
                    color: Color.fromARGB(255, 194, 190, 190),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(10)),
                child: const ListTile(
                  title: Text(
                    'Reset',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      title:
                          const Text('Are you sure you want to reset the app?'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            reset.resetAppFunction();
                            Get.offAll(()=>SplashScreenPage());
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          child: const Text('Yes'),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 119, 109, 234)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('No')),
                      ]),
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
