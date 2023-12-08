import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String displayValue = '0';
  String? operator;
  double? previousValue;
  bool waitingForOperand = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            alignment: Alignment.bottomRight,
            child: Text(
              displayValue,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16),
          buildButtonRow(['7', '8', '9', '/']),
          buildButtonRow(['4', '5', '6', 'x']),
          buildButtonRow(['1', '2', '3', '-']),
          buildButtonRow(['0', 'C', '=', '+']),
        ],
      ),
    );
  }

  Widget buildButtonRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons
          .map(
            (button) => ElevatedButton(
              onPressed: () => handleButtonClick(button),
              child: Text(
                button,
                style: TextStyle(fontSize: 24),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(80, 80),
                primary: isOperator(button) ? Colors.orange : Colors.grey[300],
              ),
            ),
          )
          .toList(),
    );
  }

  void handleButtonClick(String value) {
    if (isOperator(value)) {
      handleOperatorClick(value);
    } else if (value == 'C') {
      handleClear();
    } else if (value == '=') {
      handleEquals();
    } else {
      handleDigitClick(value);
    }
  }

  void handleDigitClick(String digit) {
    if (waitingForOperand) {
      setState(() {
        displayValue = digit;
        waitingForOperand = false;
      });
    } else {
      setState(() {
        displayValue = (displayValue == '0') ? digit : displayValue + digit;
      });
    }
  }

  void handleOperatorClick(String nextOperator) {
    if (operator != null && double.tryParse(displayValue) != null) {
      double result = calculate(previousValue!, double.parse(displayValue), operator!);
      setState(() {
        displayValue = result.toString();
        previousValue = result;
      });
    } else {
      setState(() {
        previousValue = double.tryParse(displayValue);
      });
    }

    setState(() {
      waitingForOperand = true;
      operator = nextOperator;
    });
  }

  double calculate(double x, double y, String operator) {
    switch (operator) {
      case '+':
        return x + y;
      case '-':
        return x - y;
      case 'x':
        return x * y;
      case '/':
        return (y != 0) ? x / y : double.nan;
      default:
        return y;
    }
  }

  void handleClear() {
    setState(() {
      displayValue = '0';
      operator = null;
      previousValue = null;
      waitingForOperand = false;
    });
  }

  void handleEquals() {
    if (operator != null && double.tryParse(displayValue) != null) {
      double result = calculate(previousValue!, double.parse(displayValue), operator!);
      setState(() {
        displayValue = result.toString();
        operator = null;
        previousValue = result;
        waitingForOperand = true;
      });
    }
  }

  bool isOperator(String value) {
    return value == '+' || value == '-' || value == 'x' || value == '/';
  }
}
