import 'package:flutter/material.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recepify',
      theme: ThemeData(
        primaryColor:const Color(0xFFF97B22),
        hintColor: const Color(0xFFF97B22),
      ),
      home: const HomePage(),
    );
  }
}