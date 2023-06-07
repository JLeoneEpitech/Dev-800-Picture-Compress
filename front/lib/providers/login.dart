import 'package:flutter/material.dart';
import '../globals/exceptions.dart';
import '../services/api.dart';

class LoginProvider extends ChangeNotifier {
  // bool isLogin = false;

  Future<void> login(
      BuildContext context, String username, String password) async {
    try {
      // isLogin = true;
      notifyListeners();
      print("provider");

      await Api.getLogin(username, password);
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        (Route<dynamic> route) => false,
      );
      const snackBar = SnackBar(
        content: Text('Connexion successfull'),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (exeption) {
      if (exeption is PendingException) {
        // ExceptionHelper.handle(context, exeption);
      } else {
        rethrow;
      }
    } finally {
      // isLogin = false;
      notifyListeners();
    }
  }
}
