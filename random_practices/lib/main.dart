import 'package:flutter/material.dart';

class Counter extends StatelessWidget {
  const Counter({required this.counter, required this.incrementCounter, super.key});

  final int counter;
  final VoidCallback incrementCounter;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [Text('you clicked $counter times'), IconButton(onPressed: incrementCounter, icon: Icon(Icons.add))],
      ),
    );
  }
}
class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App'),
      ),
      body: Center(
        child: Counter(
          counter: _counter,
          incrementCounter: _incrementCounter,
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: CounterApp(),
    ),
  );
}