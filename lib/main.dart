import 'package:firebase_007/components/theme_provider.dart';
import 'package:firebase_007/routes.dart';
import 'package:firebase_007/screens/login.dart';
import 'package:firebase_007/screens/navbar_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  // More light theme properties here
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.indigo,
  // More dark theme properties here
);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final user = FirebaseAuth.instance.currentUser;
  runApp(MyApp(initialRoute: user != null ? NavBarScreen.id : LoginScreen.id));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'Checklist',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            initialRoute: initialRoute,
            themeMode: themeProvider.themeMode,
            onGenerateRoute: MyRouter.generateRoute,
          );
        },
      ),
    );
  }
}
