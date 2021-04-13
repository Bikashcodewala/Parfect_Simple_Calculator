import 'package:flutter/cupertino.dart';
import 'package:math_expressions/math_expressions.dart';

class Instruction {
  isEqual(_input) {
    Parser p = new Parser();
    Expression exp = p.parse(_input.text);
    ContextModel cm = ContextModel();
    return exp.evaluate(EvaluationType.REAL, cm).toString();
  }

  isOperator(_input, text) {
    int l = _input.text.length;
    if (l < 1) {
      return _input.text = '0';
    } else if (_input.text[l - 1] == '+' ||
        _input.text[l - 1] == '-' ||
        _input.text[l - 1] == '*' ||
        _input.text[l - 1] == '/' ||
        _input.text[l - 1] == '%' ||
        _input.text[l - 1] == '^') {
      _input.text = _input.text.substring(0, _input.text.length - 1);
      return _input.text += text;
    } else {
      return _input.text += text;
    }
  }



}
