import 'package:flutter/material.dart';
import 'package:quiz/data/question_bank.dart';

class QuizController {
  late List<Widget> iconsAns = [];

  int _indiceAtual = 0;
  int acertos = 0;
  int erros = 0;

  int numeroquestao = 1;

  String getQuestion() {
    return questions[_indiceAtual].text;
  }

  bool getCorrectAns() {
    return questions[_indiceAtual].answer;
  }

  void nextQuestion() {
    if (_indiceAtual < questions.length - 1) {
      _indiceAtual++;
      numeroquestao++;
    } else {
      questions.shuffle();
      _indiceAtual = 0;
      numeroquestao = 1;
    }
  }

  bool hasFinished() {
    return _indiceAtual >= questions.length - 1;
  }

  void reset() {
    iconsAns.clear();
    _indiceAtual = 0;
    acertos = 0;
    erros = 0;
    questions.shuffle();
    numeroquestao = 1;
  }

  void handleAnswer(bool correto) {
    bool respostaCorreta = getCorrectAns() == correto;
    if (respostaCorreta) {
      acertos++;
    } else {
      erros++;
    }
    iconsAns.add(Icon(
      respostaCorreta ? Icons.check : Icons.close,
      color: respostaCorreta ? Colors.green : Colors.red,
      size: 24,
    ));
  }
}
