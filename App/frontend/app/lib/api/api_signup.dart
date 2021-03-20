<<<<<<< HEAD
import 'package:app/api/api.dart';
import 'package:app/model/signup_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APISignup {
  Future<SignupResponseModel> signup(SignupRequestModel requestModel) async {
    String url = ROUTE_MAIN + "users/";

    final response = await http.post(url, body: requestModel.toJson());
    if (response.statusCode == 201 || response.statusCode == 400) {
      return SignupResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load create user(SIGNUP)!');
    }
  }
}
=======
import 'package:app/api/api.dart';
import 'package:app/model/signup_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APISignup {
  Future<SignupResponseModel> signup(SignupRequestModel requestModel) async {
    String url = ROUTE_MAIN + "users/";

    final response = await http.post(url, body: requestModel.toJson());
    if (response.statusCode == 201 || response.statusCode == 400) {
      return SignupResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load create user(SIGNUP)!');
    }
  }
}
>>>>>>> 2ef4c09f107e2e28241f6bbd5d22ff5e1f235d19
