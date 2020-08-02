import 'dart:convert';
import 'package:budget_app/models/user_model.dart';
import 'package:http/http.dart' as Http;

class Api {
  final String api = "http://budgito.herokuapp.com/api";
  Map<String, String> headers = {
    "Accept": "application/json",
    "Content-type": "application/json"
  };

  createAccount(User user) async {
    String postUrl = '$api/accounts/';
    Http.Response response = await Http.post(
      postUrl,
      headers: headers,
      body: jsonEncode(user.toJson()),
    );
    var jsonData;
    if (response.statusCode == 201) {
      jsonData = response.body;
    } else {
      jsonData = {"detail": "error"};
    }
    return jsonData;
  }

  signIn(User user) async {
    String postUrl = '$api/accounts/token/';
    Http.Response response = await Http.post(
      postUrl,
      headers: headers,
      body: jsonEncode(user.toJson()),
    );
    var jsonData;
    if (response.statusCode == 201) {
      jsonData = response.body;
    } else {
      print(response.statusCode);
      jsonData = response.body;
    //  jsonData = {"response": "error"};
    }
    return jsonData;
  }
}
