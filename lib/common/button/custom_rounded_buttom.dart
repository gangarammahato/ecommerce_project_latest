import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  const CustomRoundedButton({
    super.key,
    this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey.shade400,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      elevation: 5,
      child: InkWell(
        onTap: onPressed,
        splashColor: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
