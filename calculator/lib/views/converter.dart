import 'package:calculator/helpers/colors.dart';
import 'package:calculator/helpers/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'converter_specific.dart';

class Converter extends StatefulWidget {
  const Converter({key}) : super(key: key);
  @override
  State<Converter> createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {

  double deviceWidth = 0.0, deviceHeight = 0.0;

  Widget buttons(String x) {
    IconData icon = Icons.settings_rounded;
    String title = "";

    if(x == "mass") {
      icon = Icons.scale_rounded;
      title = "Mass";
    }
    else if(x == "time") {
      icon = Icons.access_time;
      title = "Time";
    }
    else if(x == "temperature") {
      icon = Icons.thermostat_rounded;
      title = "Temperature";
    }
    else if(x == "length") {
      icon = Icons.expand_rounded;
      title = "Length";
    }
    else if(x == "area") {
      icon = Icons.crop_square_rounded;
      title = "Area";
    }
    else if(x == "volume") {
      icon = Icons.inbox_rounded;
      title = "Volume";
    }
    else if(x == "speed") {
      icon = Icons.speed;
      title = "Speed";
    }
    else if(x == "date") {
      icon = Icons.date_range_rounded;
      title = "Date";
    }
    else if(x == "data") {
      icon = Icons.data_array_rounded;
      title = "Data";
    }
    else if(x == "numbers") {
      icon = Icons.numbers_rounded;
      title = "Number System";
    }
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if(x.isNotEmpty) {
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle.light.copyWith(
                systemNavigationBarColor: black_2,
              ),
            );
            Navigator.push(context, MaterialPageRoute(builder: (context) => ConverterSpecific(x: x,))).then((value) => SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle.light.copyWith(
                systemNavigationBarColor: black_1,
              ),
            ));
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          alignment: Alignment.center,
          color: transparent,
          //color: const Color(0xFF118911),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(x.isNotEmpty) Icon(
                icon,
                color: white_1,
                size: 40,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: white_1,
                  fontFamily: "OpenSans",
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: black_1,
      //backgroundColor: const Color(0xFFA11C1C),
      appBar: appBarGeneral(context, "Converter"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                buttons("time"),
                buttons("mass"),
                buttons("temperature"),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                buttons("length"),
                buttons("area"),
                buttons("volume"),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                buttons("speed"),
                buttons("data"),
                //conversionButtons("numbers"),
                buttons(""),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}