import 'package:blog/controller/user_controller.dart';
import 'package:blog/util/validator_util.dart';
import 'package:blog/view/components/custom_elevated_button.dart';
import 'package:blog/view/components/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JoinPage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  final _username = TextEditingController();
  final _password = TextEditingController();
  final _email = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uc = ref.read(userControllerProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              height: 200,
              child: Text(
                "회원가입 페이지",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _joinForm(uc),
          ],
        ),
      ),
    );
  }

  Widget _joinForm(UserController uc) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            hint: "Username",
            funValidator: validateUsername(),
            controller: _username,
          ),
          CustomTextFormField(
            hint: "Password",
            funValidator: validatePassword(),
            controller: _password,
          ),
          CustomTextFormField(
            hint: "Email",
            funValidator: validateEmail(),
            controller: _email,
          ),
          CustomElevatedButton(
            text: "회원가입",
            funPageRoute: () {
              if (_formKey.currentState!.validate()) {
                uc.join(
                  username: _username.text.trim(),
                  password: _password.text.trim(),
                  email: _email.text.trim(),
                );
              }
            },
          ),
          TextButton(
            onPressed: () {
              uc.loginForm();
            },
            child: Text("로그인 페이지로 이동"),
          ),
        ],
      ),
    );
  }
}
