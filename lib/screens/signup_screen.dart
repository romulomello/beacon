import 'package:beacon/resources/auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:beacon/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreen createState() => _SignupScreen();
}

class _SignupScreen extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //body: Text('Login screen'),
        body: SafeArea(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Flexible(child: Container(), flex: 2),
            //Logo
            SvgPicture.asset(
              'assets/logo.svg',
              //color: primaryColor,
              height: 100,
            ),
            const SizedBox(height: 24),
            //Username
            TextFieldInput(
              hintText: 'Digite seu nome',
              textInputType: TextInputType.text,
              textEditingController: _usernameController,
            ),
            const SizedBox(height: 12),
            //Email
            TextFieldInput(
              hintText: 'Digite seu email',
              textInputType: TextInputType.emailAddress,
              textEditingController: _emailController,
            ),
            const SizedBox(height: 12),
            //Senha
            TextFieldInput(
              hintText: 'Digite sua senha',
              textInputType: TextInputType.text,
              textEditingController: _passwordController,
              isPass: true,
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () async {
                String res = await AuthMethods().SignUpUser(
                  username: _usernameController.text,
                  email: _emailController.text,
                  password: _passwordController.text,
                  file: 
                );
                print(res);
              },
              child: Container(
                child: const Text('REGISTRAR',
                    style:
                        TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
            //const SizedBox(height: 10),
            Flexible(child: Container(), flex: 2), //

            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                child: const Text("Já possui login? "),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  child: const Text(
                    "Entre aqui",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ), //
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                ),
              ),
            ])
          ])),
    ));
  }
}
