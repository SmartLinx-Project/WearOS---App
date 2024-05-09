import 'package:smartlinxwearos/services/object/thermometer.dart';
import 'object/light.dart';
import 'object/plug.dart';

class LocalStorage {

  List<Light> lights = [];
  List<Plug> plugs = [];
  List<Thermometer> thermometers = [];

  static final LocalStorage _instance = LocalStorage._internal();

  LocalStorage._internal();

  factory LocalStorage() {
    return _instance;
  }

  static LocalStorage get instance => _instance;

  void setLights(List<Light> newList){
    lights = newList;
  }

  void setPlugs(List<Plug> newList){
    plugs = newList;
  }

  void setThermometers(List<Thermometer> newList){
    thermometers = newList;
  }

  List<Light> getLights(){
    return lights;
  }

  List<Plug> getPlugs(){
    return plugs;
  }

  List<Thermometer> getThermometers(){
    return thermometers;
  }

}
