import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcom'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Welcom To flutter traning',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
