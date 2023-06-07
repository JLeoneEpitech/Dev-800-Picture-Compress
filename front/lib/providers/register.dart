import 'package:flutter/material.dart';
import '../globals/exceptions.dart';
import '../services/api.dart';

class RegisterProvider extends ChangeNotifier {

  Future<void> register(
      BuildContext context, String password, String username) async {
    try {
      notifyListeners();

      await Api.getRegister(password, username);
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
        (Route<dynamic> route) => false,
      );
      const snackBar = SnackBar(
        content: Text('Register successfull'),
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
      notifyListeners();
    }
  }
}