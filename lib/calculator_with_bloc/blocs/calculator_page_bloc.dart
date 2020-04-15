import 'dart:async';

import 'package:bloc_pattern_explain/calculator_with_bloc/data/repositories/app_repository.dart';
import 'package:bloc_pattern_explain/calculator_with_bloc/operation.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class CalculatorPageEvent extends Equatable {
  CalculatorPageEvent();
}

class OperationEvent extends CalculatorPageEvent {
  final String firstNumber;
  final String secondNumber;
  final Operation operation;

  OperationEvent(
      {@required this.firstNumber,
      @required this.secondNumber,
      @required this.operation})
      : assert(firstNumber != null),
        assert(secondNumber != null);

  @override
  List<Object> get props => [firstNumber, secondNumber, operation];
}

class ClearEvent extends CalculatorPageEvent {}

abstract class CalculatorPageState extends Equatable {
  CalculatorPageState();
}

class InitialState extends CalculatorPageState {}

class ShowResultState extends CalculatorPageState {
  final String answer;

  ShowResultState({@required this.answer}) : assert(answer != null);

  @override
  List<Object> get props => [answer];
}

class ErrorState extends CalculatorPageState {
  final String message;

  ErrorState({@required this.message}) : assert(message != null);

  @override
  List<Object> get props => [message];
}

class CalculatorPageBloc
    extends Bloc<CalculatorPageEvent, CalculatorPageState> {
  final AppRepository appRepository;
  final bool isOffline;

  CalculatorPageBloc({this.isOffline = true, @required this.appRepository})
      : assert(appRepository != null);

  @override
  CalculatorPageState get initialState => InitialState();

  @override
  Stream<CalculatorPageState> mapEventToState(
      CalculatorPageEvent event) async* {
    if (event is ClearEvent) {
      yield InitialState();
    } else if (event is OperationEvent) {
      if (isOffline)
        yield* _doOperation(event);
      else
        yield* _fetchResultOnMathjs(event);
    }
  }

  Stream<CalculatorPageState> _doOperation(OperationEvent event) async* {
    var answer = 0.0;

    try {
      var firstNumber = double.parse(event.firstNumber);
      var secondNumber = double.parse(event.secondNumber);

      if (secondNumber == 0 && event.operation == Operation.division)
        throw Exception("Erreur de calcul");

      switch (event.operation) {
        case Operation.addition:
          answer = firstNumber + secondNumber;
          break;
        case Operation.substraction:
          answer = firstNumber - secondNumber;
          break;
        case Operation.mutiplication:
          answer = firstNumber * secondNumber;
          break;
        default:
          answer = firstNumber / secondNumber;
          break;
      }
    } catch (e) {
      yield ErrorState(message: "Erreur de calcul.");
    }

    yield ShowResultState(answer: answer.toString());
  }

  Stream<CalculatorPageState> _fetchResultOnMathjs(
      OperationEvent event) async* {
    try {
      var expression =
          "${event.firstNumber}${generateOperation(event.operation)}${event.secondNumber}";

      var result = await appRepository.getResult(expression);

      yield ShowResultState(answer: result.result);
    } catch (e) {
      yield ErrorState(message: "Erreur de calcul sur le serveur.");
    }
  }

  String generateOperation(Operation operation) {
    switch (operation) {
      case Operation.addition:
        return '+';
      case Operation.substraction:
        return '-';
      case Operation.mutiplication:
        return '*';
      default:
        return '/';
    }
  }
}
