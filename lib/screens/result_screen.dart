// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables , prefer_final_fields

import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';
import '../constants.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';

class ResultScreen extends StatelessWidget {
  static String RouteName = '/ResultScreen';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final _appProvider = Provider.of<AppProvider>(context, listen: false);
    final _questionsProvider =
        Provider.of<QuestionsProvider>(context, listen: false);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
           WebsafeSvg.asset('assets/icons/bg.svg',
              width: double.infinity, fit: BoxFit.fill),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Spacer(),
                FittedBox(
                  child: Text(
                    '${_appProvider.getUsername}',
                    style: TextStyle(
                        color: kSecondaryColor,
                        fontSize: 36,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                Text(
                  'Your Score is',
                  style: TextStyle(color: kSecondaryColor, fontSize: 30),
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                Text(
                  '${_appProvider.getCurrentScore}/${_questionsProvider.getTotalQuestionsScore}',
                  style: TextStyle(color: kSecondaryColor, fontSize: 30),
                ),
                Spacer(),
                Text(
                  'See you next time ',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
