import 'dart:convert';
import 'package:budget_app/models/user_model.dart';
import 'package:http/http.dart' as Http;

class Api {
  final String api = "http://budgito.herokuapp.com/api";

  createAccount(User user) async {
    String postUrl = '$api/accounts/';
    Http.Response response = await Http.post(
      postUrl,
      headers: {
        "Accept": "application/json",
        "Content-type": "application/json"
      },
      body: jsonEncode(user.toJson()),
    );
    var jsonData;
    if (response.statusCode == 200) {
      jsonData = response.body;
    } else {
      jsonData = {"response": "error"};
    }
    return jsonData['response'];
  }
}
