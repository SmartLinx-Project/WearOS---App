import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_wear_os_connectivity/flutter_wear_os_connectivity.dart';

class Send{
  void turnOn(int deviceID, FlutterWearOsConnectivity flutterWearOsConnectivity, String type) async{
    List<WearOsDevice> connectedDevices = await flutterWearOsConnectivity.getConnectedDevices();
    if (connectedDevices.isNotEmpty) {
      String message = '{"command":"setState", "deviceID": "$deviceID", "value": "on", "type": "$type"}';
      sendMessage(flutterWearOsConnectivity, connectedDevices[0], message);
    }
  }

  void turnOff(int deviceID, FlutterWearOsConnectivity flutterWearOsConnectivity, String type) async{
    List<WearOsDevice> connectedDevices = await flutterWearOsConnectivity.getConnectedDevices();
    if (connectedDevices.isNotEmpty) {
      String message = '{"command":"setState", "deviceID": "$deviceID", "value": "off", "type": "$type"}';
      sendMessage(flutterWearOsConnectivity, connectedDevices[0], message);
    }
  }

  void getStatus(FlutterWearOsConnectivity flutterWearOsConnectivity) async{
    List<WearOsDevice> connectedDevices = await flutterWearOsConnectivity.getConnectedDevices();
    if (connectedDevices.isNotEmpty) {
      String message = '{"command":"getState"}';
      sendMessage(flutterWearOsConnectivity, connectedDevices[0], message);
    }
  }

  void sendMessage(FlutterWearOsConnectivity flutterWearOsConnectivity, WearOsDevice pairedDevice, String message) async {
    String path = '/setState';
    Uint8List messageBytes = Uint8List.fromList(utf8.encode(message));

    await flutterWearOsConnectivity.sendMessage(
      messageBytes,
      deviceId: pairedDevice.id,
      path: path,
    ).then((requestId) {
      print('Messaggio inviato con successo con requestId: $requestId');
    }).catchError((error) {
      print('Errore durante l\'invio del messaggio: $error');
    });
  }

}