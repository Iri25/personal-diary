import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Palette {
  static const MaterialColor kToDark = MaterialColor(
    0xff7b3838,
    <int, Color>{
      50: Color(0xff9A7C7C),//10%
      100: Color(0xff8C6262),//20%
      200: Color(0xffE9967A),//30%
      300: Color(0xffCD5C5C),//40%
      400: Color(0xff702828),//50%
      500: Color(0xff5c261d),//60% --> floatingActionButton
      600: Color(0xff451c16),//70%
      700: Color(0xff2e130e),//80% --> floatingActionButton
      800: Color(0xff170907),//90%
      900: Color(0xff000000),//100%
    },
  );
}
