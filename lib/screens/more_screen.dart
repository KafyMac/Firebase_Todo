import 'package:firebase_007/components/custom_button.dart';
import 'package:firebase_007/core/authentication_service.dart';
import 'package:firebase_007/screens/login.dart';
import 'package:firebase_007/utils/loader.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'More',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/blank-dp.png'),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Hi ${AuthenticationService.auth.currentUser!.displayName}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Welcome to your profile',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Email: ${AuthenticationService.auth.currentUser!.email}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 100,
              child: CustomButton(
                label: 'LOGOUT',
                color: Colors.black,
                onPressed: () async {
                  LoaderX.show(context);
                  await AuthenticationService.auth.signOut().then((value) {
                    LoaderX.hide();
                    Navigator.pushNamedAndRemoveUntil(
                        context, LoginScreen.id, (route) => false);
                  });
                },
                size: size,
                textColor: Colors.white,
                borderSide: BorderSide.none,
              ),
            )
          ],
        ),
      ),
    );
  }
}
