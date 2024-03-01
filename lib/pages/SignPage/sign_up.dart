import 'package:flutter/material.dart';
import 'package:space_voyage/Helpers/validate.dart';
import 'package:space_voyage/widgets/text_field.dart';
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
  final _formKey = GlobalKey<FormState>();
  String _errorMessage = "";

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
              signUpForm(context),
            ],
          ),
        ),
      );

  Form signUpForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          nameFields(context),
          const SizedBox(height: 10),
          mailField(context),
          const SizedBox(height: 10.0),
          passwordField(context),
          const SizedBox(height: 30.0),
          if (_errorMessage != "") errorMessage(),
          const SizedBox(height: 30.0),
          signUpButton(),
        ],
      ),
    );
  }

  Text errorMessage() {
    return Text(
      _errorMessage,
      style: const TextStyle(
        color: Colors.red,
        fontSize: 12,
      ),
    );
  }

  ElevatedButton signUpButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        backgroundColor: Colors.blue,
      ),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          final email = _usermailController.text;
          final password = _passwordController.text;
          final firstname = _firstnameController.text;
          final lastname = _lastnameController.text;
          final name = "$firstname $lastname";
          final error = await AuthService()
              .signUp(name: name, email: email, password: password);
          if (error == null) {
            Navigator.pop(context);
          } else {
            _errorMessage = error;
          }
        }
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
        keyboardType: TextInputType.visiblePassword,
        validator: isEmptyFieldValitede,
      ),
    );
  }

  SizedBox mailField(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: CustomTextFormField(
        controller: _usermailController,
        labelText: "E-mail",
        icon: Icons.mail,
        keyboardType: TextInputType.emailAddress,
        validator: emailValidator,
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
              validator: isEmptyFieldValitede,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: CustomTextFormField(
              controller: _lastnameController,
              labelText: "Last Name",
              icon: Icons.person,
              validator: isEmptyFieldValitede,
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
