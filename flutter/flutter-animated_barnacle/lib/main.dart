import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

      void showErrorDialog(String message) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }

      void showSuccessDialog(String message) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Success"),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigate to the next page if login is successful
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }

      Future<void> authenticateUser(String username, String password) async {
        //https://pub.dev/packages/shared_preferences
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        final response = await http.post(
          Uri.parse('http://127.0.0.1:8080/users/auth'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'username': username,
            'password': password
          }),
        );

              // Decode the response body
        var data = jsonDecode(response.body);

        // Make sure you access 'jwt' properly from the decoded data
        if (data.containsKey('jwt')) {
          await prefs.setString('jwt', data['jwt'].toString());
          final String? token = prefs.getString('jwt');
          print('Data posted: $token');
          showSuccessDialog("Login Successful!");
        } else {
          throw Exception('JWT token not found in response');
        }
  }

    void login() {
      final username = _usernameController.text;
      final password = _passwordController.text;

      if (username.isEmpty || password.isEmpty) {
        showErrorDialog("Please enter both username and password.");
      } else {
        // Add your authentication logic here (like calling an API)
        print("Logging in with username: $username and password: $password");
        authenticateUser(username, password);
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: 
            Text("Login", style: TextStyle(fontStyle: FontStyle.italic),),
            ),
            // Username Field
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Password Field
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32),

            // Login Button
            ElevatedButton(
              onPressed: login,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
