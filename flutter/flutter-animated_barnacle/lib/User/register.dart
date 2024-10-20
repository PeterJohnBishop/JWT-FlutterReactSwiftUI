import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController = TextEditingController();


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

      Future<bool> createUser(String username, String email,  String password) async {

        final response = await http.post(
          Uri.parse('http://127.0.0.1:8080/users/create'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'username': username,
            'email': email,
            'password': password
          }),
        );

        if(response.statusCode == 200) {
            var data = jsonDecode(response.body);
            showSuccessDialog("Account created! $data Logging you in!");
            return true;
        } else {
            throw Exception('Oops! New user request denied!');
        }
  }

  Future<bool> authenticateUser(String username, String password) async {
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
          return true;
        } else {
          throw Exception('JWT token not found in response');
        }
  }

    // void login() async {
    //   final username = _usernameController.text;
    //   final password = _passwordController.text;

    //   if (username.isEmpty || password.isEmpty) {
    //     showErrorDialog("Please enter both username and password.");
    //   } else {
    //     // Add your authentication logic here (like calling an API)
    //     print("Logging in with username: $username and password: $password");
    //     authenticateUser(username, password);
    //   }
    // }

    void register() async {
      final username = _usernameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;

      if (username.isEmpty || email.isEmpty || password.isEmpty) {
        showErrorDialog("Please complete the form.");
      } else {
        print("Creating user acount");
        bool created = await createUser(username, email, password);
        if(created) {
          bool loggedIn = await authenticateUser(username, password);
          if(loggedIn) {
            print("Successfully created and authenticated user!");
          } else {
            print("something went wrong.");
          }
        }
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
            Text("Register", style: TextStyle(fontStyle: FontStyle.italic),),
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

            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
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
              onPressed: register,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}