import 'package:flutter/material.dart';
import 'screens/dashboard.dart';

void main() {
  runApp(const DisciplinedTraderApp());
}

class DisciplinedTraderApp extends StatelessWidget {
  const DisciplinedTraderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Disciplined Trader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
