import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:reminders_app/core/utils/appstrings.dart';
import 'package:reminders_app/core/utils/responsive.dart';
import 'package:reminders_app/features/reminders/view/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Image.asset(
                AppStrings.appIcon,
              ),
            ),
            const Expanded(child: AutoSizeText(AppStrings.appName)),
          ],
        ),
        backgroundColor: const Color(0xFF1A2127),
        splashIconSize: Responsive.getWidth(context) * .60,
        splashTransition: SplashTransition.scaleTransition,
        nextScreen: const HomeScreen());
  }
}
