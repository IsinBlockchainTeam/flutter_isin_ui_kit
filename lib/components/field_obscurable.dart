import 'package:flutter/material.dart';

class FieldObscurable extends StatefulWidget {
  final String labelText;
  final String text;
  final double expandedHeight;

  const FieldObscurable(
      {super.key,
      required this.labelText,
      this.expandedHeight = 130,
      this.text = ""});

  @override
  State<FieldObscurable> createState() => _FieldObscurableState();
}

class _FieldObscurableState extends State<FieldObscurable> {
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _obscured ? null : widget.expandedHeight,
      child: TextFormField(
        // canRequestFocus: false,
        focusNode: textFieldFocusNode,
        initialValue: widget.text,
        obscureText: _obscured,
        readOnly: true,
        expands: !_obscured,
        maxLines: _obscured ? 1 : null,
        enabled: true,
        decoration: InputDecoration(
          labelText: widget.labelText,
          isDense: true,
          // Reduces height a bit
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          prefixIcon: const Icon(Icons.lock_rounded, size: 24),
          suffixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
            child: GestureDetector(
              onTap: _toggleObscured,
              child: Icon(
                _obscured
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
