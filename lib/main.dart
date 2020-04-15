import 'package:bloc/bloc.dart';
import 'package:bloc_pattern_explain/calculator_with_bloc/blocs/calculator_page_bloc.dart';
import 'package:bloc_pattern_explain/calculator_with_bloc/data/client/mathjs_api.dart';
import 'package:bloc_pattern_explain/calculator_with_bloc/data/repositories/app_repository.dart';
import 'package:bloc_pattern_explain/calculator_with_bloc/data/storage/mathjs_cache.dart';
import 'package:bloc_pattern_explain/calculator_with_bloc/home_page.dart';
// import 'package:bloc_pattern_explain/calculator_without_bloc/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final appRepository = AppRepository(
      cache: MathjsResponseCache(), client: MathjsResponseClient());

  runApp(
    BlocProvider<CalculatorPageBloc>(
      create: (context) {
        return CalculatorPageBloc(isOffline: true, appRepository: appRepository)
          ..add(ClearEvent());
      },

      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculator",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: WithBlocCalculatorPage(),
    );
  }
}

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: "Calculator",
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: WithoutBlocCalculatorPage(),
//     );
//   }
// }
