import 'dart:typed_data';

import 'package:beacon/resources/auth_methods.dart';
import 'package:beacon/resposive/mobile_screen_layout.dart';
import 'package:beacon/resposive/resposive_layout_screen.dart';
import 'package:beacon/resposive/web_screen_layout.dart';
import 'package:beacon/screens/login_screen.dart';
import 'package:beacon/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
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
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void singUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().SignUpUser(
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      file: _image!,
    );
    setState(() {
      _isLoading = false;
    });

    if (res != "Registrado com Sucesso") {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    }

    // ignore: avoid_print
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        //body: Text('Login screen'),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              width: double.infinity,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(child: Container(), flex: 1),
                    //Logo
                    SvgPicture.asset(
                      'assets/logo.svg',
                      //color: primaryColor,
                      height: 50,
                    ),
                    const SizedBox(height: 24),
                    Stack(
                      children: [
                        _image != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(_image!),
                              )
                            : const CircleAvatar(
                                radius: 64,
                                backgroundImage: NetworkImage(
                                    'https://t4.ftcdn.net/jpg/02/15/84/43/360_F_215844325_ttX9YiIIyeaR7Ne6EaLLjMAmy4GvPC69.jpg'),
                              ),
                        Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
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
                      onTap: singUpUser,
                      child: Container(
                        child: _isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                    color: Color.fromARGB(255, 255, 255, 255)))
                            : const Text('REGISTRAR',
                                style: TextStyle(
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
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
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
