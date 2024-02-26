import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;

  const CustomTextFormField(
      {Key? key,
      required this.controller,
      required this.labelText,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) => TextFormField(
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.grey,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          floatingLabelStyle:
              const TextStyle(color: Colors.white, fontSize: 20),
          prefixIcon: Icon(
            icon,
            color: Colors.blue[300],
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[300]!)),
        ),
      );
}
