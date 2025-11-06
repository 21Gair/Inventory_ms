import 'package:flutter/material.dart';
// use lesss***

class ItamTamp extends StatelessWidget {
  const ItamTamp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          children: [
            Image.asset('Image/logo_gair.png'),
            TextButton(onPressed: () {}, child: Text('+')),
            TextButton(onPressed: () {}, child: Text('-')),
          ],
        ),
      ),
    );
  }
}
