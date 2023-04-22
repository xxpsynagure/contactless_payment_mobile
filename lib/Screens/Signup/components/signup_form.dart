import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../components/already_have_an_account_acheck.dart';
import 'package:contactless_payment_mobile/utils/styles.dart';
import '../../Login/login_screen.dart';


class SignUpForm extends StatefulWidget {
  const SignUpForm({ Key? key }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}
class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
            child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (name) {},
            validator: MultiValidator([
              RequiredValidator(errorText: "* Required"),
            ]),
            decoration: InputDecoration(
              hintText: "Your Name",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
            child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            validator: MultiValidator([
              RequiredValidator(errorText: "* Required"),
              EmailValidator(errorText: "Enter valid email id"),
            ]),
            decoration: InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              validator: MultiValidator([
                RequiredValidator(errorText: "* Required"),
                MinLengthValidator(6,errorText: "Password should be atleast 6 characters"),
              ]),
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              validator: MultiValidator([
                RequiredValidator(errorText: "* Required"),
                MinLengthValidator(6,errorText: "Password should be atleast 6 characters"),
              ]),
              decoration: InputDecoration(
                hintText: "Confirm Password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding ),
          Hero(
            tag: "signup_btn",
            child: ElevatedButton(
            onPressed: () {
              if (formkey.currentState!.validate()) {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen())
              );
              print("Validated");
              } else {
                print("Not Validated");
              }
            },
            child: Text("Sign Up".toUpperCase()),
          ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}