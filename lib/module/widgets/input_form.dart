import 'package:flutter/material.dart';

class CustomInputForm extends StatelessWidget {
  final TextEditingController? controller;
  final IconData icon;
  final String label;
  final String hint;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final VoidCallback? onTap;
  final bool? readOnly;
  final Widget? suffixIcon;

  const CustomInputForm({
    super.key,
    required this.icon,
    required this.label,
    required this.hint,
    this.obscureText,
    this.keyboardType,
    this.maxLines,
    this.onTap,
    this.readOnly,
    this.controller,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 7,
        ),
        TextFormField(

          controller: controller,
          readOnly: readOnly ?? false,
          onTap: onTap,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
          maxLines: maxLines ?? 1,
          obscureText: obscureText ?? false,
          keyboardType: keyboardType ?? TextInputType.text,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.tealAccent,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
            hintText: hint,
            hintStyle: const TextStyle(
              color: Colors.black,
            ),
            prefixIcon: Icon(
              icon,
              color: Colors.black,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
          ),
        ),
      ],
    );
  }
}
