import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bibliogram/presentations/auth/login_register.dart';
import 'package:bibliogram/utils/themes.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: lightTheme,
      dark: darkTheme,
      initial: AdaptiveThemeMode.dark,
      builder: (theme, themeDark) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: themeDark,
          theme: theme,
          home: const LoginOrRegister(),
        );
      },
    );
  }
}
