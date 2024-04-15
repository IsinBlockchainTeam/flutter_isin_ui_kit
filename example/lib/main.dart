import 'package:example/views/HomePageView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_isin_ui_kit/utils/restart_widget.dart';

void main() {
  runApp(const RestartWidget(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePageView(),
    );
  }
}
