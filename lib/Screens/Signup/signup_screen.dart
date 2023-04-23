import 'package:flutter/material.dart';
import 'package:contactless_payment_mobile/utils/styles.dart';
import 'package:contactless_payment_mobile/responsive.dart';
import '../../components/background.dart';
import 'components/sign_up_top_image.dart';
import 'components/signup_form.dart';
import 'components/socal_sign_up.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key, required this.qrdata}) : super(key: key);
  final qrdata;
  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileSignupScreen(qrdata: qrdata),
          desktop: Row(
            children: [
              const Expanded(
                child: SignUpScreenTopImage(),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 450,
                      child: SignUpForm(palmId: qrdata),
                    ),
                    SizedBox(height: defaultPadding / 2),
                    // SocalSignUp()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MobileSignupScreen extends StatelessWidget {
  const MobileSignupScreen({
    Key? key, required this.qrdata
  }) : super(key: key);
  final qrdata;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: defaultPadding),
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SignUpScreenTopImage(),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: SignUpForm(palmId: qrdata),
            ),
            Spacer(),
          ],
        ),
        // const SocalSignUp()
      ],
    )
      ),
    ); 
  }
}
