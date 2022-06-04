import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:march_task/core/utils/constants.dart';

import '../../sign-in-up/view/sign_in_view.dart';
import '../../sign-in-up/view/sign_up_view.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Constants.kPrimaryColor,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: Constants.statusBarColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: 'March Health Task',
                          style: TextStyle(
                            color: Constants.kBlackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          )),
                    ])),
                SizedBox(height: size.height * 0.01),
                SizedBox(
                  width: size.width * 0.8,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInView()),
                      );
                    },
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Constants.kPrimaryColor),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Constants.kBlackColor),
                        side: MaterialStateProperty.all<BorderSide>(
                            BorderSide.none)),
                    child: const Text('sign in'),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.8,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpView()),
                      );
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Constants.kGreyColor),
                        side: MaterialStateProperty.all<BorderSide>(
                            BorderSide.none)),
                    child: const Text(
                      'sign up',
                      style: TextStyle(color: Constants.kBlackColor),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
