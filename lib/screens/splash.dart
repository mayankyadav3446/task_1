import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_1/router/router.dart';

class Splash extends ConsumerStatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  ConsumerState<Splash> createState() => _SplashState();
}

class _SplashState extends ConsumerState<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 2), () async {
      navigate();
    });
  }

  void navigate() async {
    try {
      var getSharedPrefData = await SharedPreferences.getInstance();
      String? token = getSharedPrefData.getString('token');
      print("token: $token");

      //await Future.delayed(const Duration(seconds: 2)); // Wait for 2 seconds

      if (token == null) {
        print("Navigate to login");
        if (mounted) {
          context.goNamed(MyAppRouter.login);
        }
      } else {
        print("Navigate to dashboard");
        if (mounted) {
          context.goNamed(MyAppRouter.dashboard);
        }
      }
    } catch (e) {
      print("Error during navigation: $e");
      // Handle the error or navigate to a default screen if needed.
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Add an animated text widget here
            DefaultTextStyle(
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText('Welcome to My App!'),
                ],
                onTap: () {
                  // You can add onTap behavior here
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
