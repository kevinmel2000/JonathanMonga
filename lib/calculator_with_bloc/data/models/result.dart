import 'package:equatable/equatable.dart';

class Result extends Equatable {
  final String result;

  Result({this.result});

  @override
  List<Object> get props => [result];

  @override
  String toString() => """
  {
    Result: $result,
  }
  """;
}
