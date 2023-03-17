import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_list/screens/colors.dart';
import 'package:notes_list/model/historyitem.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  void showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 400),
      ),
    );
  }

  int index = 0;
  var input = "";
  var output = "";
  var operation = "";

  onButtonClick(value) {
    //if value is AC
    if (value == 'AC') {
      input = '';
      output = '';
    } else if (value == "C") {
      if (input.isNotEmpty || output.isNotEmpty) {
        input = input.substring(0, input.length - 1);
        output = output.substring(0, output.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }

        final historyItem = HistoryItem(expression: input, result: output);

        Hive.box<HistoryItem>('history').add(historyItem);


      } else {
        output = output + operation;

      }
    } else {
      input = input + value;
    }

    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(


      backgroundColor: Colors.black12,

      body:
      Column(
        children: [
          Expanded(child: Container(
            padding: const EdgeInsets.all(18),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children:  [
                Text(
                  input,
                  style: const TextStyle(
                      fontSize: 48,
                      color: Colors.white
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  output,
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),

          )),



          //ButtonArea
          Row(
            children: [
              button(text: "AC",tColor: greenColor,buttonBgColor: operatorColor,tSize: 19.0),

              button(text: '(',tColor: Colors.lightGreen),
              button(text: ')',tColor: Colors.lightGreen),
              button(text: '/', tColor: Colors.lightGreen),
            ],
          ),
          Row(
            children:  [
              button(text: '7'),button(text: '8'),button(text: '9'),button(text: 'x',tColor: Colors.lightGreen),
            ],
          ),
          Row(
            children: [
              button(text: '4'),button(text: '5'),button(text: '6'),button(text: '-',tColor: Colors.lightGreen),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: '3'),
              button(text: '+',tColor: Colors.lightGreen),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 21.0),
            child: Row(
              children: [
                button(text: 'C',tColor: Colors.red),
                button(text: '0'),
                button(text: '.'),
                button(text: '=', buttonBgColor: greenColor),
              ],
            ),
          ),

        ],
      ),

    );
  }

  Widget button({
    text, tColor=Colors.white, buttonBgColor = buttonColor,tSize=25.0
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(7),
        child: Expanded(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(27),
                  backgroundColor: buttonBgColor,
                ),
                onPressed: () =>onButtonClick(text),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: tSize,
                    color: tColor,
                    fontWeight: FontWeight.bold,
                  ),
                ))),
      ),
    );
  }
}
