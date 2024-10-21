import 'package:flutter/material.dart';
import 'UserService.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController = TextEditingController();

    void register() async {
      final username = _usernameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;

      if (username.isEmpty || email.isEmpty || password.isEmpty) {
        userService.showErrorDialog("Please complete the form.", context);
      } else {
        bool created = await userService.createUser(username, email, password);
        if(created) {
          bool loggedIn = await userService.authenticateUser(username, password);
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

            // Email Field
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Confirm Password Field
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32),

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