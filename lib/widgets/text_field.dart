import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool? password;
  final bool? autoFocus;
  final int? maxLine;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  const CustomTextFormField(
      {Key? key,
      this.password,
      this.maxLine,
      this.autoFocus,
      this.keyboardType,
      this.validator,
      required this.controller,
      required this.labelText,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) => TextFormField(
        autofocus: autoFocus ?? false,
        keyboardType: keyboardType,
        maxLines: maxLine ?? 1,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.grey,
        controller: controller,
        obscureText: password ?? false,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          floatingLabelStyle:
              const TextStyle(color: Colors.white, fontSize: 20),
          prefixIcon: Icon(
            icon,
            color: Colors.blue[300],
          ),
          contentPadding: const EdgeInsets.all(16),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue[300]!)),
        ),
        validator: validator,
      );
}
