import 'package:firebase_007/components/custom_button.dart';
import 'package:firebase_007/components/custom_textfield.dart';
import 'package:firebase_007/components/snackbar.dart';
import 'package:firebase_007/components/theme_provider.dart';
import 'package:firebase_007/core/authentication_service.dart';
import 'package:firebase_007/core/firebase_exceptions.dart';
import 'package:firebase_007/screens/home/home.dart';
import 'package:firebase_007/screens/navbar_screen.dart';
import 'package:firebase_007/screens/reset_password.dart';
import 'package:firebase_007/screens/sign_up.dart';
import 'package:firebase_007/utils/loader.dart';
import 'package:firebase_007/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthenticationService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
        appBar: AppBar(
          actions: [
            const SizedBox(width: 10),
            const Text('Go Dark'),
            Switch(
              value: themeProvider.themeMode == ThemeMode.dark,
              onChanged: (_) {
                themeProvider.toggleTheme();
              },
            ),
          ],
        ),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 50.0, bottom: 25.0),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(child: SizedBox(height: 70)),
                  const Text(
                    'Let us know who you are!',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Log into your account.',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Email address',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: 'abc@example.com',
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    validator: (value) => Validator.validateEmail(value ?? ""),
                    controller: _emailController,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: '********',
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    maxLength: 8,
                    controller: _passwordController,
                    textCapitalization: TextCapitalization.none,
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.0, vertical: 0.0),
                    child: Text(
                      'Have you forgotten your password?',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, ResetPasswordScreen.id),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 0.0),
                    ),
                    child: const Text(
                      'Click here to recover it.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  CustomButton(
                    label: 'LOG IN',
                    color: Colors.black,
                    onPressed: () async {
                      if (_key.currentState!.validate()) {
                        LoaderX.show(context);
                        final _status = await _authService.login(
                          email: _emailController.text.trim(),
                          password: _passwordController.text,
                        );

                        if (_status == AuthStatus.successful) {
                          LoaderX.hide();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            NavBarScreen.id,
                            (Route<dynamic> route) => false,
                          );
                        } else {
                          LoaderX.hide();
                          final error =
                              AuthExceptionHandler.generateErrorMessage(
                                  _status);
                          CustomSnackBar.showErrorSnackBar(
                            context,
                            message: error,
                          );
                        }
                      }
                    },
                    size: size,
                    textColor: Colors.white,
                    borderSide: BorderSide.none,
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, SignUpScreen.id),
                    child: RichText(
                      text: const TextSpan(
                        text: "Don't have an acccount? ",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign up here',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      textScaler: const TextScaler.linear(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
