// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables , prefer_final_fields

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_final/screens/quiz_screen.dart';
import 'package:websafe_svg/websafe_svg.dart';
import '../providers/providers.dart';
import '../constants.dart';

class EntryScreen extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: [
          WebsafeSvg.asset('assets/icons/bg.svg',
              width: double.infinity, fit: BoxFit.fill),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(
                  flex: 2,
                ),
                Text(
                  'Let\'s Play Quiz,',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Enter your informations below',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Spacer(),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFF1C2341),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: 'Full Name',
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () => _startQuiz(context),
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(kDefaultPadding * 0.75),
                    decoration: BoxDecoration(
                      gradient: kPrimaryGradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Let\'s Start Quiz',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _startQuiz(BuildContext context) {
    if (_nameController.text.isNotEmpty) {

      Provider.of<AppProvider>(context , listen: false).setUserName(_nameController.text);
      print(Provider.of<AppProvider>(context , listen: false).getUsername);
      Navigator.of(context).pushNamed(QuizScreen.RouteName);
    } else
      print('You must enter your name');
  }
}
