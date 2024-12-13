import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bibliogram/presentations/auth/login_register.dart';
import 'package:bibliogram/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: lightTheme,
      dark: darkTheme,
      initial: AdaptiveThemeMode.light,
      builder: (theme, themeDark) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: themeDark,
          theme: theme,
          home: const LoginOrRegister(),
        );
      },
    );
  }
}
