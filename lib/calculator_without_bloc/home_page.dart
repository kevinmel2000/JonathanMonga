import 'package:bloc_pattern_explain/calculator_with_bloc/operation.dart';
import 'package:bloc_pattern_explain/calculator_without_bloc/business_logic.dart';
import 'package:flutter/material.dart';

class WithoutBlocCalculatorPage extends StatefulWidget {
  @override
  State createState() => WithoutBlocCalculatorPageState();
}

class WithoutBlocCalculatorPageState extends State<WithoutBlocCalculatorPage> {
  var firstTextControler = TextEditingController(text: '0');
  var secondTextControler = TextEditingController(text: '0');

  var businessLogic;
  var answer;

  /// Initialize all values
  void _initializeValue() {
    answer = 0;

    businessLogic = BusinessLogic(
        firstTextControler: firstTextControler,
        secondTextControler: secondTextControler);
  }

  void _doOperation(Operation operation) {
    setState(() {
      switch (operation) {
        case Operation.addition:
          answer = businessLogic.addition();
          break;
        case Operation.addition:
          answer = businessLogic.substraction();
          break;
        case Operation.addition:
          answer = businessLogic.mulplication();
          break;
        case Operation.division:
          answer = businessLogic.division();
          break;
        default:
          businessLogic.clear();
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _initializeValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Answerwer: $answer',
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
            ),
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
