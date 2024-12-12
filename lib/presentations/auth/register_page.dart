import 'package:bibliogram/components/mini_button.dart';
import 'package:bibliogram/components/text_form_field.dart';
import 'package:bibliogram/components/text_link_button.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function() onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Let\'s get you onboarded 🚀',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                AppTextFormField(
                  hint: 'Fullname',
                  textEditingController: nameController,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Mandatory';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                AppTextFormField(
                  hint: 'Username',
                  textEditingController: usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mandatory';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 36.0),
                MiniButton(
                  loadingIndicatorToggle: false,
                  onPressed: () {},
                ),
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a grammer?',
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.labelMedium?.fontSize,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                    TextLinkButton(
                      text: 'Login',
                      onPressed: widget.onTap,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
