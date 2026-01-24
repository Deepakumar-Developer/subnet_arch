import 'package:flutter/material.dart';
import 'package:subnet_arch/function/app_function.dart';
import 'package:subnet_arch/page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    customStatusBar(Color(0xffFBFBFB), Color(0xffFBFBFB), Brightness.dark, Brightness.dark);
    return MaterialApp(
      title: 'Subnet Arch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: Color(0xff0118D8),
          surface: Color(0xffFBFBFB),
          primary: Color(0xff0118D8),
          secondary: Color(0xff1B56FD),
          tertiary: Color(0xff222222),
        ),
      ),
      home: HomePage(
      ),
    );
  }
}