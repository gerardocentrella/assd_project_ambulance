import 'dart:async';

import 'package:assd_project_ambulance/models/entities/User.dart';

//forse inutile

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(
      const Duration(milliseconds: 300),
          () => _user = const User("prova"),
    );
  }
}