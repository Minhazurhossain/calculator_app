import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String display = '';
  String result = '';
  String operator = '';
  double num1 = 0;
  double num2 = 0;

  void onButtonPressed(String value) {
    setState(() {
      if (value == 'DEL') {
        display = '';
        result = '';
        operator = '';
        num1 = 0;
        num2 = 0;
      } else if (value == '+' || value == '-' || value == 'X' || value == '/') {
        operator = value;
        num1 = double.tryParse(display) ?? 0;
        display = '';
      } else if (value == '=') {
        num2 = double.tryParse(display) ?? 0;
        switch (operator) {
          case '+':
            result = (num1 + num2).toString();
            break;
          case '-':
            result = (num1 - num2).toString();
            break;
          case 'X':
            result = (num1 * num2).toString();
            break;
          case '/':
            result = num2 != 0 ? (num1 / num2).toString() : 'Error';
            break;
        }
        display = result;
        operator = '';
      } else {
        display += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.all(30),
              alignment: Alignment.centerRight,
              child: Text(
                display,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 14,
            child: Column(
              children: [
                buildButtonRow(['DEL', '=', '/', 'X']),
                SizedBox(height: 15),
                buildButtonRow(['7', '8', '9', '-']),
                SizedBox(height: 15),
                buildButtonRow(['4', '5', '6', '+']),
                SizedBox(height: 15),
                buildButtonRow(['1', '2', '3', '0']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButtonRow(List<String> values) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: values.map((value) {
          return Expanded(
            child: ElevatedButton(
              onPressed: () => onButtonPressed(value),
              child: Text(
                value,
                style: TextStyle(fontSize: 24),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _getButtonColor(value),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Color _getButtonColor(String value) {
    if (value == 'DEL' || value == '=') {
      return Colors.blue;
    } else if (value == '/' || value == 'X' || value == '-' || value == '+') {
      return Colors.green;
    } else {
      return Colors.orange;
    }
  }
}
