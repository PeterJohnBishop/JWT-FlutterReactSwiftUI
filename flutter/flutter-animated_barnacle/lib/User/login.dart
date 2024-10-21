import 'package:flutter/material.dart';
import 'UserService.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    void login() async {
      final username = _usernameController.text;
      final password = _passwordController.text;

      if (username.isEmpty || password.isEmpty) {
        userService.showErrorDialog("Please complete the form.", context);
      } else {
        bool loggedIn = await userService.authenticateUser(username, password);
          if(loggedIn) {
            print("Successfully authenticated user!");
          } else {
            print("Error logging in!");
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
