import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: MyWidget(),
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: Text('Get Data'),
        onPressed: () async {
          var url = Uri.https(
              'www.googleapis.com', '/books/v1/volumes/', {'q': '{http}'});

          var response = await http.get(url);

          var jsonResponse =
              convert.jsonDecode(response.body) as Map<String, dynamic>;
          var itemCount = jsonResponse['items'][0]['volumeInfo'];
          print(itemCount);
        });
  }
}
