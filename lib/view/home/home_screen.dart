import 'package:flutter/material.dart';
import 'package:shoppe/core/package/text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.canvasColor,
      body: Container(
        alignment: Alignment.center,
        child: text(text: "Welcome screen", fontSize: 30),
      ),
    );
  }
}
