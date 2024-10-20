import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Home'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuizPage()),
            );
          },
          child: Text(
            'Start Quiz',
            style: TextStyle(fontSize: 24),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Question> questions = [
    Question(
      questionText: 'Quel est le plus grand océan de la Terre ?',
      answers: [
        Answer(text: 'Océan Atlantique', isCorrect: false),
        Answer(text: 'Océan Pacifique', isCorrect: true),
        Answer(text: 'Océan Indien', isCorrect: false),
      ],
    ),
    Question(
      questionText: 'Quelle est la capitale de la France ?',
      answers: [
        Answer(text: 'Berlin', isCorrect: false),
        Answer(text: 'Madrid', isCorrect: false),
        Answer(text: 'Paris', isCorrect: true),
      ],
    ),
    Question(
      questionText: 'Combien de continents y a-t-il sur Terre ?',
      answers: [
        Answer(text: '5', isCorrect: false),
        Answer(text: '6', isCorrect: false),
        Answer(text: '7', isCorrect: true),
      ],
    ),
  ];

  int score = 0;
  int currentQuestionIndex = 0;

  void answerQuestion(bool isCorrect) {
    if (isCorrect) {
      score++;
    }
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestionIndex >= questions.length) {
      return ResultPage(score: score, totalQuestions: questions.length);
    }

    final question = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(title: Text('Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              question.questionText,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ...question.answers.map((answer) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () => answerQuestion(answer.isCorrect),
                  child: Text(
                    answer.text,
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final int score;
  final int totalQuestions;

  ResultPage({required this.score, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Resultat')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Votre score: $score/$totalQuestions',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text(
                'Retour à l\'accueil',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String questionText;
  final List<Answer> answers;

  Question({required this.questionText, required this.answers});
}

class Answer {
  final String text;
  final bool isCorrect;

  Answer({required this.text, required this.isCorrect});
}
