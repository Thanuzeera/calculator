import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  //Declare userInput and result
  String userInput = '';
  String results = '0';
  //Declare list of calculator buttons
  List<String> buttonList = [
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    'C',
    '0',
    '.',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(31, 40, 39, 39),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userInput,
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    results,
                    style: const TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.white,
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(20),
            child: GridView.builder(
                itemCount: buttonList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return CustomButton(buttonList[index]);
                }),
          )),
        ],
      ),
    );
  }

  Widget CustomButton(String text) {
    return InkWell(
      splashColor: Colors.redAccent,
      onTap: () {
        setState(() {
          handleButton(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
            color: getBgColor(text), // Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: 4,
                spreadRadius: 0.5,
                offset: const Offset(-3, -3),
              ),
            ]),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: getColor(text),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  getColor(String text) {
    if (text == '/' ||
        text == '*' ||
        text == '-' ||
        text == '+' ||
        text == 'C' ||
        text == '(' ||
        text == ')') {
      return  Colors.orange; // const Color.fromARGB(255, 252, 100, 100);
    }
    return Colors.white;
  }

  getBgColor(String text) {
    if (text == 'AC') {
      return Colors.orange;
      // return const Color.fromARGB(255, 252, 100, 100);
    }
    if (text == '=') {
      return const Color.fromARGB(255, 104, 204, 159);
    }
    return Colors.black38;
  }

  handleButton(String text){
    if(text == 'AC'){
      userInput = '';
      results = '0';
      return;
    }
    if(text == 'C'){
      if(userInput.isNotEmpty){
        userInput = userInput.substring(0,userInput.length-1);
        return;
      }
      else{
        return null;
      }
    }
    if(text == '='){
      results = calculate();
      userInput = results;
      if(userInput.endsWith(".0")){
        userInput = userInput.replaceAll(".0", "");

      }
      if(results.endsWith(".0")){
        results = results.replaceAll(".0", "");
        return;
      }
    }
    userInput = userInput+ text;
  }

  String calculate(){
    try{
var expressions = Parser().parse(userInput);
var evaluation = expressions.evaluate(EvaluationType.REAL, ContextModel());
return evaluation.toString();
    }catch(e){
      return "Error";
    }
  }
}
