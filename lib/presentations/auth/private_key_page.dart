import 'package:bibliogram/components/text_link_button.dart';
import 'package:bibliogram/presentations/auth/login_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PrivateKeyPage extends StatelessWidget {
  final String privateKey;
  const PrivateKeyPage({super.key, required this.privateKey});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
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
                    '''Eureka!\nYou are registered successfully
                    \nThis is your Private key''',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: TextEditingController(text: privateKey),
                    readOnly: true,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 244, 123, 3),
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextLinkButton(
                    text: 'Copy key and login now',
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: privateKey),
                      );
                      Get.offAll(() => const LoginOrRegister());
                    },
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
