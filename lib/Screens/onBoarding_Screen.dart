import 'package:e_com/Screens/auth/login_Screen.dart';
import 'package:e_com/Screens/auth/register_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';

class onBoarding extends StatefulWidget {
  const onBoarding({super.key});

  @override
  State<onBoarding> createState() => _onBoardingState();
}

class _onBoardingState extends State<onBoarding> {
  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
        finishButtonText: 'Register',
        onFinish: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const registerScreen(),
            ),
          );
        },
      finishButtonTextStyle: TextStyle(
        color: Theme.of(context).scaffoldBackgroundColor,
        fontSize: 20
      ),

        finishButtonStyle: FinishButtonStyle(
          backgroundColor: Theme.of(context).highlightColor,
        ),
        skipTextButton: Text(
          'Skip',
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).highlightColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Text(
          'Login',
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).highlightColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      skipIcon: Icon(
        CupertinoIcons.arrow_right,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
        trailingFunction: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const logInScreen(),
            ),
          );
        },
        controllerColor: Theme.of(context).highlightColor,
        totalPage: 3,
        headerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        pageBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        background: [
          Image.asset(
            'assets/image1.png',
            height: 400,
            width: 360,
          ),
          Image.asset(
            'assets/image2.png',
            height: 400,
            width: 360,
          ),
          Image.asset(
            'assets/image3.png',
            height: 400,
            width: 360,
          ),
        ],
        speed: 1.8,
        pageBodies: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 480,
                ),
                Text(
                  'Welcome to TechNest  !',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).highlightColor,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                 Text(
                  'Discover products you love, right at your fingertips.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).disabledColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 480,
                ),
                Text(
                  'Your Shopping Adventure Begins!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).highlightColor,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                 Text(
                  'Explore, shop, and save—all in one place.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).disabledColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 480,
                ),
                Text(
                  'Effortless Shopping Awaits',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).highlightColor,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                 Text(
                  'Join us for a seamless shopping experience.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).disabledColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
  }
}
