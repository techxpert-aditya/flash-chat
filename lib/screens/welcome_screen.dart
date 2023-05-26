import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  const WelcomeScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _backgroundColorAnimation;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);

    _backgroundColorAnimation = ColorTween(
      begin: Colors.lightBlueAccent, // Starting color
      end: Colors.white, // Ending color
    ).animate(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          return Scaffold(
            backgroundColor: _backgroundColorAnimation.value,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(
                        height: 60.0,
                        child: Hero(
                          tag: 'logo',
                          child: Image.asset(
                            'images/logo.png',
                          ),
                        ),
                      ),
                      DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 6, 70, 67),
                          fontFamily: 'Agne',
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText('flash chat'),
                            TypewriterAnimatedText('flash talks'),
                            TypewriterAnimatedText('quick chats'),
                            TypewriterAnimatedText('flash chat'),
                          ],
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 48.0,
                  ),
                  RoundedButton(
                      title: 'Log In',
                      color: Colors.lightBlueAccent,
                      onPress: () {
                        //Go to login screen.
                        Navigator.pushNamed(context, LoginScreen.id);
                      }),
                  RoundedButton(
                      title: 'Register',
                      color: Colors.blueAccent,
                      onPress: () {
                        //Go to registration screen.
                        Navigator.pushNamed(context, RegistrationScreen.id);
                      }),
                ],
              ),
            ),
          );
        });
  }
}
