import 'dart:convert';
import 'dart:io';

import 'package:carro/domain/response.dart';
import 'package:carro/domain/user.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';

class LoginService {
  // ignore: missing_return
  static Future<Response> login(String login, String senha) async {

    var connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult);
    if (connectivityResult == ConnectivityResult.none) {
      return Response(false, "Internet indisponível.");
    }

    try {
      var url = 'http://LivrowebServices.com.br/rest/login';

      final response =
          await http.post(url, body: {'login': login, 'senha': senha});

      final s = response.body;
      print(s);

      final r = Response.fromJson(json.decode(s));

      if(r.isOk()) {
        final user = User(
          "Ricardo Flutter", 
          login, 
          "rlecheta@flutter.com"
          );
          user.save();
      }

      return r;
    } catch (error) {
      return Response(false, handleError(error));
    }
  }

  static String handleError(error) {
    return error is SocketException
        ? "Internet indisponível. Por favor verifique a sua conexão."
        : "Ocorreu um erro no login.";
  }
}
