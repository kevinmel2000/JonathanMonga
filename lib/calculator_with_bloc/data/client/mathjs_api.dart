import 'package:bloc_pattern_explain/calculator_with_bloc/data/models/mathjs_error.dart';
import 'package:bloc_pattern_explain/calculator_with_bloc/data/models/result.dart';
import 'package:http/http.dart' as http;

class MathjsResponseClient {
  final String baseUrl;
  final http.Client httpClient;

  MathjsResponseClient(
      {http.Client httpClient,
      this.baseUrl = "http://api.mathjs.org/v4/?expr="})
      : this.httpClient = httpClient ?? http.Client();

  Future<Result> getResult(String expresion) async {
    final response = await httpClient.get(Uri.parse("$baseUrl$expresion"));

    if (response.statusCode == 200) {
      return Result(result: response.body);
    } else {
      throw MathJsError(message: response.body);
    }
  }
}
