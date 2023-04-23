import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  void createAccount() async {
    String name = emailController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    //creating new account
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      if(userCredential.user != null) {
        Fluttertoast.showToast(
          msg: 'Registration Successful!\nPlease Login to your account',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          fontSize: 16,
          backgroundColor: kPrimaryColor,
          textColor: Colors.white,
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen())
        );
      }
    } on FirebaseAuthException catch(ex) {
      Fluttertoast.showToast(
        msg: ex.message!,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        fontSize: 16,
        backgroundColor: kPrimaryColor,
        textColor: Colors.white,
      );
    }
  }
 
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
            controller: nameController,
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
            controller: emailController,
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
              controller: passwordController,
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
              controller: cPasswordController,
              validator: (value) {
                if(value == null) return '* Required';
                if(value != passwordController.text.trim()) return 'Passwords do not match';
                return null;
              },
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
              createAccount();
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