import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bibliogram/presentations/app/base.dart';
import 'package:bibliogram/presentations/auth/login_register.dart';
import 'package:bibliogram/storage/local/data.dart';
import 'package:bibliogram/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Get user token data
  final userData = await UserToken().getTokenData();
  final String token = userData["token"] ?? '';
  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String token;
  const MyApp({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: lightTheme,
      dark: darkTheme,
      initial: AdaptiveThemeMode.dark,
      builder: (theme, themeDark) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: themeDark,
          theme: theme,
          home: token.isEmpty ? const LoginOrRegister() : const AppBasePage(),
        );
      },
    );
  }
}
