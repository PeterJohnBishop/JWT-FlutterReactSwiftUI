import 'package:animated_barnacle/User/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  late User user;
  late List<User> users;
  final String baseUrl = "http://127.0.0.1:4001/users";

  void showErrorDialog(String message, context) {
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

      void showSuccessDialog(String message, context) {
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
          Uri.parse('$baseUrl/create'),
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
            user = User.fromJson(data);  
            return true;
        } else {
            return false;
        }
  }

  Future<bool> authenticateUser(String username, String password) async {
        //https://pub.dev/packages/shared_preferences
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        final response = await http.post(
          Uri.parse('$baseUrl/users/auth'),
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
          return true;
        } else {
          return false;
        }
  }

  Future<bool> getUser(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
            user = User.fromJson(data);  
            return true;
    } else {
      return false;
    }
  }

  Future<bool> getAllUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List;
      users = data.map((userJson) => User.fromJson(userJson)).toList();
            return true;
    } else {
      return false;
    }
  }

  // Update (PUT)
  Future<bool> updateUser(User user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$user.id'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': user.username,
        'email': user.email,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Delete (DELETE)
  Future<bool> deleteUser(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

}