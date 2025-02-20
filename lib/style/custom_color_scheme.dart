import 'package:flutter/material.dart';

MaterialColor bOneColor = const MaterialColor(
  0xFFF58220, // Orange color from VITO
  const <int, Color>{
    50: const Color.fromRGBO(245, 130, 32, .1),
    100: const Color.fromRGBO(245, 130, 32, .2),
    200: const Color.fromRGBO(245, 130, 32, .3),
    300: const Color.fromRGBO(245, 130, 32, .4),
    400: const Color.fromRGBO(245, 130, 32, .5),
    500: const Color.fromRGBO(245, 130, 32, .6),
    600: const Color.fromRGBO(245, 130, 32, .7),
    700: const Color.fromRGBO(245, 130, 32, .8),
    800: const Color.fromRGBO(245, 130, 32, .9),
    900: const Color.fromRGBO(245, 130, 32, 1),
  },
);

MaterialColor bOneVitoColor = const MaterialColor(
  0xFF81bb26, // Green color from VITO
  const <int, Color>{
    50: const Color.fromRGBO(129, 187, 38, .1),
    100: const Color.fromRGBO(129, 187, 38, .2),
    200: const Color.fromRGBO(129, 187, 38, .3),
    300: const Color.fromRGBO(129, 187, 38, .4),
    400: const Color.fromRGBO(129, 187, 38, .5),
    500: const Color.fromRGBO(129, 187, 38, .6),
    600: const Color.fromRGBO(129, 187, 38, .7),
    700: const Color.fromRGBO(129, 187, 38, .8),
    800: const Color.fromRGBO(129, 187, 38, .9),
    900: const Color.fromRGBO(129, 187, 38, 1),
  },
);

const bOneErrorRed = Color(0xFFC5032B);
const bOneBackgroundWhite = Color(0xFFF0F0F0);
const bOneCMT = Color(0xFFF88604);

const bOneAccentBlue = Color(0xFF33A3DC); // Blue color from VITO
const bOneAccent = Color(0xFF9EA0A9); // Gray color
const bOneVitoAccent = Color(0xFF323031); // Gray color from vito

final ThemeData bOneTheme = _buildBOneTheme();

ThemeData _buildBOneTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      accentColor: bOneVitoAccent,
      // primaryColor: bOneVitoColor,
      primaryColor: bOneVitoColor,
      canvasColor: Colors.transparent,
      buttonTheme: base.buttonTheme.copyWith(
        // buttonColor: bOneVitoColor.shade100,
        buttonColor: bOneVitoColor,
        colorScheme: base.colorScheme.copyWith(
          secondary: bOneVitoColor.shade900,
        ),
        textTheme: ButtonTextTheme.accent,
      ),
      buttonBarTheme: base.buttonBarTheme.copyWith(
        buttonTextTheme: ButtonTextTheme.accent,
      ),
      buttonColor: bOneVitoColor,
      scaffoldBackgroundColor: bOneBackgroundWhite,
      // textSelectionColor: bOneVitoColor.shade100,
      errorColor: bOneErrorRed,
      textTheme: _buildBOneTextTheme(base.textTheme),
      primaryTextTheme: _buildBOneTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildBOneTextTheme(base.accentTextTheme),
      primaryColorLight: bOneVitoColor.shade200,
      indicatorColor: bOneCMT,
      primaryIconTheme: IconThemeData(color: bOneVitoAccent),
      iconTheme: IconThemeData(color: bOneVitoAccent),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: bOneVitoAccent,
      ));
}

TextTheme _buildBOneTextTheme(TextTheme base) {
  return base
      .copyWith(
          bodyText2: base.bodyText2.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            color: bOneVitoAccent,
          ),
          headline2: base.headline2.copyWith(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            color: bOneVitoColor.shade900,
          ),
          headline5: base.headline5.copyWith(
            fontWeight: FontWeight.w500,
            decorationColor: Colors.black,
            color: Colors.black,
          ),
          headline6: base.headline6.copyWith(fontSize: 18.0),
          caption: base.caption.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
          ),
          bodyText1: base.bodyText1.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
          button: base.button.copyWith(
            fontFamily: 'Poppins-SemiBold',
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ))
      .apply(
          // fontFamily: 'Poppins',
          // displayColor: bOneVitoColor.shade900,
          // bodyColor: bOneVitoColor.shade900,
          );
}
