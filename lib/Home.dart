import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _email = '';

  @override
  void initState() {
    // TODO: implement initState
    getalldata();
    super.initState();
  }

  getalldata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('email').toString() ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome " + _email),
        backgroundColor: Colors.tealAccent,
        centerTitle: true,
      ),
      body: Container(
        child: TextButton(
          style: TextButton.styleFrom(
          textStyle: TextStyle(
            height: 1.2,
            fontSize: 13,
            color: Colors.blue,
            fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () async{
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.clear();
          },
          child: const Text('Logout'),
        )
      ),
    );
  }
}
