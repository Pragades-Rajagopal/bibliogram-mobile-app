import 'package:bibliogram/components/common_widgets.dart';
import 'package:bibliogram/components/mini_button.dart';
import 'package:bibliogram/components/text_form_field.dart';
import 'package:bibliogram/components/text_link_button.dart';
import 'package:bibliogram/configurations/constants.dart';
import 'package:bibliogram/presentations/app/base.dart';
import 'package:bibliogram/services/auth.dart';
import 'package:bibliogram/storage/local/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  final void Function() onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final privateKeyController = TextEditingController();
  // Classes
  CommonWidgets commonWidgets = CommonWidgets();
  // State variables
  bool _buttonLoadingIndicator = false;

  // Snackbar helper function
  void _showSnackBar(String message) {
    if (mounted) {
      commonWidgets.showSnackBar(context, message);
    }
  }

  void _toggleButtonLoadingIndicator() =>
      setState(() => _buttonLoadingIndicator = !_buttonLoadingIndicator);

  Future<void> loginReq(String username, String privateKey) async {
    try {
      final response = await AuthApi()
          .login({"username": username, "privateKey": privateKey});
      _toggleButtonLoadingIndicator();
      if (response.statusCode == statusCode["notFound"]) {
        _showSnackBar('${alertDialog["notRegistered"]}');
        return;
      } else if (response.statusCode == statusCode["unauthorized"]) {
        _showSnackBar('${alertDialog["invalidAuth"]}');
        return;
      } else if (response.statusCode == statusCode["serverError"]) {
        _showSnackBar('${alertDialog["commonError"]}');
        return;
      }
      await UserToken().storeTokenData(response.token!);
      Get.offAll(() => const AppBasePage());
    } catch (e) {
      _showSnackBar('${alertDialog["commonError"]}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Login and start taking notes from the books you like the most\n❤️',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0),
                  AppTextFormField(
                    hint: 'Username',
                    textEditingController: usernameController,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return textFieldErrors["username"];
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  AppTextFormField(
                    hint: 'Private key',
                    textEditingController: privateKeyController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return textFieldErrors["privateKey"];
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 36.0),
                  MiniButton(
                    loadingIndicatorToggle: false,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _toggleButtonLoadingIndicator();
                        loginReq(
                            usernameController.text, privateKeyController.text);
                      }
                    },
                    iconColor: Theme.of(context).colorScheme.surface,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a grammer?',
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.labelMedium?.fontSize,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      TextLinkButton(
                        text: 'Register',
                        onPressed: widget.onTap,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
