import 'package:flutter/material.dart';

class Question {
  final String text;
  final List<Option> options;
  final String solution;
  bool isLocked;
  Option selectedOption;

  Question({
    @required this.text,
    @required this.options,
    @required this.solution,
    this.isLocked = false,
    this.selectedOption,
  });
}

class Option {
  final String code;
  final String text;
  final bool isCorrect;

  const Option({
    @required this.text,
    @required this.code,
    @required this.isCorrect,
  });
}

final questions = [
  Question(
    text: 'Kolikšna je povprečna višina dreves?',
    options: [
      Option(code: 'A', text: '10m', isCorrect: false),
      Option(code: 'B', text: '15m', isCorrect: true),
      Option(code: 'C', text: '30m', isCorrect: false),
      Option(code: 'D', text: '100m', isCorrect: false),
    ],
    solution: 'Povprečna višina dreves je 15m',
  ),
  Question(
    text: 'Zakaj so drevesa potrebna za življenje?',
    options: [
      Option(code: 'A', text: 'Ker proizvajajo vodo', isCorrect: false),
      Option(code: 'B', text: 'Ker porabljajo kisik', isCorrect: false),
      Option(code: 'C', text: 'Ker pretvarjajo CO2', isCorrect: true),
      Option(code: 'D', text: 'Ker proizvajajo CO2', isCorrect: false),
    ],
    solution: 'Drevesa so potrbna, saj čistijo zrak in pretvarajo CO2 v kisik v procesu fotosinteze.',
  ),
  Question(
    text: 'Kje se nahaja park tivoli?',
    options: [
      Option(code: 'A', text: 'Ljubljana', isCorrect: true),
      Option(code: 'B', text: 'Maribor', isCorrect: false),
      Option(code: 'C', text: 'Dunaj', isCorrect: false),
      Option(code: 'D', text: 'Jesenice', isCorrect: false),
    ],
    solution: 'Nahaja se v Ljubljani.',
  ),
  Question(
    text:
        'Huh?',
    options: [
      Option(code: 'A', text: 'ja', isCorrect: false),
      Option(code: 'B', text: 'ne', isCorrect: false),
      Option(code: 'C', text: "nevem", isCorrect: false),
      Option(code: 'D', text: "kaj", isCorrect: true),
    ],
    solution: 'Out of ideas',
  ),
  Question(
    text: 'Kdaj je nastal park Tivoli?',
    options: [
      Option(code: 'A', text: '1813', isCorrect: true),
      Option(code: 'B', text: '2001', isCorrect: false),
      Option(code: 'C', text: '1923', isCorrect: false),
      Option(code: 'D', text: '1864', isCorrect: false),
    ],
    solution: 'Park Tivoli so odprli leta 1813.',
  ),
  Question(
    text: ' Kdo je preuredil park Tivoli leta 1939?',
    options: [
      Option(code: 'A', text: 'Jože Plečnik', isCorrect: true),
      Option(code: 'B', text: 'Nevem', isCorrect: false),
      Option(code: 'C', text: 'Maks Fabiani‎', isCorrect: false),
      Option(
        code: 'D',
        text: 'Edvard Ravnikar‎',
        isCorrect: false,
      ),
    ],
    solution: 'Park Tivoli je preuredil Jože Plečnik.',
  ),
  
  Question(
    text: 'Test',
    options: [
      Option(code: 'A', text: 'y', isCorrect: false),
      Option(code: 'B', text: 'n', isCorrect: false),
      Option(code: 'C', text: 't', isCorrect: false),
      Option(code: 'D', text: 's', isCorrect: true),
    ],
    solution: 'Tessst',
  ),
];
