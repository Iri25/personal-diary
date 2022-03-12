import 'package:diary_app/domain/User.dart';

class UserService{

  User userLogin = User("iri25@gmail.com", "irina25");

  bool login(String username, String password)  {
    if (username == userLogin.email && password == userLogin.password) {
      return true;
    }
    else {
      return false;
    }
  }

}