import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:testt/firebase_options.dart';
import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:FirebaseOptions(apiKey: "AIzaSyDZKNkRsIJLZR9FOxyazwd7stGM0ToYp0A",
     appId: "1:1088300194458:web:f74a808bf6a450e7fd9d23",
      messagingSenderId:"1088300194458",
       projectId:  "dadob-92dfe")
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
