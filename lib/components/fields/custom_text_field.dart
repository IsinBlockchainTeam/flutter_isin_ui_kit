import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String value;
  final double borderRadius;
  final Color? labelColor;

  const CustomTextField(
      {super.key,
      required this.label,
      required this.value,
      this.labelColor,
      this.borderRadius = 10});

  Widget? buildPrefixIcon(BuildContext context) {
    return null;
  }

  Widget? buildSuffixIcon(BuildContext context) {
    return null;
  }

  Widget buildTextField(BuildContext context) {
    return TextFormField(
      initialValue: value,
      readOnly: true,
      maxLines: null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: labelColor,
        ),
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        prefixIcon: buildPrefixIcon(context),
        suffixIcon: buildSuffixIcon(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildTextField(context);
  }
}
