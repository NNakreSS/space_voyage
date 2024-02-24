import 'package:flutter/material.dart';
import 'package:space_voyage/services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usermailController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              Container(
                margin: const EdgeInsets.all(30),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.grey,
                        controller: _firstnameController,
                        decoration: InputDecoration(
                          labelText: 'First name',
                          labelStyle:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                          floatingLabelStyle: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          prefixIcon: Icon(
                            Icons.person,
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
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.grey,
                        controller: _lastnameController,
                        decoration: InputDecoration(
                          labelText: 'Last name',
                          labelStyle:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                          floatingLabelStyle: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          prefixIcon: Icon(
                            Icons.person,
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
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.grey,
                  controller: _usermailController,
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
              const SizedBox(height: 10.0),
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
              const SizedBox(height: 30.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  final email = _usermailController.text;
                  final password = _passwordController.text;
                  final firstname = _firstnameController.text;
                  final lastname = _lastnameController.text;
                  final name = "$firstname $lastname";
                  AuthService()
                      .signUp(name: name, email: email, password: password);
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}