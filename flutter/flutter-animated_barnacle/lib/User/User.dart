class User {
  String id = "";
  String username;
  String email;
  String password;

  User({
    required id,
    required this.username,
    required this.email,
    required this.password, 
  });

  // Method to convert JSON data into a User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],  // Avoid storing password in production
    );
  }

  // Method to convert a User object into JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password, // Avoid sending plain text passwords
    };
  }

}