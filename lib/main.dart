import 'package:flutter/material.dart';
import 'package:notes_app/screens/HomePage.dart';
 
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of our application.
  @override
  Widget build(BuildContext context) {
  

    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: "AlegreyaSans"
      ),
      home:HomePage(),
    );
  }
}

