// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables , prefer_final_fields

import 'package:flutter/material.dart';
import '../constants.dart';
import '../providers/providers.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import './widgets.dart';

class QuestionContainer extends StatefulWidget {
  @override
  State<QuestionContainer> createState() => _QuestionContainerState();

  Question question;
  int currentIndexQuestion;
  int? selectedByUser;
  final submitAnswerFunc;
  QuestionContainer(
      {required this.question,
      required this.currentIndexQuestion,
      required this.selectedByUser,
      required this.submitAnswerFunc,
      });
}

class _QuestionContainerState extends State<QuestionContainer> {
  void changeSelection(int choiceIndex) {
    //print('am Answering now');
    /*_pageController.nextPage(
                      duration: Duration(seconds: 1), curve: Curves.ease);*/
    setState(() {
      widget.selectedByUser = choiceIndex;
      //Should update the _answers[]
      widget.submitAnswerFunc(widget.currentIndexQuestion , choiceIndex );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    
    print('Build Question Container Again');
    print(widget.selectedByUser);
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: kDefaultPadding, horizontal: kDefaultPadding),
      //padding: EdgeInsets.all(kDefaultPadding),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
      ),
      child: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisSize: MainAxisSize.min,
        shrinkWrap: true,
        children: [
          Text(
            widget.question.question!,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          // ListView that contain all the answers
          Container(
            margin: EdgeInsets.only(top: 20),
            height: 400,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.question.choices!.length,
              itemBuilder: (_, choiceIndex) => _buildChoiceContainer(
                index: choiceIndex,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceContainer({required int index}) {
    return GestureDetector(
      onTap: () => changeSelection(index),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(kDefaultPadding),
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.selectedByUser != index 
                ? kGrayColor
                : widget.question.rightChoice == index
                    ? kGreenColor
                    : kRedColor,
          ),
          borderRadius: BorderRadius.circular(kDefaultBorderRaduis),
        ),
        child: Row(
          children: [
            Text(
              '${index + 1}. ${widget.question.choices![index]}',
              style: TextStyle(
                  color: widget.selectedByUser != index 
                ? kGrayColor
                : widget.question.rightChoice == index
                    ? kGreenColor
                    : kRedColor,
                  fontSize: 18),
            ),
            Spacer(),
            Container(
              width: 35,
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(
                  color: widget.selectedByUser != index 
                ? kGrayColor
                : widget.question.rightChoice == index
                    ? kGreenColor
                    : kRedColor,
                ),
              ),
              //child: Text('ads'),
              child: widget.selectedByUser != index 
                ? null
                : widget.question.rightChoice == index
                    ? FittedBox(child: Icon(Icons.check , color: kGreenColor,),)
                    : FittedBox(child: Icon(Icons.close , color: kRedColor,),),
            ),
          ],
        ),
      ),
    );
  }
}
