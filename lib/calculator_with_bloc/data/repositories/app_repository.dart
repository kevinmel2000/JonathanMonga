import 'package:bloc_pattern_explain/calculator_with_bloc/data/client/mathjs_api.dart';
import 'package:bloc_pattern_explain/calculator_with_bloc/data/models/result.dart';
import 'package:bloc_pattern_explain/calculator_with_bloc/data/repositories/repository.dart';
import 'package:bloc_pattern_explain/calculator_with_bloc/data/storage/mathjs_cache.dart';

class AppRepository extends Repository {
  AppRepository({MathjsResponseCache cache, MathjsResponseClient client})
      : super(cache, client);

  @override
  Future<Result> getResult(String expresion) async {
    if (cache.data != null) {
      return cache.data;
    } else {
      final result = await client.getResult(expresion);
      cache.data = result;
      return result;
    }
  }
}
