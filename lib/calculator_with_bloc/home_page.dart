import 'package:bloc_pattern_explain/calculator_with_bloc/blocs/calculator_page_bloc.dart';
import 'package:bloc_pattern_explain/calculator_with_bloc/operation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WithBlocCalculatorPage extends StatefulWidget {
  @override
  State createState() => WithoutBlocCalculatorPageState();
}

class WithoutBlocCalculatorPageState extends State<WithBlocCalculatorPage> {
  var firstTextControler = TextEditingController(text: '0');
  var secondTextControler = TextEditingController(text: '0');

  void _doOperation(Operation operation) {
    if (operation == Operation.clear)
      BlocProvider.of<CalculatorPageBloc>(context).add(ClearEvent());
    else
      BlocProvider.of<CalculatorPageBloc>(context).add(OperationEvent(
        firstNumber: firstTextControler.text,
        secondNumber: secondTextControler.text,
        operation: operation,
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${BlocProvider.of<CalculatorPageBloc>(context).isOffline ? 'Offline' : 'Online'} Calculator"),
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocListener<CalculatorPageBloc, CalculatorPageState>(
              listener: (context, state) {
                if (state is ErrorState) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${state.message}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: BlocBuilder<CalculatorPageBloc, CalculatorPageState>(
                builder: (context, state) {
                  if (state is ShowResultState) {
                    return Text(
                      'Answerwer: ${state.answer}',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  } else {
                    firstTextControler = TextEditingController(text: '0');
                    secondTextControler = TextEditingController(text: '0');

                    return Text(
                      'Answerwer: 0',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                },
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 20)),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Enter the Number 1"),
              controller: firstTextControler,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Enter the Number 2"),
              controller: secondTextControler,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  child: Text(
                    "+",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  onPressed: () {
                    _doOperation(Operation.addition);
                  },
                  color: Colors.blueAccent,
                ),
                MaterialButton(
                  child: Text(
                    "-",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  onPressed: () {
                    _doOperation(Operation.substraction);
                  },
                  color: Colors.blueAccent,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  child: Text(
                    "x",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  onPressed: () {
                    _doOperation(Operation.mutiplication);
                  },
                  color: Colors.blueAccent,
                ),
                MaterialButton(
                  child: Text(
                    "/",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  onPressed: () {
                    _doOperation(Operation.division);
                  },
                  color: Colors.blueAccent,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Center(
                  child: MaterialButton(
                    child: Text(
                      "Clear",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      _doOperation(Operation.clear);
                    },
                    color: Colors.greenAccent,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
