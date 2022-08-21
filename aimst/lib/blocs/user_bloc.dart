import 'dart:async';
import 'package:flutterapp/api/response.dart';
import 'package:flutterapp/repository/user_repository.dart';
import 'package:flutterapp/models/user_model.dart';

class UserBloc {
  late UserRepository _repository;
  late StreamController<Response<LoginModel>> _dataController;
  late bool _isStreaming;

  StreamSink<Response<LoginModel>> get dataSink => _dataController.sink;

  Stream<Response<LoginModel>> get dataStream => _dataController.stream;

  UserBloc() {
    _dataController = StreamController<Response<LoginModel>>();
    _repository = UserRepository();
    _isStreaming = true;
  }

  loginUser(email, password) async {
    dataSink.add(Response.loading('Getting...'));
    try {
      var data = await _repository.loginUser(email, password);
      return data;
      //if (_isStreaming) dataSink.add(Response.completed(data));
    } catch (e) {
      if (_isStreaming) dataSink.add(Response.error(e.toString()));
    }
  }

  getCountries() async {
    dataSink.add(Response.loading('Getting...'));
    try {
      var data = await _repository.getCountries();
      return data;
      //if (_isStreaming) dataSink.add(Response.completed(data));
    } catch (e) {
      if (_isStreaming) dataSink.add(Response.error(e.toString()));
    }
  }

  getCourses() async {
    dataSink.add(Response.loading('Getting...'));
    try {
      var data = await _repository.getCourses();
      return data;
      //if (_isStreaming) dataSink.add(Response.completed(data));
    } catch (e) {
      if (_isStreaming) dataSink.add(Response.error(e.toString()));
    }
  }

  getFacultyDetails() async {
    dataSink.add(Response.loading('Getting...'));
    try {
      var data = await _repository.getFacultyDetails();
      return data;
      //if (_isStreaming) dataSink.add(Response.completed(data));
    } catch (e) {
      if (_isStreaming) dataSink.add(Response.error(e.toString()));
    }
  }

  getRaceDetails() async {
    dataSink.add(Response.loading('Getting...'));
    try {
      var data = await _repository.getRaceDetails();
      return data;
      //if (_isStreaming) dataSink.add(Response.completed(data));
    } catch (e) {
      if (_isStreaming) dataSink.add(Response.error(e.toString()));
    }
  }

  registerUser(postData) async {
    dataSink.add(Response.loading('Getting...'));
    try {
      var data = await _repository.registerUser(postData);
      return data;
      //if (_isStreaming) dataSink.add(Response.completed(data));
    } catch (e) {
      if (_isStreaming) dataSink.add(Response.error(e.toString()));
    }
  }

  generateAuthKey() async {
    dataSink.add(Response.loading('Getting...'));
    try {
      var data = await _repository.generateAuthKey();
      return data;
      //if (_isStreaming) dataSink.add(Response.completed(data));
    } catch (e) {
      if (_isStreaming) dataSink.add(Response.error(e.toString()));
    }
  }

  dispose() {
    _isStreaming = false;
    _dataController.close();
  }
}
