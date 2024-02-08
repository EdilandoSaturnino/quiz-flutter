import 'package:flutter/material.dart';
import 'package:quiz/controllers/quiz_controller.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuizController quizController = QuizController();

  void _mostrarResultado() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Resultado"),
          content: Text(
              "Acertos: ${quizController.acertos}\nErros: ${quizController.erros}"),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                setState(() {
                  quizController.reset();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _button(String text, bool correto, Color color) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            style:
                ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
            onPressed: () {
              quizController.handleAnswer(correto);
              setState(() {
                if (quizController.hasFinished()) {
                  _mostrarResultado();
                } else {
                  quizController.nextQuestion();
                }
              });
            },
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  "${quizController.numeroquestao}. ${quizController.getQuestion()}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  _button("Verdadeiro", true, Colors.green),
                  _button("Falso", false, Colors.red),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              quizController.reset();
                            });
                          },
                          child: const Text(
                            "Resetar",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Wrap(
                children: quizController.iconsAns,
              ),
            )
          ],
        ),
      ),
    );
  }
}
