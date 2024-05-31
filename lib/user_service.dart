import 'dart:convert';
import 'package:http/http.dart' as http;

class Name {
  final String first;
  final String last;

  const Name ({
    required this.first,
    required this.last,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(first: json['first'], last: json['last']);
  }
}

class User {
  final String email;
  final String picture;
  final Name name;

  const User ({
    required this.email,
    required this.picture,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json['email'],
        picture: json['picture']['medium'],
        name: Name.fromJson(json['name']));
  }
}

class UserService {
  Future<List<User>> getUsers() async {
    try {
      final response = await http.get(
        Uri.parse("https://randomuser.me/api?results=5"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<User> userList = [];

        for (var entry in data['results']) {
          userList.add(User.fromJson(entry));
        }

        return userList;
      } else {
        throw Exception('Failed to load users. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server. Error: $e');
    }
  }
}