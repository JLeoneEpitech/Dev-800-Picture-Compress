import 'package:flutter/material.dart';
import '../globals/decoration.dart';
import '../providers/register.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  void _onRegister() async {
    String password = passwordController.text;
    String username = usernameController.text;
    await context
        .read<RegisterProvider>()
        .register(context, password, username);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: const Icon(Icons.arrow_back_ios_new),
          iconSize: 20,
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Material(
          child: Column(
            children: [
              const SizedBox(
                height: 70,
              ),
              Image.asset(
                'assets/images/photo.png',
                scale: 3,
              ),
              Form(
                  child: Column(
                children: [
                  SizedBox(
                    width: size.width,
                    height: size.height / 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your username',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter your password',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 50, right: 50),
                  //   child: TextFormField(
                  //     obscureText: true,
                  //     decoration: const InputDecoration(
                  //       border: OutlineInputBorder(),
                  //       hintText: 'Verify your password',
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 50, right: 50),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(color: black)),
                        ),
                        onPressed: _onRegister,
                        child: const Text(
                          "Inscription",
                          style: TextStyle(
                            color: black,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
