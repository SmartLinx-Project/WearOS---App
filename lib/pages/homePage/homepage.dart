import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_wear_os_connectivity/flutter_wear_os_connectivity.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:smartlinxwearos/pages/homePage/widget/light_box.dart';
import 'package:smartlinxwearos/pages/homePage/widget/plug_box.dart';
import 'package:smartlinxwearos/pages/homePage/widget/thermometer_box.dart';
import 'package:smartlinxwearos/services/local_storage.dart';
import 'package:smartlinxwearos/services/object/thermometer.dart';
import 'package:smartlinxwearos/services/send.dart';
import '../../services/connectionHandler.dart';
import '../../services/object/light.dart';
import '../../services/object/plug.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterWearOsConnectivity flutterWearOsConnectivity =
      FlutterWearOsConnectivity();
  List<Widget> boxes = [];

  void sendMessage(int deviceID, bool state, String type) {
    showLoadingDialog();
    if (state) {
      Send().turnOn(deviceID, flutterWearOsConnectivity, type);
    } else {
      Send().turnOff(deviceID, flutterWearOsConnectivity, type);
    }
  }

  void fetchWidget() {
    List<Light> lights = LocalStorage.instance.getLights();
    List<Plug> plugs = LocalStorage.instance.getPlugs();
    List<Thermometer> thermometers = LocalStorage.instance.getThermometers();

    boxes.clear();

    for (int i = 0; i < lights.length; i++) {
      boxes.add(LightBox(
        device: lights[i],
        sendMessage: sendMessage,
      ));
      boxes.add(
        SizedBox(
          height: 15.h,
        ),
      );
    }
    for (int i = 0; i < plugs.length; i++) {
      boxes.add(PlugBox(
        device: plugs[i],
        sendMessage: sendMessage,
      ));
      boxes.add(
        SizedBox(
          height: 15.h,
        ),
      );
    }
    for (int i = 0; i < thermometers.length; i++) {
      boxes.add(ThermometerBox(device: thermometers[i]));
      boxes.add(
        SizedBox(
          height: 15.h,
        ),
      );
    }
    setState(() {});
  }

  void startListen() async {
    flutterWearOsConnectivity.messageReceived().listen((message) {
      ConnectionHandler().handleMessage(message);
      changeState();
    });
  }

  void changeState() {
    hideLoadingDialog();
    fetchWidget();
    setState(() {});
  }

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        );
      },
    );
  }

  void hideLoadingDialog() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  void initState() {
    super.initState();
    fetchWidget();
    flutterWearOsConnectivity.configureWearableAPI();
    startListen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Center(
              child: (boxes.isNotEmpty)
                  ? LiquidPullToRefresh(
                height: 100.h,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 12,
                          ),
                          Text(
                            'Preferiti',
                            style: TextStyle(
                              fontFamily: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .fontFamily,
                              color:
                                  Theme.of(context).textTheme.displayLarge!.color,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 20,
                          ),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: boxes.length,
                              itemBuilder: (context, index) {
                                return boxes[index];
                              },
                            ),
                          ),
                        ],
                      ),
                      onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 2));
                        Send().getStatus(flutterWearOsConnectivity);
                      })
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Nessun dispositivo\npreferito',
                          style: TextStyle(
                            fontFamily: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .fontFamily,
                            color:
                                Theme.of(context).textTheme.displayMedium!.color,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        IconButton(
                            onPressed: () {
                              Send().getStatus(flutterWearOsConnectivity);
                            },
                            icon: const Icon(Icons.refresh)),
                      ],
                    )),
        ));
  }

  @override
  void dispose() {
    flutterWearOsConnectivity.dispose();
    super.dispose();
  }
}
