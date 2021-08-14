import 'package:electronic_e_commerce/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefController{
  User user = User();
  static SharedPrefController instance = SharedPrefController._();
  late SharedPreferences _sharedPreferences;
  SharedPrefController._();

  factory SharedPrefController(){
    return instance;
  }

  Future<void> initSharePre() async{
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> savecode(int code) async {
    await _sharedPreferences.setInt('code',code);

  }
  Future<void> save(User user) async {
    await _sharedPreferences.setBool('logged_in', true);
    await _sharedPreferences.setInt('id', user.id);
    await _sharedPreferences.setString('name', user.name);
    await _sharedPreferences.setString('token', user.token);
    await _sharedPreferences.setString('mobile', user.mobile);
    await _sharedPreferences.setString('gender', user.gender);
    await _sharedPreferences.setBool('active', user.active);
    await _sharedPreferences.setInt('cityId', user.cityId);
    await _sharedPreferences.setInt('storeId', user.storeId);
  }
  //
  //
  User getUser () {
    user.id = _sharedPreferences.getInt('id')??0;
    user.name = _sharedPreferences.getString('name')??'';
    user.email = _sharedPreferences.getString('email')??'';
    user.mobile = _sharedPreferences.getString('mobile')??'';
    user.gender = _sharedPreferences.getString('gender')??'';
    user.cityId = _sharedPreferences.getInt('cityId')??0;
    return user;
  }

   String get token => _sharedPreferences.getString('token')??'';

   int get code => _sharedPreferences.getInt('code')??0;

  bool get loggedIn => _sharedPreferences.getBool('logged_in') ?? false;

  Future<bool> logout() async {
    return await _sharedPreferences.clear();
  }

  Future<bool> setLanguage(String languageCode) async {
    return await _sharedPreferences.setString('language_code', languageCode);
  }

  String get languageCode => _sharedPreferences.getString('language_code') ?? 'en';
}