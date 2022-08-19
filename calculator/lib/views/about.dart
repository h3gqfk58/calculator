import 'package:calculator/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../helpers/widgets.dart';
import 'licenses.dart';

class About extends StatefulWidget {
  const About({key}) : super(key: key);
  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {

  double deviceWidth = 0.0, deviceHeight = 0.0;

  @override
  Widget build(BuildContext context) {

    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: black_1,
      appBar: appBarGeneral(context, "About"),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      "assets/icons/app_icon.png",
                      height: 56,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Calculator",
                    style: TextStyle(
                      fontSize: 20,
                      color: white_1,
                      fontFamily: "OpenSans",
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  const Text(
                    "From Sane",
                    style: TextStyle(
                      color: white_1,
                      fontSize: 11,
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
              color: transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const[
                  Text(
                    "Version",
                    style: TextStyle(
                      color: white_1,
                      fontFamily: "OpenSans",
                      fontSize: 15,
                      letterSpacing: 0.2,
                    ),
                  ),
                  Text(
                    "0.0.0",
                    style: TextStyle(
                      color: white_1,
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Licenses()));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                color: transparent,
                child: const Text(
                  "Licenses",
                  style: TextStyle(
                    color: white_1,
                    fontFamily: "OpenSans",
                    fontSize: 15,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if(!(await launchUrl(Uri.parse("https://www.example.com/"), mode: LaunchMode.externalApplication))) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    width: 120,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children : const [
                        Text(
                          "Error",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            letterSpacing: 0.4,
                          ),
                        ),
                      ],
                    ),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ));
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                color: transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Source code",
                      style: TextStyle(
                        color: white_1,
                        fontFamily: "OpenSans",
                        fontSize: 15,
                        letterSpacing: 0.2,
                      ),
                    ),
                    Text(
                      "www.example.com",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if(!(await launchUrl(Uri.parse("https://www.example.com/"), mode: LaunchMode.externalApplication))) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    width: 120,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children : const [
                        Text(
                          "Error",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            letterSpacing: 0.4,
                          ),
                        ),
                      ],
                    ),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ));
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                color: transparent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Terms and Privacy Policy",
                      style: TextStyle(
                        color: white_1,
                        fontFamily: "OpenSans",
                        fontSize: 15,
                        letterSpacing: 0.2,
                      ),
                    ),
                    Text(
                      "www.example.com",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if(!(await launchUrl(Uri.parse("https://www.example.com/"), mode: LaunchMode.externalApplication))) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    width: 120,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children : const [
                        Text(
                          "Error",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            letterSpacing: 0.4,
                          ),
                        ),
                      ],
                    ),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ));
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                color: transparent,
                //color: const Color(0xFFA81B1B),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Website",
                      style: TextStyle(
                        color: white_1,
                        fontFamily: "OpenSans",
                        fontSize: 15,
                        letterSpacing: 0.2,
                      ),
                    ),
                    Text(
                      "www.example.com",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}