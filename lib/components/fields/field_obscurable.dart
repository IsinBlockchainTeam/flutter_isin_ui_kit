import 'package:flutter/material.dart';

class FieldObscurable extends StatefulWidget {
  final String labelText;
  final String text;
  final Color? iconColor;

  const FieldObscurable(
      {super.key, required this.labelText, this.text = "", this.iconColor});

  @override
  State<FieldObscurable> createState() => _FieldObscurableState();
}

class _FieldObscurableState extends State<FieldObscurable> {
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.text,
      obscureText: _obscured,
      readOnly: true,
      maxLines: _obscured ? 1 : null,
      decoration: InputDecoration(
        labelText: widget.labelText,
        isDense: true,
        // Reduces height a bit
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        prefixIcon: const Icon(Icons.lock_outline_rounded, size: 24),
        suffixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
          child: GestureDetector(
            onTap: _toggleObscured,
            child: Icon(
              _obscured
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              size: 24,
              color: widget.iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
