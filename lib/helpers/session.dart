// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

class SessionStorage {
  static Storage sessionStorage = window.localStorage;

  static void saveValue(String key, String value){
    sessionStorage[key] = value;
  }

  static String? getValue(String key){
    return sessionStorage[key];
  }

  static void removeValue (String key){
    sessionStorage.remove(key);
  }

}