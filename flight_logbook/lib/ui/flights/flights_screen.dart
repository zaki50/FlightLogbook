import 'package:flutter/material.dart';

class FlightListScreen extends StatelessWidget {
  final _appBar = AppBar(title: const Text('Flight Logbook'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: const Center(
        child: Text('FlightList'),
      ),
    );
  }
}
