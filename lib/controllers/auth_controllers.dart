import 'package:flutter/foundation.dart';

class AuthControllers with ChangeNotifier {
  String? email;
  String? password;

  AuthControllers({this.email, this.password});

  void updateEmail(String email) => copyWith(email: email);
  void updatePassword(String password) => copyWith(password: password);

  copyWith({String? email,  String? password}) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    notifyListeners();
  }
}
