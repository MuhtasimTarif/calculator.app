import 'package:flutter/material.dart';
import 'calculator_logic.dart';

class CalculatorPage extends StatefulWidget {
  final bool darkMode;
  final VoidCallback onThemeChanged;

  const CalculatorPage({
    super.key,
    required this.darkMode,
    required this.onThemeChanged,
  });

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String input = "";
  String output = "";

  final List<String> buttons = [
    "AC", "⌫", "%", "÷",
    "7", "8", "9", "×",
    "4", "5", "6", "-",
    "1", "2", "3", "+",
    "🌙", "0", ".", "="
  ];

  bool isOperator(String s) {
    return ["+", "-", "×", "÷", "%"].contains(s);
  }

  void onButtonClick(String value) {
    setState(() {

      if (value == "AC") {
        input = "";
        output = "";
      }

      else if (value == "⌫") {
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1);
        }
      }

      else if (value == "=") {
        output = CalculatorLogic.evaluate(input);
      }

      else if (value == "🌙") {
        widget.onThemeChanged();
      }

      else {

        if (input.isNotEmpty &&
            isOperator(input[input.length - 1]) &&
            isOperator(value)) {
          return;
        }

        input += value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Calculator"),
        centerTitle: true,
      ),

      body: Column(
        children: [

          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              alignment: Alignment.bottomRight,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,

                children: [

                  Text(
                    input,
                    style: const TextStyle(
                      fontSize: 32,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    output,
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: GridView.builder(

              padding: const EdgeInsets.all(10),

              itemCount: buttons.length,

              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),

              itemBuilder: (context, index) {

                final btn = buttons[index];

                return ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),

                  onPressed: () => onButtonClick(btn),

                  child: Text(btn),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}