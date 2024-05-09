import 'dart:convert';
import 'dart:developer';
import 'package:flutter_wear_os_connectivity/flutter_wear_os_connectivity.dart';
import 'package:smartlinxwearos/services/local_storage.dart';
import 'package:smartlinxwearos/services/object/light.dart';
import 'package:smartlinxwearos/services/object/thermometer.dart';
import 'object/plug.dart';

class ConnectionHandler {
  void startListen() async {
    FlutterWearOsConnectivity flutterWearOsConnectivity =
        FlutterWearOsConnectivity();
    flutterWearOsConnectivity.configureWearableAPI();
    flutterWearOsConnectivity.messageReceived().listen((message) {
      handleMessage(message);
    });
  }

  void handleMessage(dynamic receivedMessage) {
    WearOSMessage message = receivedMessage;
    String parsedMessage = const Utf8Decoder().convert(message.data);
    parseMessage(parsedMessage);
  }

  void parseMessage(String jsonMessage) {
    List<Light> lights = [];
    List<Plug> plugs = [];
    List<Thermometer> thermometers = [];
    Map<String, dynamic> jsonData = jsonDecode(jsonMessage);
    List<dynamic> jsonLights = jsonData['lights'];
    List<dynamic> jsonPlugs = jsonData['plugs'];
    List<dynamic> jsonThermometers = jsonData['thermometers'];
    for (var data in jsonLights) {
      int deviceID = data['deviceID'];
      String name = data['name'];
      bool state = data['state'] as bool;
      bool isOnline = data['isOnline'] as bool;
      lights.add(Light(deviceID, name, state, isOnline));
    }
    for (var data in jsonPlugs) {
      int deviceID = data['deviceID'];
      String name = data['name'];
      bool state = data['state'] as bool;
      bool isOnline = data['isOnline'] as bool;
      plugs.add(Plug(deviceID, name, state, isOnline));
    }
    for (var data in jsonThermometers) {
      int deviceID = data['deviceID'];
      String name = data['name'];
      double temperature = data['temperature'] as double;
      double humidity = data['humidity'] as double;
      bool isOnline = data['isOnline'] as bool;
      thermometers.add(Thermometer(deviceID, name, temperature, humidity, isOnline));
    }
    LocalStorage.instance.setLights(lights);
    LocalStorage.instance.setPlugs(plugs);
    LocalStorage.instance.setThermometers(thermometers);
    printLog(lights, plugs, thermometers);
  }

  void printLog(
      List<Light> lights, List<Plug> plugs, List<Thermometer> thermometers) {
    for (int i = 0; i < lights.length; i++) {
      log('\n${lights[i]}');
    }
    for (int i = 0; i < plugs.length; i++) {
      log('\n${plugs[i]}');
    }
    for (int i = 0; i < thermometers.length; i++) {
      log('\n${thermometers[i]}');
    }
  }
}
