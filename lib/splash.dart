import 'package:flutter/material.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {

  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
  }

  startTimer(){

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.tealAccent,
      child: Container(
        child: Image.asset("assets/logo.png"),
      ),
    );
  }
}
