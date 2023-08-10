import 'package:flutter/material.dart';

class SearchtextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function()? onSearchPressed;
  const SearchtextField({
    super.key,
    required this.controller,
    this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return TextFormField(
      style: textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      controller: controller,
      cursorColor: Colors.grey.shade400,
      maxLines: 1,
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.text,
      onEditingComplete: onSearchPressed,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        fillColor: Colors.grey.shade300,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 12,
        ),
        counterText: "",
        hintText: "Search",
        hintStyle: textTheme.titleLarge!.copyWith(
          color: Colors.black,
          fontSize: 14,
        ),
      ),
    );
  }
}
