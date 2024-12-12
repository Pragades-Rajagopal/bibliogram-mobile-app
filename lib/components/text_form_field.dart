import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;
  final bool obscureText;
  const AppTextFormField({
    super.key,
    required this.hint,
    required this.textEditingController,
    required this.validator,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      validator: validator,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 22.0),
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontSize: 20.0,
        ),
        errorStyle: const TextStyle(
          fontSize: 14.0,
          color: Colors.red,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ),
      cursorColor: Theme.of(context).colorScheme.secondary,
    );
  }
}
