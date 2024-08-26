import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api extends StatefulWidget {
  const Api({super.key});

  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {

  Map<String, dynamic>? albumData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    http.Response response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
    if (response.statusCode == 200) {
      setState(() {
        albumData = jsonDecode(response.body);
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Integration" ),
        backgroundColor: Colors.tealAccent,
        centerTitle: true,
      ),
      body: albumData != null
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Album ID: ${albumData!['id']}'),
            Text('Title: ${albumData!['title']}'),
            Text('User ID: ${albumData!['userId']}'),
          ],
        ),
      )
      : Center(child: CircularProgressIndicator()),
    );
  }
}
