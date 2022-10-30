import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorHome extends StatefulWidget {
  const CalculatorHome({Key? key}) : super(key: key);

  @override
  State<CalculatorHome> createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  @override
  var width = Get.width - 8;
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        equation = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      }
      else if(buttonText == "Ac"){
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      }
      else if(buttonText == "00" && equation =='0'){
        equation = "0";
        equationFontSize = 48.0;
        resultFontSize = 38.0;
      }

      else if(buttonText == "«"){
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if(equation == ""){
          equation = "0";
        }
      }

      else if(buttonText == "="){
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
        }

      }

      else{
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if(equation == "0"){
          equation = buttonText;
        }else {
          equation = equation + buttonText;
        }
      }
    });
  }



  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red,
        leading: Icon(
          Icons.calculate,
          color: Colors.white,
        ),
        title: Text("Calculator"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              child:Column(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                    child: Text(equation, style: TextStyle(fontSize: equationFontSize),),
                  ),


                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.fromLTRB(10, 30, 5, 0),
                    child: Text(result, style: TextStyle(fontSize: resultFontSize),),
                  ),
                ],
              ),
              color: Colors.grey,
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton("Ac"),
                      _buildButton("C"),
                      _buildButton("«"),
                      _buildButton("÷"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton("7"),
                      _buildButton("8"),
                      _buildButton("9"),
                      _buildButton("×"),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton("4"),
                      _buildButton("5"),
                      _buildButton("6"),
                      _buildButton("+"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton("1"),
                      _buildButton("2"),
                      _buildButton("3"),
                      _buildButton("-"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildButton("0"),
                      _buildButton("00"),
                      _buildButton("."),
                      _buildButton("="),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  _buildButton(String btnTxt){
    return InkWell(
      onTap: () {
        buttonPressed(btnTxt);
        print(btnTxt);
      },
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          child: Center(
            child: Text(
              btnTxt,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25
              ),
            ),
          ),
          height: 55,
          width: width / 4,
          decoration: BoxDecoration(
            borderRadius:
            BorderRadius.all(Radius.circular(5)),
            color: Colors.white24,
          ),
        ),
      ),
    );
  }
}
