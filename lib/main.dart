import 'package:flutter/material.dart';
import './buttons.dart';
import 'package:math_expressions/math_expressions.dart';


void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Homepage());
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var UserQuestion = "";
  var UserAnswer = "";
  final List<String> buttons = [
    'C',
    '~/',
    '%',
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
    '0',
    '.',
    'Del',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        UserQuestion,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(UserAnswer,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (BuildContext context, int index) {
                      //Clear Button
                      if (index == 0) {
                        return MyButtons(
                            buttonTapped: () {
                              setState(() {
                                UserQuestion = "";
                                UserAnswer = "";
                              });
                            },
                            color: Color.fromARGB(255, 0, 101, 3),
                            buttonText: buttons[index],
                            textColor: Colors.white);
                      }
                            //Equals Button
                              else if (index == buttons.length-1) {
                        return MyButtons(
                            buttonTapped: () {
                              setState(() {
                               equalPressed();
                              });
                            },
                            color: const Color.fromARGB(255, 142, 123, 95),
                            buttonText: buttons[index],
                            textColor: Colors.white);
                        //Delete Button
                      } else if (index == 18) {
                        return MyButtons(
                            buttonTapped: () {
                              setState(() {
                               UserQuestion = UserQuestion.substring(0, UserQuestion.length - 1);
                              });
                            },
                            color: Color.fromARGB(255, 134, 9, 0),
                            buttonText: buttons[index],
                            textColor: Colors.white);
                      } 
                      else {
                        return MyButtons(
                          buttonTapped: () {
                            setState(() {
                              UserQuestion += buttons[index];
                            });
                          },
                          color: isOperator(buttons[index])
                              ? const Color.fromARGB(255, 142, 123, 95)
                              : Color.fromARGB(255, 48, 16, 16),
                          buttonText: buttons[index],
                          textColor: Colors.white,
                        );
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

bool isOperator(String x) {
  if (x == '%' ||
      x == '/' ||
      x == '*' ||
      x == '+' ||
      x == '=' ||
      x == '~/' ||
      x == '-') {
    return true;
  }
  return false;
}

void equalPressed()
{
  String finalQuestion = UserQuestion;
  finalQuestion = finalQuestion.replaceAll('x', '*');
  Parser p = Parser();
  Expression exp = p.parse(finalQuestion);
   ContextModel cm = ContextModel();
   double eval = exp.evaluate(EvaluationType.REAL, cm);

   UserAnswer =eval.toString();


}
}
