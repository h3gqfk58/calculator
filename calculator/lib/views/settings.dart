import 'package:calculator/helpers/colors.dart';
import 'package:flutter/material.dart';
import '../helpers/widgets.dart';

class Settings extends StatefulWidget {
  const Settings({key}) : super(key: key);
  @override
  State<Settings> createState() => _SettingsState();
}

enum Theme { dark, light }
enum History { no, delete, store }

class _SettingsState extends State<Settings> {

  double deviceWidth = 0.0, deviceHeight = 0.0;
  Theme? theme = Theme.dark;
  History? history = History.delete;

  @override
  Widget build(BuildContext context) {

    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: black_1,
      appBar: appBarGeneral(context, "Settings"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Theme",
                style: TextStyle(
                  color: white_1,
                  fontFamily: "OpenSans",
                  fontSize: 15,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 35,
                    width: 30,
                    child: Radio<Theme>(
                      value: Theme.dark,
                      groupValue: theme,
                      fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                        return white_1;
                      }),
                      onChanged: (Theme? value) {
                        setState(() {
                          theme = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Dark",
                    style: TextStyle(
                      color: white_1,
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    height: 35,
                    width: 30,
                    child: Radio<Theme>(
                      value: Theme.light,
                      groupValue: theme,
                      fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                        return white_1;
                      }),
                      onChanged: (Theme? value) {
                        setState(() {
                          theme = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Light",
                    style: TextStyle(
                      color: white_1,
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "History",
                style: TextStyle(
                  color: white_1,
                  fontFamily: "OpenSans",
                  fontSize: 15,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 35,
                    width: 30,
                    child: Radio<History>(
                      value: History.no,
                      groupValue: history,
                      fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                        return white_1;
                      }),
                      onChanged: (History? value) {
                        setState(() {
                          history = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "Do not store History at all",
                    style: TextStyle(
                      color: white_1,
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    height: 35,
                    width: 30,
                    child: Radio<History>(
                      value: History.delete,
                      groupValue: history,
                      fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                        return white_1;
                      }),
                      onChanged: (History? value) {
                        setState(() {
                          history = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "Delete after closing the app",
                    style: TextStyle(
                      color: white_1,
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    height: 35,
                    width: 30,
                    child: Radio<History>(
                      value: History.store,
                      groupValue: history,
                      fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                        return white_1;
                      }),
                      onChanged: (History? value) {
                        setState(() {
                          history = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "Store History",
                    style: TextStyle(
                      color: white_1,
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}