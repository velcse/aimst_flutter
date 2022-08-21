import 'package:flutterapp/api/api_provider.dart';
import 'package:flutterapp/utils/preference_utils.dart';
import 'package:flutterapp/utils/constants.dart';
import 'dart:async';

class UserRepository {
  final ApiProvider _provider = ApiProvider();

  Future<dynamic> loginUser(String email, String password) async {
    var postData = {'email_address': email, 'password': password};
    final response = await _provider.post('login', postData);
    return response;
  }

  Future<dynamic> getCountries() async {
    final response = await _provider.get('countries');
    return response;
  }

  Future<dynamic> getCourses() async {
    final response = await _provider.get('courses');
    return response;
  }

  Future<dynamic> getFacultyDetails() async {
    final response = await _provider.get('faculty');
    return response;
  }

  Future<dynamic> getRaceDetails() async {
    final response = await _provider.get('race');
    return response;
  }

  Future<dynamic> registerUser(postData) async {
    final response = await _provider.post('registration', postData);
    return response;
  }

  Future<dynamic> generateAuthKey() async {
    var postData = {'jwt': Preference.getString(userToken), 'reqtype': 'app'};
    final response = await _provider.post('authkey', postData);
    return response;
  }
}
