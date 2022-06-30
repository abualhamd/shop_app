import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/shared/constants.dart';

class CacheHelper{
  static late SharedPreferences _cacheHelper;
  static Future init() async{
    _cacheHelper = await SharedPreferences.getInstance();
  }

  //TODO make it setOnBoarding
  static Future<bool> setBool({required String key, required bool value}){
    return _cacheHelper.setBool(key, value);
  }

  static Future<bool> setToken({required String value}){
    return _cacheHelper.setString(token, value);
  }

  static dynamic getData({required String key}){
    return _cacheHelper.get(key);
  }

}