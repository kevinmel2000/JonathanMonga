import 'package:bloc_pattern_explain/calculator_with_bloc/data/client/mathjs_api.dart';
import 'package:bloc_pattern_explain/calculator_with_bloc/data/models/result.dart';
import 'package:bloc_pattern_explain/calculator_with_bloc/data/storage/mathjs_cache.dart';

abstract class Repository {
  final MathjsResponseCache cache;
  final MathjsResponseClient client;

  Repository(this.cache, this.client);

  Future<Result> getResult(String expresion);
}
