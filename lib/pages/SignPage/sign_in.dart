import 'package:flutter/material.dart';
import 'package:space_voyage/components/text_field.dart';
import 'package:space_voyage/pages/SignPage/sign_up.dart';
import 'package:space_voyage/services/auth_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _usermailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usermailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              header(),
              mailField(context),
              const SizedBox(height: 20.0),
              passwordField(context),
              const SizedBox(height: 20.0),
              loginButton(context),
              const SizedBox(height: 10),
              createAccountTextButton(context),
            ],
          ),
        ),
      );

  Container header() {
    return Container(
      margin: const EdgeInsets.all(30),
      child: const Text(
        "Sign In",
        style: TextStyle(fontSize: 40, color: Colors.white),
      ),
    );
  }

  Row createAccountTextButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Not registered yet ?',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpPage()),
            );
          },
          child: Text(
            'Create an account',
            style: TextStyle(
              color: Colors.blue[100]!,
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );
  }

  ElevatedButton loginButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        fixedSize: Size.fromWidth(MediaQuery.of(context).size.width / 2),
        backgroundColor: Colors.blue,
      ),
      onPressed: () async {
        final email = _usermailController.text;
        final password = _passwordController.text;
        AuthService().signIn(email: email, password: password);
      },
      child: const Text(
        'Login',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  SizedBox passwordField(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: CustomTextFormField(
        controller: _passwordController,
        labelText: "Password",
        icon: Icons.lock,
      ),
    );
  }

  SizedBox mailField(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: CustomTextFormField(
        controller: _usermailController,
        labelText: "Mail",
        icon: Icons.mail,
      ),
    );
  }
}
