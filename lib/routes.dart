import 'package:firebase_007/screens/home/add_note_screen.dart';
import 'package:firebase_007/screens/home/home.dart';
import 'package:firebase_007/screens/login.dart';
import 'package:firebase_007/screens/navbar_screen.dart';
import 'package:firebase_007/screens/reset_password.dart';
import 'package:firebase_007/screens/sign_up.dart';
import 'package:flutter/material.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavBarScreen.id:
        return MaterialPageRoute(builder: (_) => NavBarScreen());

      case SignUpScreen.id:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      case LoginScreen.id:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case ResetPasswordScreen.id:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());

      case Home_Screen.id:
        return MaterialPageRoute(builder: (_) => const Home_Screen());

      case Add_Screen.id:
        return MaterialPageRoute(builder: (_) => const Add_Screen());

      // case Edit_Screen.id:
      //   return MaterialPageRoute(
      //       builder: (_) =>
      //           Edit_Screen([Note(id, subtitle, time, image, title, isDon)]));

      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(child: Text('Something went wrong')),
                ));
    }
  }
}
