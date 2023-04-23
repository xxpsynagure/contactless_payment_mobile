import 'package:contactless_payment_mobile/Screens/Welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import '../../../utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:contactless_payment_mobile/Screens/Login/components/login_screen_top_image.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override 
  State<StatefulWidget> createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const WelcomeScreen())
    );  
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
            child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const LoginScreenTopImage(),
        const SizedBox(height: defaultPadding*2),
          Hero(
            tag: "logOut_btn",
            child: ElevatedButton(
              onPressed: () {
                logOut();
              },
              child: Text(
                "Log Out".toUpperCase(),
              ),
            ),
          ),
      ],
            ),
          ),
      ),
    );
  }
}
