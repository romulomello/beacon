import 'package:beacon/resposive/mobile_screen_layout.dart';
import 'package:beacon/resposive/resposive_layout_screen.dart';
import 'package:beacon/resposive/web_screen_layout.dart';
import 'package:beacon/screens/home_screen.dart';
import 'package:beacon/screens/signup_screen.dart';
import 'package:beacon/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:beacon/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:beacon/resources/auth_methods.dart';

import '../widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == "Logado com sucesso") {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
          (route) => false);
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
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
            Flexible(child: Container(), flex: 1),
            //Logo
            SvgPicture.asset(
              'assets/logo.svg',
              //color: primaryColor,
              height: 100,
            ),
            const SizedBox(height: 54),
            //Email
            TextFieldInput(
              hintText: 'Digite seu email',
              textInputType: TextInputType.emailAddress,
              textEditingController: _emailController,
            ),
            const SizedBox(height: 16),
            //Senha
            TextFieldInput(
              hintText: 'Digite sua senha',
              textInputType: TextInputType.text,
              textEditingController: _passwordController,
              isPass: true,
            ),
            const SizedBox(height: 18),
            InkWell(
              child: Container(
                child: !_isLoading
                    ? const Text('ENTRAR',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)))
                    : const Center(
                        child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 255, 255, 255))),
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
              onTap: loginUser,
            ),
            //const SizedBox(height: 10),
            Flexible(child: Container(), flex: 2), //

            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                child: const Text("Não possui login? "),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const SignupScreen()));
                },
                child: Container(
                  child: const Text(
                    "Registre-se",
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
