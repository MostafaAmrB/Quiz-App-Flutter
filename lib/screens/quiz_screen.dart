// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables , prefer_final_fields

import 'package:flutter/material.dart';
import 'package:quiz_final/screens/screens.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../constants.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class QuizScreen extends StatelessWidget {
  static String RouteName = '/QuizScreen';
  late int _numberOfQuestions;
  late QuestionsProvider _questionProvider;
  int _currentScore = 0;
  PageController _pageController = PageController();
  List<int?> _answers = [];

  @override
  Widget build(BuildContext context) {
    //final _appProvider = Provider.of<AppProvider>(context , listen: false);
    _questionProvider = Provider.of<QuestionsProvider>(context, listen: false);
    _numberOfQuestions = _questionProvider.items.length;

    // Fill the _answer it first time with null values
    _EmptyAnswerList(_numberOfQuestions);

    print('Build Main QuizScreen Again');
    // TODO: implement build
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          WebsafeSvg.asset('assets/icons/bg.svg',
              width: double.infinity, fit: BoxFit.fill),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildQuestionHeader(context),
                  Divider(
                    color: kSecondaryColor,
                    thickness: 1,
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildPageView(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _EmptyAnswerList(int length) {
    _answers.clear();
    for (int i = 0; i < length; i++) {
      _answers.add(null);
    }
    print("Answers List count is ${_answers.length}");
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      //shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Consumer<AppProvider>(
        builder: (_, provider, __) {
          return Text(
            '${provider.getUsername} ',
            style: TextStyle(color: Colors.green[200]),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            // skip can be used to skip to the next question
            // or if i am already at the last question then take me to the result page
            if (_pageController.page == _numberOfQuestions - 1)
              // This means that i am at the last question and the next step is the FinalResult
              finishQuiz(context);
            else
              _pageController.nextPage(
                  duration: Duration(milliseconds: 500), curve: Curves.easeIn);
            //Navigator.of(context).pushNamed(ResultScreen.RouteName);
          },
          child: Text(
            'Skip',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionHeader(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (_, provider, __) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                text: 'Question ${provider.getCurrentQuestion}',
                style: TextStyle(color: kSecondaryColor, fontSize: 36),
                children: [
                  TextSpan(
                    text: '/$_numberOfQuestions',
                    style: TextStyle(color: kSecondaryColor, fontSize: 26),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () => finishQuiz(context),
              
              child: Text(
                'Finish Quiz',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPageView(BuildContext context) {
    print('Build PageView Again');
    return Consumer<QuestionsProvider>(
      builder: (_, provider, __) {
        return Container(
          height: 600,
          //color: Colors.grey,
          child: PageView.builder(
            onPageChanged: (value) {
              Provider.of<AppProvider>(context, listen: false)
                  .setQuestion(value);
            },
            itemCount: provider.items.length,
            itemBuilder: (_, index) => QuestionContainer(
              question: provider.items[index],
              currentIndexQuestion: index,
              selectedByUser: _answers[index],
              submitAnswerFunc: pickChoice,
            ),
            //physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
          ),
        );
      },
    );
  }

  void pickChoice(int currentIndexQuestion, int choiceIndex) {
    print('am Answering now');
    _pageController.nextPage(
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    _answers[currentIndexQuestion] = choiceIndex;
  }

  void finishQuiz(BuildContext context) {
    for (int i = 0; i < _numberOfQuestions; i++) {
      final question = _questionProvider.items[i];
      Provider.of<AppProvider>(context, listen: false).submitAnswer(
          question.scoreForQuestion!, question.rightChoice == _answers[i]);
    }
    Navigator.of(context).pushNamed(ResultScreen.RouteName);
  }
}
