import 'package:cancer_segmentation/Screens/MainScreen/main_screen.dart';
import 'package:flutter/material.dart';
import 'Screens/login/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ThemeData appTheme = ThemeData.light().copyWith(: );
    // #34495e
    Map<int, Color> color = {
      50: Color.fromRGBO(102, 102, 255, .1),
      100: Color.fromRGBO(102, 102, 255, .2),
      200: Color.fromRGBO(102, 102, 255, .3),
      300: Color.fromRGBO(102, 102, 255, .4),
      400: Color.fromRGBO(102, 102, 255, .5),
      500: Color.fromRGBO(102, 102, 255, .6),
      600: Color.fromRGBO(102, 102, 255, .7),
      700: Color.fromRGBO(102, 102, 255, .8),
      800: Color.fromRGBO(102, 102, 255, .9),
      900: Color.fromRGBO(102, 102, 255, 1),
    };
    ThemeData appTheme =
        ThemeData(primarySwatch: MaterialColor(0xff6666ff, color));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        title: 'Iha Health',
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          '/main': (context) => MainScreen(),
        });
  }
}
