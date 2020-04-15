import 'package:flutter/widgets.dart';

class BusinessLogic {
  BusinessLogic({this.firstTextControler, this.secondTextControler})
      : assert(firstTextControler != null),
        assert(secondTextControler != null);

  final TextEditingController firstTextControler;
  final TextEditingController secondTextControler;

  /// This method is call when user want to add two numbers
  double addition() =>
      double.parse(firstTextControler.text) +
      double.parse(secondTextControler.text);

  /// This method is call when user want to sub two numbers
  double substraction() =>
      double.parse(firstTextControler.text) -
      double.parse(secondTextControler.text);

  double mulplication() =>
      double.parse(firstTextControler.text) *
      double.parse(secondTextControler.text);

  double division() {
    if (double.parse(secondTextControler.text) != 0)
      return double.parse(firstTextControler.text) /
          double.parse(secondTextControler.text);
    else
      throw Exception("Désolé, vous ne pouvez pas diviser par zero!");
  }

  void clear() {
    firstTextControler.text = '0';
    secondTextControler.text = '0';
  }
}
