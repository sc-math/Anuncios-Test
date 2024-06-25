import 'package:flutter/material.dart';

import 'package:anuncios_test/screens/home.dart';

void main() {
  runApp(const Anuncios());
}

class Anuncios extends StatelessWidget {
  const Anuncios({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Anúncios",
      theme: ThemeData.light(useMaterial3: true),
      home: const Home(),
    );
  }
}