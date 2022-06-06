import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/screens.dart';
import './providers/providers.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider(),),
        ChangeNotifierProvider(create: (_) => QuestionsProvider(),)
      ],
      child: MaterialApp(
        title: 'Quiz',
        theme: ThemeData.dark(),
        home: EntryScreen(),
        routes: {
          QuizScreen.RouteName : (_) => QuizScreen(),
          ResultScreen.RouteName: (_) => ResultScreen(),
        },
      ),
    );
  }
}
