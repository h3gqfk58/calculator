import 'package:calculator/helpers/colors.dart';
import 'package:flutter/material.dart';
import '../helpers/widgets.dart';

class Licenses extends StatefulWidget {
  const Licenses({key}) : super(key: key);
  @override
  State<Licenses> createState() => _LicensesState();
}

class _LicensesState extends State<Licenses> {

  double deviceWidth = 0.0, deviceHeight = 0.0;

  @override
  Widget build(BuildContext context) {

    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: black_1,
      appBar: appBarGeneral(context, "Licenses"),
    );
  }
}