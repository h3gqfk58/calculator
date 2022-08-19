import 'dart:math';
import 'package:calculator/helpers/colors.dart';
import 'package:calculator/views/converter.dart';
import 'package:calculator/views/settings.dart';
import 'package:calculator/views/about.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double deviceWidth = 0.0, deviceHeight = 0.0;
  List list_1 = [], list_2 = [], list_3 = [];
  bool expandFlag = false;

  String elementType(String x) {
    String r = "";

    if(double.tryParse(x) != null) {
      r = "number";
    }
    else if( (x=="÷") || (x=="×") || (x=="-") || (x=="+") || (x=="^") ) {
      r = "operator";
    }
    else if( (x=="sin") || (x=="cos") || (x=="tan") || (x=="sin⁻¹") || (x=="cos⁻¹") || (x=="tan⁻¹") || (x=="√") || (x=="ln") || (x=="log") ) {
      r = "function";
    }
    else if( (x=="e") || (x=="π") || (x=="°") ) {
      r = "constant";
    }
    else if( (x=="(") || (x==")") ) {
      r = "bracket";
    }

    return r;
  }

  List operate(String operator, List list) {
    for(int i=1;i<list.length-1;) {
      if(list[i] == operator) {
        list[i-1] =
        (operator == "^") ? pow(list[i-1].toDouble(), list[i+1].toDouble()) :
        (operator == "÷") ? list[i-1].toDouble() / list[i+1].toDouble() :
        (operator == "×") ? list[i-1].toDouble() * list[i+1].toDouble() :
        (operator == "+") ? list[i-1].toDouble() + list[i+1].toDouble() :
        (operator == "-") ? list[i-1].toDouble() - list[i+1].toDouble() :
        0.0;
        list.removeAt(i);
        list.removeAt(i);
      }
      else {
        i++;
      }
    }
    return list;
  }

  double calculate(List list) {
    int countOpenBracket = 0, countCloseBracket = 0, p = 0;

    for(int i=0;i<list.length;i++) {
      if(list[i] == "(") {
        countOpenBracket++;
        if(countOpenBracket == 1) {
          p = i;
        }
      }
      else if( (countOpenBracket > 0) && (list[i] == ")") ) {
        countCloseBracket++;
        if(countOpenBracket == countCloseBracket) {
          list.insert(p, calculate(list.sublist(p+1,i)));
          list.removeRange(p+1, i+2);
          countOpenBracket = 0;
          countCloseBracket = 0;
          i = p;
        }
      }
    }

    for(int i=list.length-1;i>=0;i--) {
      if(list[i].runtimeType == String) {
        if(elementType(list[i]) == "function") {
          if(list[i] == "sin") {
            list[i] = sin(list[i+1]).toDouble();
          }
          else if(list[i] == "cos") {
            list[i] = cos(list[i+1]).toDouble();
          }
          else if(list[i] == "tan") {
            list[i] = tan(list[i+1]).toDouble();
          }
          else if(list[i] == "sin⁻¹") {
            list[i] = asin(list[i+1]).toDouble();
          }
          else if(list[i] == "cos⁻¹") {
            list[i] = acos(list[i+1]).toDouble();
          }
          else if(list[i] == "tan⁻¹") {
            list[i] = atan(list[i+1]).toDouble();
          }
          else if(list[i] == "√") {
            list[i] = sqrt(list[i+1]).toDouble();
          }
          else if(list[i] == "ln") {
            list[i] = log(list[i+1]).toDouble();
          }
          else if(list[i] == "log") {
            list[i] = log(list[i+1]).toDouble() / log(10.0).toDouble();
          }

          if( (list[i] > 0) && (list[i] < pow(10.0,-15.0).toDouble()) ) {
            list[i] = 0.0;
          }
          else if( (list[i] < 0) && (list[i] > -pow(10.0,-15.0).toDouble()) ) {
            list[i] = 0.0;
          }
          list.removeAt(i+1);
        }
      }
    }

    for(int i=0;i<list.length-1;i++) {
      if( (list[i].runtimeType == double) && (list[i+1].runtimeType == double) ) {
        list.insert(i+1, "×");
      }
    }

    if(list.length >= 2) {
      if( (list[0] == "+") || (list[0] == "-") ) {
        if(list[1].runtimeType == double) {
          list[0] = double.parse(list[0].toString() + list[1].toString());
          list.removeAt(1);
        }
      }
    }

    list = operate("^", list);
    list = operate("÷", list);
    list = operate("×", list);
    list = operate("+", list);
    list = operate("-", list);

    if(list[0].runtimeType == String) {
      list.removeAt(0);
    }

    return list[0];
  }

  compute() {
    double answer = 0.0;
    int pre = 0;

    pre = 0;
    list_3 = [];
    for(int i=0;i<list_1.length;i++) {
      if( (elementType(list_1[i]) == "operator") || (elementType(list_1[i]) == "bracket") || (elementType(list_1[i]) == "constant") || (elementType(list_1[i]) == "function") ) {
        if(pre<i) {
          if(list_1.sublist(pre,i).join().toString() == ".") {
            list_3.add(0.0);
          }
          else {
            list_3.add(double.parse(list_1.sublist(pre,i).join()));
          }
        }
        list_3.add(list_1[i]);
        pre = i+1;
      }
    }
    if(pre < list_1.length) {
      if(list_1.sublist(pre,list_1.length).join().toString() == ".") {
        list_3.add(0.0);
      }
      else {
        list_3.add(double.parse(list_1.sublist(pre,list_1.length).join()));
      }
    }

    for(int i=0;i<list_3.length;i++) {
      if(list_3[i] == "e") {
        list_3[i] = e.toDouble();
      }
      else if(list_3[i] == "π") {
        list_3[i] = pi.toDouble();
      }
      else if(list_3[i] == "°") {
        list_3[i] = (pi/180.0).toDouble();
      }
    }

    answer = double.parse(calculate(list_3).toStringAsPrecision(12));

    if(answer.isInfinite) {
      list_1 = [answer.toString()];
    }
    else if(answer == answer.round()) {
      list_1 = [answer.round().toString()];
    }
    else {
      list_1 = [answer.toString()];
    }
  }

  Widget button(String x) {
    Widget widget = Container();
    if( (elementType(x) == "number") || (x==".") ) {
      widget = Text(
        x,
        style: const TextStyle(
          fontFamily: "OpenSans",
          color: Color(0xFFECECEC),
          fontSize: 20,
        ),
      );
    }
    else if(elementType(x) == "operator") {
      widget = Text(
        x,
        style: const TextStyle(
          fontFamily: "OpenSans",
          color: Colors.teal,
          fontSize: 28,
          fontWeight: FontWeight.w500,
        ),
      );
    }
    else if(x=="=") {
      widget = Text(
        x,
        style: const TextStyle(
          fontFamily: "OpenSans",
          color: Colors.lightGreenAccent,
          fontSize: 28,
        ),
      );
    }
    else if(x=="C") {
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
    else if(x=="expand") {
      widget = Icon(
        (expandFlag) ? Icons.close_rounded : Icons.unfold_more,
        color: const Color(0xFFCE9338),
        size: 24,
      );
    }
    else if( (x == "sin⁻¹") || (x == "cos⁻¹") || (x == "tan⁻¹") ) {
      widget = RichText(
        textAlign: TextAlign.right,
        text: TextSpan(
            children: [
              WidgetSpan(
                child: Text(
                  x.substring(0,3),
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Color(0xFFECECEC),
                    fontSize: 16,
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w300,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              const WidgetSpan(
                child: SizedBox(
                  width: 0.5,
                ),
              ),
              WidgetSpan(
                child: Transform.translate(
                  offset: const Offset(0, -8),
                  child: const Text(
                    "-1",
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 9,
                      fontFamily: "OpenSans",
                      letterSpacing: 0.2,
                      color: Color(0xFFECECEC),
                    ),
                  ),
                ),
              ),
            ]
        ),
      );
    }
    else {
      widget = Text(
        x,
        style: const TextStyle(
          color: Color(0xFFECECEC),
          fontSize: 16,
          fontFamily: "OpenSans",
          fontWeight: FontWeight.w300,
          letterSpacing: 0.2,
        ),
      );
    }

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if( (elementType(x) == "number") ) {
            list_1.add(x);
          }
          else if(elementType(x) == "operator") {
            if(list_1.isEmpty) {
              if( (x == "+") || (x == "-") ) {
                list_1.add(x);
              }
            }
            else if(list_1.length == 1) {
              if(elementType(list_1[0]) == "operator") {
                if( (x=="+") || (x=="-") ) {
                  list_1.removeLast();
                  list_1.add(x);
                }
              }
              else {
                list_1.add(x);
              }
            }
            else {
              if(elementType(list_1[list_1.length-1]) == "operator") {
                list_1.removeLast();
                list_1.add(x);
              }
              else {
                list_1.add(x);
              }
            }
          }
          else if(x == "backspace") {
            if(list_1.isNotEmpty) {
              list_1.removeLast();
            }
          }
          else if(x=="C") {
            list_1 = [];
          }
          else if(x==".") {
            bool flag1=false;
            for(int i=list_1.length-1;i>=0;i--) {
              if(elementType(list_1[i]) == "operator") {
                list_1.add(x);
                flag1 = true;
                break;
              }
              else if(list_1[i]==".") {
                flag1 = true;
                break;
              }
            }
            if(flag1 == false) {
              list_1.add(x);
              flag1 = true;
            }
          }
          else if(x=="=") {
            if(list_1.isNotEmpty) {
              try {
                compute();
              }
              catch(error) {
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
            }
          }
          else if(x == "expand") {
            (expandFlag) ? expandFlag = false : expandFlag = true;
          }
          else if(elementType(x) == "function") {
            list_1.add(x);
            list_1.add("(");
          }
          else {
            list_1.add(x);
          }
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

  WidgetSpan displayElement(String element) {
    WidgetSpan widgetSpan = WidgetSpan(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2.5),
        child: Text(
          element,
          textAlign: TextAlign.right,
          style: const TextStyle(
            fontSize: 25,
            fontFamily: "OpenSans",
            letterSpacing: 0.6,
            color: white_1,
          ),
        ),
      ),
    );
    if( (element == "sin⁻¹") || (element == "cos⁻¹") || (element == "tan⁻¹") ) {
      widgetSpan = WidgetSpan(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 2.5),
          child: RichText(
            textAlign: TextAlign.right,
            text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Text(
                      element.substring(0,3),
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 25,
                        fontFamily: "OpenSans",
                        letterSpacing: 0.6,
                        color: white_1,
                      ),
                    ),
                  ),
                  const WidgetSpan(
                      child: SizedBox(
                        width: 1,
                      ),
                  ),
                  WidgetSpan(
                    child: Transform.translate(
                      offset: const Offset(0, -10),
                      child: const Text(
                        "-1",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "OpenSans",
                          letterSpacing: 0.2,
                          color: white_1,
                        ),
                      ),
                    ),
                  ),
                ]
            ),
          ),
        ),
      );
    }

    return widgetSpan;
  }

  Widget display() {
    int pre = 0;

    pre = 0;
    list_2 = [];
    for(int i=0;i<list_1.length;i++) {
      if( (elementType(list_1[i]) == "operator") || (elementType(list_1[i]) == "bracket") || (elementType(list_1[i]) == "constant") || (elementType(list_1[i]) == "function") ) {
        if(pre < i) {
          list_2.add(list_1.sublist(pre,i).join());
        }
        list_2.add(list_1[i]);
        pre = i+1;
      }
    }
    if(pre < list_1.length) {
      list_2.add(list_1.sublist(pre,list_1.length).join());
    }

    return RichText(
      textAlign: TextAlign.right,
      text: TextSpan(
          children: [
            for(int i=0;i<list_2.length;i++) displayElement(list_2[i]),
          ]
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
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: transparent,
        toolbarHeight: 75,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(child: SizedBox(),),
            PopupMenuButton(
              color: black_2,
              elevation: 10,
              offset: const Offset(0.0, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              onSelected: (x) {
                SystemChrome.setSystemUIOverlayStyle(
                  SystemUiOverlayStyle.light.copyWith(
                    systemNavigationBarColor: black_1,
                  ),
                );
                if(x == 1) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Converter())).then((value) => SystemChrome.setSystemUIOverlayStyle(
                    SystemUiOverlayStyle.light.copyWith(
                      systemNavigationBarColor: black_2,
                    ),
                  ));
                }
                else if(x == 2) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Settings())).then((value) => SystemChrome.setSystemUIOverlayStyle(
                    SystemUiOverlayStyle.light.copyWith(
                      systemNavigationBarColor: black_2,
                    ),
                  ));
                }
                else if(x == 3) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const About())).then((value) => SystemChrome.setSystemUIOverlayStyle(
                    SystemUiOverlayStyle.light.copyWith(
                      systemNavigationBarColor: black_2,
                    ),
                  ));
                }
              },
              itemBuilder: (ctx) => [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.cached_rounded,
                        color: white_1,
                        size: 20,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Converter",
                        style: TextStyle(
                          color: white_1,
                          fontFamily: "OpenSans",
                          fontSize: 14,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.settings_rounded,
                        color: white_1,
                        size: 20,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Settings",
                        style: TextStyle(
                          color: white_1,
                          fontFamily: "OpenSans",
                          fontSize: 14,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 3,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.info_rounded,
                        color: white_1,
                        size: 20,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "About",
                        style: TextStyle(
                          color: white_1,
                          fontFamily: "OpenSans",
                          fontSize: 14,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: const BoxDecoration(
                  color: transparent,
                ),
                child: const Icon(
                  Icons.menu_rounded,
                  color: white_1,
                ),
              ),
            ),
          ],
        ),
        elevation: 0,
        titleSpacing: 20,
      ),
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
                color: black_1,
                //color: const Color(0xFF118477),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomRight,
                        padding: const EdgeInsets.symmetric(horizontal: 9.5),
                        child: display(),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 2),
                      height: 28,
                      width: 0.5,
                      color: white_1,
                    )
                  ],
                ),
              ),
              if(expandFlag) Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                height: 128,
                color: black_2,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          button("√"),
                          button("sin"),
                          button("sin⁻¹"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          button("ln"),
                          button("cos"),
                          button("cos⁻¹"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          button("log"),
                          button("tan"),
                          button("tan⁻¹"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          button("e"),
                          button("°"),
                          button("("),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          button("!"),
                          button("π"),
                          button(")"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: (expandFlag) ? const EdgeInsets.only(right: 20, left: 20, top: 17, bottom: 20) : const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                height: (expandFlag) ? 237 : 260,
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
                          button("×"),
                          button("+"),
                          button("^"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          button("expand"),
                          button("÷"),
                          button("-"),
                          button("="),
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