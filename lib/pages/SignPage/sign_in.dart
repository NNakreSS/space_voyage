import 'package:flutter/material.dart';
import 'package:space_voyage/pages/SignPage/sign_up.dart';
import 'package:space_voyage/services/auth_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
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
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.grey,
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Mail',
                    labelStyle:
                        const TextStyle(color: Colors.grey, fontSize: 14),
                    floatingLabelStyle:
                        const TextStyle(color: Colors.white, fontSize: 20),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.blue[300],
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10.0),
                    border: const OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[300]!)),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.grey,
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle:
                        const TextStyle(color: Colors.grey, fontSize: 14),
                    floatingLabelStyle:
                        const TextStyle(color: Colors.white, fontSize: 20),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.blue[300],
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10.0),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue[300]!)),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  fixedSize:
                      Size.fromWidth(MediaQuery.of(context).size.width / 2),
                  backgroundColor: Colors.blue,
                ),
                onPressed: () async {
                  final email = _usernameController.text;
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
              ),
              const SizedBox(height: 10),
              Row(
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
              ),
            ],
          ),
        ),
      );
}
