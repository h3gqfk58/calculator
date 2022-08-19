import 'package:calculator/helpers/colors.dart';
import 'package:flutter/material.dart';
import '../helpers/widgets.dart';

class ConverterSpecific extends StatefulWidget {
  const ConverterSpecific({Key? key, required this.x}) : super(key: key);
  final String x;
  @override
  State<ConverterSpecific> createState() => _ConverterSpecificState();
}

class _ConverterSpecificState extends State<ConverterSpecific> {

  double deviceWidth = 0.0, deviceHeight = 0.0;
  String x = "", si = "", unit1 = "", unit2 = "", text1 = "", text2 = "";
  List units = [], unitsFull = [];
  Map cf = {};

  convert() {
    if( (text1 == "") || (text1 == "-") ) {
      text2 = "";
    }
    else {
      double x = 0.0;
      if(text1 == ".") {
        x=0.0;
      }
      else {
        x = double.parse(text1);
      }
      x = ( x - cf[unit1]["a"] ) / cf[unit1]["m"];
      x = ( x * cf[unit2]["m"] ) + cf[unit2]["a"];
      x = double.parse(x.toStringAsPrecision(10));

      if(x.isInfinite) {
        text2 = x.toString();
      }
      else if(x == x.round()) {
        text2 = x.round().toString();
      }
      else {
        text2 = x.toString();
      }

    }
  }

