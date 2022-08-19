import 'package:calculator/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar appBarGeneral(context, title) {
  return AppBar(
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Color(0x00000000),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: const Color(0x00000000),
    toolbarHeight: 75,
    title: Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            color: const Color(0xFF111111),
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: white_1,
            ),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Text(
          title,
          style: const TextStyle(
            color: white_1,
            fontFamily: "OpenSans",
            fontSize: 17,
            letterSpacing: 0.6,
          ),
        ),
      ],
    ),
    elevation: 0,
    titleSpacing: 20,
    automaticallyImplyLeading: false,
  );
}