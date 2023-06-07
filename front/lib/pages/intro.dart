import 'package:flutter/material.dart';
import 'package:front/globals/decoration.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/landing_image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(children: [
          SizedBox(
            width: screenSize.width,
            height: screenSize.height / 3,
          ),
          SizedBox(
            width: screenSize.width,
            height: screenSize.height / 2,
          ),
          SizedBox(
            width: screenSize.width,
            height: screenSize.height / 12,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                ),
                child: const Text(
                  "Connexion",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
          SizedBox(
            width: screenSize.width,
            height: screenSize.height / 12,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text(
                  "Inscription",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
