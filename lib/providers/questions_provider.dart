// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables , prefer_final_fields

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';

class QuestionsProvider with ChangeNotifier {
  List<Question> _items = [
    Question(
      id: 1,
      question: 'Who is the top scorer of Champions 2021/2022 ? ________',
      choices: ['Karim Benzema', 'Robert Lewondawski', 'Lionel Messi' , 'Mohamed Salah'],
      rightChoice: 0,
      scoreForQuestion: 10,
    ),
    Question(
      id: 2,
      question:
          'Flutter is an open-source UI Software development kit created by? ________',
      choices: ['Apple', 'Google', 'Facebook', 'Microsoft'],
      rightChoice: 1,
      scoreForQuestion: 10,
    ),
    Question(
      id: 3,
      question: 'What is the code of System Analysis ? ________',
      choices: ['CS201', 'IT144', 'IS403', 'MM456'],
      rightChoice: 2,
      scoreForQuestion: 10,
    ),

  ];

  List<Question> get items => [..._items];

  int get getTotalQuestionsScore {
    int totalScore = 0;
    _items.forEach((element) {
      totalScore += element.scoreForQuestion!;
    });
    return totalScore;
  }

  void addItem(Question newItem) {
    // Adding to my local List
    items.add(newItem);
    notifyListeners();
    print('item added');
  }

  void deleteItem(int id) {
    // Removing from my local list
    items.removeWhere((element) => element.id == id);
    print('item deleted');
    notifyListeners();
  }

  void updateItem(int id, Question newItem) {
    newItem.id = id;
    int updatedItemIndex = items.indexWhere((element) => element.id == id);
    items.removeAt(updatedItemIndex);
    items.insert(updatedItemIndex, newItem);
    print('item updated');
    notifyListeners();
  }

  Question fetchItemById(int id) {
    // To fetch only one item by ID , no need to notifylistener #NotSure
    return items.firstWhere((element) => element.id == id);
  }
}
