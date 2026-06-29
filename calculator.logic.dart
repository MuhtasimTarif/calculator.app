import 'package:math_expressions/math_expressions.dart';

class CalculatorLogic {
  static String evaluate(String expression) {
    if (expression.isEmpty) return "";

    expression = expression.replaceAll('×', '*');
    expression = expression.replaceAll('÷', '/');

    try {
      Parser parser = Parser();
      Expression exp = parser.parse(expression);
      ContextModel cm = ContextModel();

      double result = exp.evaluate(EvaluationType.REAL, cm);

      if (result == result.toInt()) {
        return result.toInt().toString();
      }

      return result.toString();
    } catch (e) {
      return "Error";
    }
  }
}