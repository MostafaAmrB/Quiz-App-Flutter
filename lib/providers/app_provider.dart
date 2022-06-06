import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

// This provider will contain the logged in person name
// and control the total score of the quiz

class AppProvider with ChangeNotifier {
  String? _username;
  int _currentQuestion = 1;
  int _currentScore = 0;
  String? get getUsername => _username;
  int get getCurrentScore => _currentScore;
  int get getCurrentQuestion => _currentQuestion;

  void setUserName(String name) {
    _username = name;
    notifyListeners();
  }

  void submitAnswer(int questionScore, bool isRight) {
    if (isRight) {
      _currentScore += questionScore;
      notifyListeners();
    }
  }
  void nextQuestion()
  {
    _currentQuestion++;
    notifyListeners();
  }
  void setQuestion(int value)
  {
    _currentQuestion = value+1;
    notifyListeners();
  }

}
