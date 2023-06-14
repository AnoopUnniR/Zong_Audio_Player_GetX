import 'package:flutter/material.dart';

Widget collectionsHomePage(
  {required double width,
  required Color color,
  required String title}
) {
  return Container(
    width: width * 33,
    height: width * 10,
    decoration: BoxDecoration(
      color: color,
      borderRadius:const BorderRadius.all(
        Radius.circular(20),
      ),
    ),
    child:  Center(
      child: Text(
        title,
        style:const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),
  );
}
