import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObsecureText = false,
  });
  final String hintText;
  final TextEditingController controller;
  final bool isObsecureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return hintText;
        }
        return null;
      },
      controller: controller,
      obscureText: isObsecureText,
    );
  }
}
