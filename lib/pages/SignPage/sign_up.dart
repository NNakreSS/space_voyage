import 'package:flutter/material.dart';
import 'package:space_voyage/components/text_field.dart';
import 'package:space_voyage/services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usermailController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usermailController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
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
              nameFields(context),
              const SizedBox(height: 10),
              mailField(context),
              const SizedBox(height: 10.0),
              passwordField(context),
              const SizedBox(height: 30.0),
              signUpButton(),
            ],
          ),
        ),
      );

  ElevatedButton signUpButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        backgroundColor: Colors.blue,
      ),
      onPressed: () async {
        final email = _usermailController.text;
        final password = _passwordController.text;
        final firstname = _firstnameController.text;
        final lastname = _lastnameController.text;
        final name = "$firstname $lastname";
        final isSignUp = await AuthService()
            .signUp(name: name, email: email, password: password);
        if (isSignUp != null) Navigator.pop(context);
      },
      child: const Text(
        'Sign Up',
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
        password: true,
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

  SizedBox nameFields(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: CustomTextFormField(
              controller: _firstnameController,
              labelText: "First Name",
              icon: Icons.person,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: CustomTextFormField(
              controller: _lastnameController,
              labelText: "Last Name",
              icon: Icons.person,
            ),
          ),
        ],
      ),
    );
  }

  Container header() {
    return Container(
      margin: const EdgeInsets.all(30),
      child: const Text(
        "Sign Up",
        style: TextStyle(fontSize: 40, color: Colors.white),
      ),
    );
  }
}
