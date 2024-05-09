import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartlinxwearos/pages/splashScreen/splashscreen.dart';
import 'package:smartlinxwearos/services/connectionHandler.dart';
import 'package:smartlinxwearos/theme/theme.dart';

void main() {
  runApp(const MyApp());
  ConnectionHandler().startListen();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartLinx',
      theme: darkTheme,
      home: ScreenUtilInit(
        designSize: const Size(384, 384),
        builder: (BuildContext context, Widget? child) {
          return const SplashScreen();
        },
      ),
    );
  }
}
