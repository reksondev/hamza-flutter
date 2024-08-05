import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Node js test"),
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: () async {
               final response = await http.get( Uri.parse('http://localhost:3000/api/data')); //http://192.168.1.133

               // ignore: avoid_print
               print('RESPONSEFROM NODE JS ${response.body}');

          },
           child: const Text("Connect To Node Js" , style: TextStyle(color: Colors.blueGrey),),
          ),
          ),
          ),
    );
  }
}

