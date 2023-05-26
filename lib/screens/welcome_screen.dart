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
        AnimationController(duration: const Duration(seconds: 1), vsync: this)
          ..repeat(reverse: true);

    _backgroundColorAnimation = ColorTween(
      begin: const Color(0xFF393E46), // Starting color
      end: const Color(0xFF222831), // Ending color
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
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 100, horizontal: 10),
                child: Material(
                  elevation: 50,
                  borderRadius: BorderRadius.circular(25),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: const DecorationImage(
                            image: AssetImage(
                              'images/back.jpg',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white
                              .withOpacity(0.5), // Semi-transparent white color
                        ),
                      ),
                      Center(
                        child: Material(
                          color: Colors.transparent,
                          // elevation: 20,
                          borderRadius: BorderRadius.circular(50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                      fontSize: 45.0,
                                      fontWeight: FontWeight.w900,
                                      color: Color.fromARGB(255, 6, 70, 67),
                                      fontFamily: 'Agne',
                                    ),
                                    child: AnimatedTextKit(
                                      animatedTexts: [
                                        TypewriterAnimatedText(
                                          'flash chat',
                                          speed:
                                              const Duration(milliseconds: 100),
                                        ),
                                        TypewriterAnimatedText(
                                          'flash talks',
                                          speed:
                                              const Duration(milliseconds: 100),
                                        ),
                                        TypewriterAnimatedText(
                                          'quick chats',
                                          speed:
                                              const Duration(milliseconds: 100),
                                        ),
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
                                  color: const Color(0xFF00ADB5),
                                  onPress: () {
                                    //Go to login screen.
                                    Navigator.pushNamed(
                                        context, LoginScreen.id);
                                  }),
                              RoundedButton(
                                  title: 'Register',
                                  color: const Color(0xFF393E46),
                                  onPress: () {
                                    //Go to registration screen.
                                    Navigator.pushNamed(
                                        context, RegistrationScreen.id);
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
