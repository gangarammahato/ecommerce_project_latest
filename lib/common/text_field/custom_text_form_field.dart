import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.label,
    this.controller,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0, top: 8.0),
      child: TextFormField(
        cursorColor: Colors.black38,
        style: const TextStyle(color: Colors.black54),
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          //fillColor: Colors.black26,
          fillColor: Colors.grey.shade400,
          //  border: BorderSide.none,
          //         borderRadius: BorderRadius.circular(50),
          //contentPadding: EdgeInsets.all(20.0),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
          hintStyle: const TextStyle(
            color: Colors.black54,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          labelText: label,
          //lable style
          labelStyle: const TextStyle(
            color: Colors.black54,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),

          // labelText: label,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            // borderRadius: BorderRadius.circular(50.0)
          ),
          errorBorder: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            // fillColor: Colors.grey,
            borderSide: const BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
          ),
          disabledBorder: const OutlineInputBorder(),
          focusedErrorBorder: const OutlineInputBorder(),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
      ),
    );
  }
}
