import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wear_os_connectivity/flutter_wear_os_connectivity.dart';
import 'package:smartlinxwearos/pages/homePage/homepage.dart';
import 'package:smartlinxwearos/services/connectionHandler.dart';
import 'package:smartlinxwearos/services/send.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void startListen() async {
    FlutterWearOsConnectivity flutterWearOsConnectivity =
    FlutterWearOsConnectivity();
    flutterWearOsConnectivity.configureWearableAPI();
    flutterWearOsConnectivity.messageReceived().listen((message) {
      ConnectionHandler().handleMessage(message);
      flutterWearOsConnectivity.dispose();
      redirectToHomePage();
    });
    Send().getStatus(flutterWearOsConnectivity);
  }

  void redirectToHomePage(){
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) =>
        const HomePage(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startListen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Row(
              children: [
                const Spacer(),
                Text(
                  'Smart',
                  style: TextStyle(
                    fontFamily: Theme.of(context).textTheme.displayLarge!.fontFamily,
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 45.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 1.w,
                ),
                Text(
                  'Linx',
                  style: TextStyle(
                    fontFamily: Theme.of(context).textTheme.displayLarge!.fontFamily,
                    color: Theme.of(context).textTheme.displayLarge!.color,
                    fontSize: 45.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 1.5,
            right: MediaQuery.of(context).size.width / 2.45,
            child: Transform.scale(
              scale: 0.6,
              child: const CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