  Widget button(String x) {
    Widget widget = Container();
    if(x=="C") {
      widget = Text(
        x,
        style: const TextStyle(
          fontFamily: "Raleway",
          color: Color(0xFFDE3434),
          fontSize: 21,
          fontWeight: FontWeight.w500,
        ),
      );
    }
    else if(x=="backspace") {
      widget = const Icon(
        Icons.backspace_rounded,
        color: Color(0xFFDE3434),
        size: 24,
      );
    }
    else {
      widget = Text(
        x,
        style: const TextStyle(
          fontFamily: "OpenSans",
          color: Color(0xFFECECEC),
          fontSize: 20,
        ),
      );
    }
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if(x == "backspace") {
            if(text1.isNotEmpty) {
              text1 = text1.substring(0,text1.length-1);
            }
          }
          else if(x=="C") {
            text1 = "";
          }
          else if(x==".") {
            bool flag1 = false;
            for(int i=text1.length-1;i>=0;i--) {
              if(text1[i]==".") {
                flag1 = true;
                break;
              }
            }
            if(!flag1) {
              text1 = "$text1.";
            }
          }
          else if(x=="-") {
            if(text1 == "") {
              text1 = text1 + x;
            }
          }
          else {
            text1 = text1 + x;
          }
          convert();
          setState(() {});
        },
        child: Container(
          alignment: Alignment.center,
          color: transparent,
          child: widget,
        ),
      ),
    );
  }

  @override
  initState() {
    super.initState();

    x = widget.x.toString();
    x = x[0].toUpperCase() + x.substring(1);

    if(widget.x.toString() == "time") {
      si = "s";
      units = [
        "μs",
        "s",
        "min",
        "hr",
        "day",
        "yr",
      ];
      unitsFull = [
        "micro second",
        "second",
        "minute",
        "hour",
        "",
        "year",
      ];
      cf = {
        "μs" : {
          "m" : 1000000.0,
          "a" : 0.0,
        },
        "s" : {
          "m" : 1.0,
          "a" : 0.0,
        },
        "min" : {
          "m" : (1.0/60.0),
          "a" : 0.0,
        },
        "hr" : {
          "m" : (1.0/3600.0),
          "a" : 0.0,
        },
        "day" : {
          "m" : (1.0/86400.0),
          "a" : 0.0,
        },
        "yr" : {
          "m" : 1.0/(31536000.0),
          "a" : 0.0,
        },
      };
    }
    else if(widget.x.toString() == "mass") {
      si = "kg";
      units = [
        "g",
        "kg",
        "t",
      ];
      unitsFull = [
        "gram",
        "kilogram",
        "tonne",
      ];
      cf = {
        "g" : {
          "m" : 1000.0,
          "a" : 0.0,
        },
        "kg" : {
          "m" : 1.0,
          "a" : 0.0,
        },
        "t" : {
          "m" : (1.0/1000.0),
          "a" : 0.0,
        },
      };
    }
    else if(widget.x.toString() == "temperature") {
      si = "K";
      units = [
        "K",
        "°C",
        "°F",
      ];
      unitsFull = [
        "Kelvin",
        "Celsius",
        "Fahrenheit",
      ];
      cf = {
        "K" : {
          "m" : 1.0,
          "a" : 0.0,
        },
        "°C" : {
          "m" : 1.0,
          "a" : -273.15,
        },
        "°F" : {
          "m" : 9.0/5.0,
          "a" : -459.67,
        },
      };
    }
    else if(widget.x.toString() == "length") {
      si = "m";
      units = [
        "cm",
        "m",
        "km",
        //"ft & in",
        "mi",
      ];
      unitsFull = [
        "centimeter",
        "meter",
        "kilometer",
        "foot & inch",
        "mile",
      ];
      cf = {
        "cm" : {
          "m" : 100.0,
          "a" : 0.0,
        },
        "m" : {
          "m" : 1.0,
          "a" : 0.0,
        },
        "km" : {
          "m" : 1.0/1000.0,
          "a" : 0.0,
        },
        "ft & in" : {
          "m" : 1.0,
          "a" : 0.0,
        },
        "mile" : {
          "m" : 1.0/1609.344,
          "a" : 0.0,
        },
      };
    }
    else if(widget.x.toString() == "area") {
      si = "m²";
      units = [
        "cm²",
        "m²",
        "km²",
      ];
      unitsFull = [
        "centimeter²",
        "meter²",
        "kilometer²",
      ];
      cf = {
        "cm²" : {
          "m" : 10000.0,
          "a" : 0.0,
        },
        "m²" : {
          "m" : 1.0,
          "a" : 0.0,
        },
        "km²" : {
          "m" : 1.0/1000000.0,
          "a" : 0.0,
        },
      };
    }
    else if(widget.x.toString() == "volume") {
      si = "m³";
      units = [
        "cm³",
        "m³",
        "km³",
      ];
      unitsFull = [
        "centimeter³",
        "meter³",
        "kilometer³",
      ];
      cf = {
        "cm³" : {
          "m" : 1000000.0,
          "a" : 0.0,
        },
        "m³" : {
          "m" : 1.0,
          "a" : 0.0,
        },
        "km³" : {
          "m" : 1.0/1000000000.0,
          "a" : 0.0,
        },
      };
    }
    else if(widget.x.toString() == "speed") {
      si = "m/s";
      units = [
        "m/s",
        "km/hr",
      ];
      unitsFull = [
        "meter/second",
        "kilometer/hour",
      ];
      cf = {
        "m/s" : {
          "m" : 1.0,
          "a" : 0.0,
        },
        "km/hr" : {
          "m" : 18.0/5.0,
          "a" : 0.0,
        },
      };
    }
    else if(widget.x.toString() == "data") {
      si = "B";
      units = [
        "bit",
        "B",
        "KB",
        "MB",
        "GB",
        "TB",
      ];
      unitsFull = [
        "",
        "Byte",
        "KiloByte",
        "MegaByte",
        "GigaByte",
        "TetraByte",
      ];
      cf = {
        "bit" : {
          "m" : 8.0,
          "a" : 0.0,
        },
        "B" : {
          "m" : 1.0,
          "a" : 0.0,
        },
        "KB" : {
          "m" : 1.0/1024.0,
          "a" : 0.0,
        },
        "MB" : {
          "m" : 1.0/1048576.0,
          "a" : 0.0,
        },
        "GB" : {
          "m" : 1.0/1073741824.0,
          "a" : 0.0,
        },
        "TB" : {
          "m" : 1.0/1099511627780.0,
          "a" : 0.0,
        },
      };
    }
    else {
      si = "Decimal";
      units = [
        "Decimal",
        "Roman",
      ];
      unitsFull = [
        "",
        "",
      ];
      cf = {
        "Decimal" : {
          "m" : 1.0,
          "a" : 0.0,
        },
        "Roman" : {
          "m" : 1.0,
          "a" : 0.0,
        },
      };
    }
    unit1 = si;
    unit2 = si;
  }

  @override
  Widget build(BuildContext context) {

    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: black_1,
      appBar: appBarGeneral(context, x),
      body: Container(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          reverse: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.bottomRight,
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                            child: Text(
                              text1,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: white_1,
                                fontFamily: "OpenSans",
                                fontSize: 20,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 13),
                          color: white_1,
                          width: 0.5,
                          height: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        PopupMenuButton(
                          color: black_2,
                          elevation: 10,
                          offset: const Offset(0.0, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          onSelected: (value) {
                            unit1 = units[int.parse(value.toString())];
                            convert();
                            setState((){ });
                          },
                          itemBuilder: (ctx) => [
                            for(int i=0;i<units.length;i++)
                              PopupMenuItem(
                                value: i,
                                child: Row(
                                  children: [
                                    Text(
                                      units[i],
                                      style: const TextStyle(
                                        color: white_1,
                                        fontFamily: "OpenSans",
                                        fontSize: 15,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      (unitsFull[i] == "") ? "" : " (${unitsFull[i]})",
                                      style: const TextStyle(
                                        color: white_1,
                                        fontFamily: "OpenSans",
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              //color: Color(0xFF802424),
                              color: transparent,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  unit1,
                                  style: const TextStyle(
                                    color: white_1,
                                    fontFamily: "OpenSans",
                                    fontSize: 20,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: white_1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.bottomRight,
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                            child: Text(
                              text2,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: white_1,
                                fontFamily: "OpenSans",
                                fontSize: 20,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        PopupMenuButton(
                          color: black_2,
                          elevation: 10,
                          offset: const Offset(0.0, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          onSelected: (value) {
                            unit2 = units[int.parse(value.toString())];
                            convert();
                            setState((){ });
                          },
                          itemBuilder: (ctx) => [
                            for(int i=0;i<units.length;i++)
                              PopupMenuItem(
                                value: i,
                                child: Row(
                                  children: [
                                    Text(
                                      units[i],
                                      style: const TextStyle(
                                        color: white_1,
                                        fontFamily: "OpenSans",
                                        fontSize: 15,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      (unitsFull[i] == "") ? "" : " (${unitsFull[i]})",
                                      style: const TextStyle(
                                        color: white_1,
                                        fontFamily: "OpenSans",
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: transparent,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  unit2,
                                  style: const TextStyle(
                                    color: white_1,
                                    fontFamily: "OpenSans",
                                    fontSize: 20,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_drop_down_rounded,
                                  color: white_1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                height: 260,
                color: black_2,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          button("7"),
                          button("4"),
                          button("1"),
                          button("0"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          button("8"),
                          button("5"),
                          button("2"),
                          button("."),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          button("9"),
                          button("6"),
                          button("3"),
                          button("backspace"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          button("C"),
                          if(widget.x.toString() == "temperature") button("-"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}