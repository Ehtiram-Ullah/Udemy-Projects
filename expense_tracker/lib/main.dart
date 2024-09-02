import 'package:expense_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
// flutter services
// import 'package:flutter/services.dart';

// $ This color indicates that I am introduced to a new thing.

// $ ColorScheme.fromSeed
// ColorScheme.fromSeed automatically create a color scheme with different shades of colors based on one base color.
ColorScheme kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));

//Dark color scheme

ColorScheme kDarkColorScheme = ColorScheme.fromSeed(
    // $ brighness
    //We have to tell the ColorScheme.fromSeed to use the color variants for a dark mode by adding the brightness parameter.
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 5, 99, 125));

void main() {
  // // @ This ensure that's locking the phone orientation and then running the app will work
  // WidgetsFlutterBinding.ensureInitialized();

  // $ SystemChrome.setPreferredOrientations()
  // Set screen preferredOrientations
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  // .then((fn) {
  /////// @ The app runs only when the Orientation will set
  runApp(const MainApp());
  // });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // $ .copyWith
      //Using copyWith with ThemeData, it gonna change only the specific theme which we want to change
      //This theme will be apply to all widgets in the app
      theme: ThemeData().copyWith(
          colorScheme: kColorScheme,
          //appBar theme
          appBarTheme: AppBarTheme(
              backgroundColor: kColorScheme.onPrimaryContainer,
              foregroundColor: kColorScheme.primaryContainer),
          //card theme
          cardTheme: CardTheme(
              color: kColorScheme.secondaryContainer,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),

          // $ .styleFrom
          // This will copy the pre theme of ElvatedButton provided by flutter and let us change some specific styles
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kColorScheme.primaryContainer)),
          textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 15))),

      // Dark theme
      darkTheme: ThemeData.dark().copyWith(
          colorScheme: kDarkColorScheme,
          //card theme
          cardTheme: CardTheme(
              color: kDarkColorScheme.secondaryContainer,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
          //elvated button theme
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: kDarkColorScheme.primaryContainer,
                  foregroundColor: kDarkColorScheme.onPrimaryContainer)),
          textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kDarkColorScheme.onSecondaryContainer,
                  fontSize: 15))),

      //Theme mode
      // $ this is default
      // themeMode: ThemeMode.system, // default

      home: const Scaffold(body: HomeScreen()),
    );
  }
}
